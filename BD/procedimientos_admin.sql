/*
-------------------------------
---- Autor:Murillo Mario ------
-------------------------------
En este archivo se encuentran todos los procedimientos almacenados 
que hacen operaciones que solo los administradores pueden realizar.




/*-----------------------------------------------------*/
/*------------ REGISTRO DE LLAVES Y SALON ------------*/
/*---------------------------------------------------*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_llave;
CREATE PROCEDURE sistema_llaves.sp_registrar_llave (
	in p_codigo BIGINT(20),
	in p_numero INT(11),
	in p_area VARCHAR(8),
	in p_aula VARCHAR(8)
)
BEGIN
	IF NOT EXISTS(SELECT * FROM sistema_llaves.taulas WHERE area=UPPER(p_area) and aula=p_aula) THEN
		INSERT INTO sistema_llaves.taulas(id,numero,area,aula) VALUES (null,p_numero,UPPER(p_area),p_aula);
	END IF;
	SELECT @var1 := id FROM sistema_llaves.taulas WHERE aula=p_aula AND area=p_area;
	INSERT INTO sistema_llaves.tllaves(id,codigo,id_aula) VALUES (null, p_codigo,@var1);
END
//
DELIMITER ;


/*-----------------------------------------------------*/
/*--------------- REGISTRO DE MAESTROS ---------------*/
/*---------------------------------------------------*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_maestro;
CREATE PROCEDURE sistema_llaves.sp_registrar_maestro (
	in p_num_emp INT, 
	in p_nombre VARCHAR(70)
)
BEGIN
	INSERT INTO sistema_llaves.tmaestros(id,num_emp,nombre) VALUES (null,p_num_emp,UPPER(p_nombre));
END
//
DELIMITER ;


/*-----------------------------------------------------*/
/*---------------- REGISTRO DE MATERIAS---------------*/
/*---------------------------------------------------*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_materia;
CREATE PROCEDURE sistema_llaves.sp_registrar_materia (
	in p_nombre VARCHAR(50),
	in p_programa VARCHAR(10))
BEGIN
	INSERT INTO sistema_llaves.tmaterias(id,nombre,programa) VALUES (null, UPPER(p_nombre), UPPER(p_programa));
END 
//
DELIMITER ;

/*-----------------------------------------------------*/
/*---------------- REGISTRO DE HORARIOS --------------*/
/*---------------------------------------------------*/
/*Registro de horario*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_horario;
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

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	end if;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaterias WHERE nombre=UPPER(p_nombre_mat)) THEN
		SIGNAL SQLSTATE '46001'
		SET MESSAGE_TEXT='La materia indicada no se encuentra registrada.';
	end if;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) THEN
		SIGNAL SQLSTATE '46002'
		SET MESSAGE_TEXT='EL maestro indicado no se encuentra registrado.';
	end if;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tdias WHERE dias=UPPER(p_dias)) THEN
		INSERT INTO sistema_llaves.tdias (id,dias) values(null,UPPER(p_dias));
	end if;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin) THEN
		INSERT INTO sistema_llaves.thoras(id,hora_inicio,hora_fin) VALUES (null,p_hora_inicio,p_hora_fin);
	end if;

	SELECT @var1 := id FROM sistema_llaves.tdias WHERE dias=UPPER(p_dias);
	SELECT @var2 := id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tdias_horas WHERE idDias=@var1 AND idHoras=@var2) THEN
		INSERT INTO sistema_llaves.tdias_horas (id,idDias,idHoras) VALUES (null,@var1, @var2);
	end if;

	SELECT @var3 := id FROM sistema_llaves.tmaterias WHERE nombre=p_nombre_mat;
	SELECT @var4 := id FROM tdias_horas WHERE idDias=@var1 and idHoras=@var2;

	INSERT INTO sistema_llaves.thorarios(id,year,ciclo,codigo_llave,num_emp_maestro,id_materia,id_dias_horas)
	VALUES (null,p_year,p_ciclo,p_codigo_llave,p_num_emp_maestro,@var3,@var4);

	SET @var1 = NULL;
	SET @var2 = NULL;
	SET @var3 = NULL;
	SET @var4 = NULL;

END
//
DELIMITER ;
