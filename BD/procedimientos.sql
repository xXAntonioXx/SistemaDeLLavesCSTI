/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos
almacenados que realizara la base de datos
*/


/*--------------TERMINADO--------------*/
/*Registro de una llave en la base de datos*/
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
		INSERT INTO sistema_llaves.taulas(id,area,aula) VALUES (null,UPPER(p_area),p_aula);
	END IF;
	SELECT @var1 := id FROM sistema_llaves.taulas WHERE aula=p_aula AND area=p_area;
	INSERT INTO sistema_llaves.tllaves(id,codigo,numero,id_aula) VALUES (null, p_codigo,p_numero,@var1);
END
//
DELIMITER;



/*--------------TERMINADO--------------*/
/*Registro de un maestro en la base de datos*/
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
DELIMITER;


/*Registro de una materia en la base de datos*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_materia;
CREATE PROCEDURE sistema_llaves.sp_registrar_materia (
	in p_nombre VARCHAR(50),
	in p_programa VARCHAR(10))
BEGIN
	INSERT INTO sistema_llaves.tmaterias(id,nombre,programa) VALUES (null, UPPER(p_nombre), UPPER(p_programa));
END 
//
DELIMITER;


/*--------------TERMINADO--------------*/
/*Registro de un horario "*/
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
	/*Valida que la llave exista*/
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	end if;

	/*Valida que */
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaterias WHERE nombre=UPPER(p_nombre_mat)) THEN
		SIGNAL SQLSTATE '46001'
		SET MESSAGE_TEXT='La materia indicada no se encuentra registrada.';
	end if;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) THEN
		SIGNAL SQLSTATE '46002'
		SET MESSAGE_TEXT='La maestro indicado no se encuentra registrado.';
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



/*--------------TERMINADO--------------*/
/*Registro de un prestamo*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_prestamo;
CREATE PROCEDURE sistema_llaves.sp_registrar_prestamo(
	in p_id_prestamo INT,	
	in p_id_objeto_arg VARCHAR(1000)
)
BEGIN
	/*Almacena el valor de entrada en una variable de usuario*/
	DECLARE p_id_control INT(11) DEFAULT 1;
	DECLARE p_mensaje VARCHAR(500) DEFAULT ''; 
	DECLARE p_arreglo VARCHAR(500);
	SET p_arreglo = p_id_objeto_arg;

	SET @num = LENGTH(p_arreglo);
	IF (@num = 0) THEN 
		SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se ingreso ningun objeto.';
	END IF;
	
	/*Asignar el ID a la variable "id_prest"*/
	/*que del registro que se almacenara*/

	IF p_id_prestamo=0 THEN 
		IF NOT EXISTS (SELECT id FROM sistema_llaves.tprestamos) THEN
			SET @id_prest = 1;
		ELSE
			SELECT @id_prest:= max(id) FROM sistema_llaves.tprestamos;
			SET @id_prest= @id_prest + 1;
		END IF;
	ELSE
		SELECT  @id_prest := MAX(id_control) FROM sistema_llaves.tprestamos WHERE id=@id_prest;
		SET p_id_control = @id_prest + 1;
		SET @id_prest = p_id_prestamo;
	END IF;
	
	/*Calcular la cantidad de objetos a registrar*/
	SET @num =(LENGTH(p_arreglo) - LENGTH(REPLACE(p_arreglo, ',', '')))+1;
	
	/*En este bloque de codigo lo que se hace*/
	/*es ir agregando los prestamos.*/
	/*En el caso de que solo se detecte un*/
	/*objeto se realiza la parte dei IF*/
	/*Si son mas de un objeto se realiza la */
	/*parte de el ELSE IF*/
	IF @num = 1 THEN
		IF NOT EXISTS (SELECT id FROM sistema_llaves.tobjetos WHERE id=p_arreglo) THEN
			SET p_mensaje = CONCAT("El objeto con id ",p_arreglo, " no se encuentra en la base de datos.");
			SIGNAL SQLSTATE '46004'
			SET MESSAGE_TEXT= p_mensaje;
		ELSE
			INSERT INTO sistema_llaves.tprestamos(id,id_control,id_objeto,estado) VALUES (@id_prest,p_id_control,p_arreglo,DEFAULT);
		END IF;
	ELSEIF @num > 1 THEN
		SET p_arreglo= CONCAT(p_arreglo,",");
		WHILE @num > 0 DO
			SET @argTemp=SUBSTRING(p_arreglo,1,LOCATE(",",p_arreglo)-1);
			
			IF NOT EXISTS(SELECT id FROM sistema_llaves.tobjetos WHERE id=CAST(@argTemp AS INT)) THEN
				SET p_mensaje= CONCAT(p_mensaje,"El producto ", @argTemp," no se encuentra en la base de datos. ");
			ELSE
				INSERT INTO sistema_llaves.tprestamos(id,id_control,id_objeto,estado) VALUES (@id_prest,p_id_control,CAST(@argTemp AS INT),DEFAULT);
				SET p_id_control= p_id_control + 1;
			END IF;
			SET @num = @num - 1;
			
			IF (@num >0) THEN
				SET p_arreglo := SUBSTRING(p_arreglo,LOCATE(",",p_arreglo)+1,LENGTH(p_arreglo));
			END IF;
		END WHILE;
	ELSE
		SIGNAL SQLSTATE '46005'
		SET MESSAGE_TEXT='Error: Hay un problema en la cadena introducida.';
	END IF;


	SET @num:= LENGTH(p_mensaje);
	IF (@num>0) THEN
		SIGNAL SQLSTATE '46006'
		SET MESSAGE_TEXT= p_mensaje;
	END IF;
	
	/*SELECT @VALOR := SUBSTRING(@VALOR,LOCATE(",",@VALOR)+1,LENGTH(@VALOR));

	INSERT INTO tprestamos(id,id_control,id_objeto,estado) VALUES (null,p_id,p_id_objeto,false);
	*/
END;
//
DELIMITER ;



/*---------------EN PROCESO----------------*/
/*Registro un prestamo en la base de datos*/
CREATE PROCEDURE sistema_llaves.sp_registrar_prestamo(p_hora_entrada,p_id_horariop_)



