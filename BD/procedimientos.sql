/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos
almacenados que realizara la base de datos.
*/

/*Registro de una llave en la base de datos*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_llave (
	in p_codigo BIGINT(20),
	in p_numero INT(11),
	in p_area VARCHAR(8),
	in p_aula VARCHAR(8)
)
BEGIN
	if not exists(SELECT * FROM sistema_llaves.taulas WHERE area=p_area and aula=p_aula)then
		INSERT INTO sistema_llaves.taulas(id,area,aula) VALUES (null,p_area,p_aula);
	end if;
	
	SELECT @var1 := id FROM sistema_llaves.taulas WHERE aula=p_aula AND area=p_area;

	INSERT INTO sistema_llaves.tllaves(id,codigo,numero,id_aula) VALUES (null, p_codigo,p_numero,@var1);
END
//
DELIMITER;



/*Registro de un maestro en la base de datos*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_maestro (
	in p_num_emp INT, 
	in p_nombre VARCHAR(70),
	in p_imagen TEXT)
BEGIN
INSERT INTO sistema_llaves.tmaestros(id,num_emp,nombre,imagen) VALUES (null,p_num_emp,p_nombre,p_imagen);
END
//
DELIMITER;


/*Registro de una materia en la base de datos*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_materia (
	in p_nombre VARCHAR(50),
	in p_programa VARCHAR(10))
BEGIN
INSERT INTO sistema_llaves.tmaterias(id,nombre,programa) VALUES (null, p_nombre, p_programa);
END 
//
DELIMITER;

/*Registro de un horario "*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_horario(
	in p_codigo_llave BIGINT(20),
	in p_year YEAR(4),
	in p_ciclo CHAR(1),
	in p_num_emp_maestro INT,
	in p_nombre_mat VARCHAR(150),
	in p_dias VARCHAR(50),
	in p_hora_inicio TIME,
	in p_hora_fin TIME
)
BEGIN
	/*Valida que la llave exista*/
	if not exists (SELECT id FROM sistema_llaves.tllaves WHERE nombre=p_codigo_llave) then
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	end if;

	/*Valida que */
	if not exists (SELECT id FROM sistema_llaves.tmateria WHERE nombre=p_nombre_mat) then
		SIGNAL SQLSTATE '46001'
		SET MESSAGE_TEXT='La materia indicada no se encuentra registrada.';
	end if;

	if not exists (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) then
		SIGNAL SQLSTATE '46002'
		SET MESSAGE_TEXT='La maestro indicado no se encuentra registrado.';
	end if;

	if not exists (SELECT id FROM sistema_llaves.tdias WHERE dias=p_dias) then
		INSERT INTO sistema_llaves.tdias (id,dias) values(null,p_dias);
	end if;

	if not exists (SELECT id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin) then
		INSERT INTO sistema_llaves.thoras(id,hora_inicio,hora_fin) VALUES (null,p_hora_inicio,p_hora_fin);
	end if;

	SELECT @var1 := id FROM sistema_llaves.tdias WHERE dias=p_dias;
	SELECT @var2 := id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin;

	if not exists (SELECT dh.id FROM sistema_llaves.tdias_horas as dh  INNER JOIN sistema_llaves.tdias as d on dh.idDias = d.id INNER JOIN  bd_sistema_llaves.thoras as h on dh.idHoras = h.id) then
		INSERT INTO sistema_llaves.tdias_horas (id,idDias,idHoras) VALUES (null,@var1, @var2);
	end if;

	SELECT @var3 := id FROM sistema_llaves.tmateria WHERE nombre=p_nombre_mat;
	SELECT @var4 := id FROM tdias_horas WHERE idDias=@var1 and idHoras=@var2;

	INSERT INTO sistema_llaves.thorarios(id,year,ciclo,codigo_llave,num_emp_maestro,id_materia,id_dias_horas)
	VALUES (null,p_year,p_ciclo,p_codigo_llave,p_num_emp_maestro,@var3,@var4);

END
//
DELIMITER;


/*Registro de un objeto en la base de datos*/
/*CREATE DEFINER = CURRENT_USER PROCEDURE....*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_objeto (
	in p_nombre VARCHAR(50),
	in p_marca VARCHAR(50),
	in p_inventario INT(11)
) 
BEGIN
INSERT INTO sistema_llaves.tobjetos(id,nombre,marca,inventario) VALUES (null,p_nombre,p_marca,p_inventario);
END
//
DELIMITER;


/*Registro de un prestamo*/
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_prestamo(
	in p_can_objetos INT
	in p_id_objeto_arg VARCHAR()
)
BEGIN
	
	IF NOT EXISTS (SELECT id FROM tobjetos WHERE id=p_id_objeto) THEN 
		SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='El objeto no se encuentra registrado'
	END IF;

	SELECT @VALOR := SUBSTRING(@VALOR,LOCATE(",",@VALOR)+1,LENGTH(@VALOR));

	INSERT INTO tprestamos(id,id_control,id_objeto,estado) VALUES (null,p_id,p_id_objeto,false);
END
//



/*Registro un prestamo en la base de datos*/
CREATE PROCEDURE sistema_llaves.sp_registrar_prestamo(p_hora_entrada,p_id_horariop_)






