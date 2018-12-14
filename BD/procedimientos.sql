/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos
almacenados que realizara la base de datos



-------------N O T A #1--------
la estructura del procedimiento es:
CREATE PROCEDURE [DBname].[ProcName](
	[parametros de entrada.]
)
BEGIN
-------CUERPO DEL PROCEDIMIENTO------
END


-------------N O T A #2--------
COMO LLAMAR UN PROCEDIMIENTO:
CALL [ProcName]([param1],[param2]...);

-los parametros se envian segun el tipo de dato
si es entero se envia solo el numero
-si es texto se encia entre comillas simples o
dobles
-si es fecha se envia entre comillas simples
*/



/*--------------TERMINADO--------------*/
/*Este procedimineto se encarga de 
registrar una llave y su respectivo salon
en caso de no estar regisrado. Si el salon
ya se encuentra registrado, simplemente se
realiza una busqueda del 'id' del salon ya 
registrado y se coloca su en el nuevo 
registro de la llave.
*/

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



/*--------------TERMINADO--------------*/
/*El siguiente metodo simplemente se encarga
de registrar a un maestro en la base de datos
y como se puede observar tan solo recibe
dos parametros.*/
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



/*--------------TERMINADO--------------*/
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
DELIMITER ;


/*--------------TERMINADO--------------*/
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

/*--------------TERMINADO--------------*/
/*Registro de un objeto en la base de datos*/
/*CREATE DEFINER = CURRENT_USER PROCEDURE....*/
DELIMITER //

DROP  PROCEDURE IF EXISTS sp_registrar_objeto;
CREATE PROCEDURE sistema_llaves.sp_registrar_objeto (
	in p_nombre VARCHAR(50),
	in p_marca VARCHAR(50),
	in p_inventario INT(11)
) 
BEGIN
INSERT INTO sistema_llaves.tobjetos(id,nombre,marca,inventario) VALUES (null,UPPER(p_nombre),UPPER(p_marca),p_inventario);
END
//
DELIMITER ;




/*---------------TERMINADO----------------*/
/*Consulta para cargar la  seccion de llaves
 prestadas en la pagina de registro*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_get_llavesPrestadas;
 CREATE PROCEDURE sistema_llaves.sp_get_llavesPrestadas()
 BEGIN
 	SELECT r.id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(au.area,"-",au.aula) as salon, r.hora_entrada, r.hora_salida
	FROM sistema_llaves.tregistros AS r 
	INNER JOIN sistema_llaves.thorarios AS h ON r.id_horario = h.id
	INNER JOIN sistema_llaves.tmaestros AS mae ON h.num_emp_maestro = mae.num_emp
	INNER JOIN sistema_llaves.tmaterias AS mat ON h.id_materia = mat.id
	INNER JOIN sistema_llaves.tllaves AS ll ON h.codigo_llave = ll.codigo
	INNER JOIN sistema_llaves.taulas AS au ON au.id=ll.id_aula
	WHERE r.hora_entrada >= CURDATE() and r.hora_salida IS NULL;
 END
//
DELIMITER ;


/*---------------TERMINADO----------------*/
/*FORMATO DE LA HORA yyyy-MM-DD HH:MM:SS*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_get_frmPrestamo;
CREATE PROCEDURE sistema_llaves.sp_get_frmPrestamo(
	in p_codigo_llaves BIGINT(20),	
	in p_hora TIMESTAMP
)
 BEGIN
 	DECLARE expresion VARCHAR(9) DEFAULT 'null';
 	IF CONVERT(MINUTE(p_hora),UNSIGNED) > 39 THEN
 		SET p_hora = p_hora + INTERVAL (60 - CONVERT(MINUTE(p_hora),UNSIGNED)) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	ELSE 
 		SET p_hora = p_hora - INTERVAL CONVERT(MINUTE(p_hora),UNSIGNED) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	END IF;

 	SET expresion = (ELT(WEEKDAY(p_hora) + 1, 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO'));
 	SELECT ho.id AS id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(aul.area,'-',aul.aula) AS aula
 	FROM thorarios AS ho
 	INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.codigo = ho.codigo_llave
 	INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.id = llav.id_aula
 	INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
 	INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
 	INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
 	INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
 	INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras
 	WHERE ho.codigo_llave=p_codigo_llaves AND ho.ciclo=3 
 	AND ho.year=YEAR(p_hora) AND tho.hora_inicio=TIME(p_hora)
 	AND tdi.dias LIKE  CONCAT('%',expresion,'%');
 END
//
DELIMITER ;



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
		SELECT  @id_prest := MAX(id_control) FROM sistema_llaves.tprestamos WHERE id=p_id_prestamo;
		SET p_id_control = @id_prest + 1;
		SET @id_prest = p_id_prestamo;
	END IF;
	
	/*Calcular la cantidad de objetos a registrar*/
	SET @num =(LENGTH(p_arreglo) - LENGTH(REPLACE(p_arreglo, ',', '')))+1;
	
	/*En este bloque de codigo lo que se hace*/
	/*es ir agregando los prestamos.*/
	/*En el caso de que solo se detecte un*/
	/*objeto se realiza la parte del IF*/
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
			
			IF NOT EXISTS(SELECT id FROM sistema_llaves.tobjetos WHERE id=CAST(@argTemp AS SIGNED INTEGER)) THEN
				SET p_mensaje= CONCAT(p_mensaje,"El producto ", @argTemp," no se encuentra en la base de datos. ");
			ELSE
				INSERT INTO sistema_llaves.tprestamos(id,id_control,id_objeto,estado) VALUES (@id_prest,p_id_control,CAST(@argTemp AS SIGNED INTEGER),DEFAULT);
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

	SET @num = LENGTH(p_mensaje);
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

/*--------------TERMINADO--------------*/
/*Registro una excepcion en la base de datos*/
DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_excepcion;
CREATE PROCEDURE sistema_llaves.sp_registrar_excepcion(
	in p_codigo_llave BIGINT(20),
	in p_num_emp_maestro INT
)
BEGIN
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	end if;


	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) THEN
		SIGNAL SQLSTATE '46002'
		SET MESSAGE_TEXT='EL maestro indicado no se encuentra registrado.';
	end if;

	INSERT INTO texcepciones(id,codigo_llave,num_emp) VALUES (null,p_codigo_llave,p_num_emp_maestro);

	SELECT @id_excepcion := MAX(id) FROM texcepciones;

END
//
DELIMITER ;


/*---------------TERMINADO----------------*/
/*Registro un prestamo de llave en la base de datos*/
/*

-------NOTA:--------
Si el registro lleva relacionada una excepcion
y/ó un prestamo.
Antes de ejecutar este procedimiento debe ejecutar
el procedimiento 'sp_registrar_excepcion' y/ó el 
procedimiento 'sp_registrar_prestamo'.
Por ultimo SIN CERRAR la conexion, procedemos 
a ejecutar este procedimiento.
ya que este procedimiento hace uso de 
variables declaradas por el usuario.

	
*/
DELIMITER //

DROP  PROCEDURE IF EXISTS sp_registrar_registro;
CREATE PROCEDURE sistema_llaves.sp_registrar_registro(
	in p_hora_entrada TIMESTAMP,
	in p_id_horario  INT(11),
	in p_id_usuario INT(11)
)
 BEGIN
 	CASE
 		WHEN (p_id_horario > 0) AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NOT NULL) THEN 
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,@id_excepcion,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NULL) THEN 
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,null,null,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NULL) THEN 
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,@id_excepcion,null,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NOT NULL) THEN
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,null,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NOT NULL) THEN
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,@id_excepcion,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NOT NULL) THEN
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,null,@id_prest,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NULL) THEN
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,null,null,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NULL) THEN
 			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,@id_excepcion,null,p_id_usuario);
 	END CASE;

 	SET @id_excepcion=null;
 	SET @id_prest=null;

END
//
DELIMITER ;



/*-------------------------  TERMINADO  ------------------------*/
/*----------------------------------------------------------------------*/
/*-------------------  ES DEVOLUCIN?? ---------------------------*/
/*--------------------------------------------------------------------*/


DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_esdevolucion;
CREATE PROCEDURE sistema_llaves.sp_get_esdevolucion(
	in p_codigo_llave INT(11)
)
BEGIN
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	END IF;

	IF EXISTS(
	SELECT * FROM tregistros AS reg
 	INNER JOIN sistema_llaves.thorarios   AS ho   ON ho.id=reg.id_horario 
 	INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.codigo = ho.codigo_llave
 	WHERE llav.codigo=p_codigo_llave and reg.hora_entrada>=from_unixtime(CURDATE(),'%Y-%m-%d') and reg.hora_salida IS NULL
 	) THEN
 		SELECT reg.id as id,mae.nombre, mat.nombre as materia, reg.hora_entrada,reg.id_prestamo 
 		FROM tregistros AS reg
 		INNER JOIN sistema_llaves.thorarios   AS ho   ON ho.id=reg.id_horario 
 		INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.codigo = ho.codigo_llave
 		INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
 		INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
 		WHERE llav.codigo=p_codigo_llave and UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(DATE(CURDATE())) AND UNIX_TIMESTAMP(CONCAT(DATE(CURDATE()),' 23:59:59')) and reg.hora_salida IS NULL;
 	ELSE
 		SELECT CAST(0 AS UNSIGNED INTEGER) AS id;
 	END IF;

END
//
DELIMITER ;



/*-------------------------  TERMINADO  ------------------------*/
/*----------------------------------------------------------------------*/
/*-------------------  OBTENER OBJETOS  ---------------------------*/
/*--------------------------------------------------------------------*/

DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_objetos;
CREATE PROCEDURE sistema_llaves.sp_get_objetos(
	in p_id_prestamo INT(11)
)
BEGIN
	DECLARE p_mensaje VARCHAR(500) DEFAULT '';
	SET p_mensaje =CONCAT('No existe prestamo con id: ', p_id_prestamo);
	IF NOT EXISTS (SELECT id_control FROM sistema_llaves.tprestamos WHERE id=p_id_prestamo) THEN
		SIGNAL SQLSTATE '46009'
		SET MESSAGE_TEXT=p_mensaje;
	END IF;
	SELECT prs.id_control AS id_control,prs.id_objeto as id_objeto,obj.nombre,obj.marca
	FROM tprestamos AS prs
	INNER JOIN tobjetos AS obj ON  obj.id=prs.id_objeto
	WHERE prs.id=p_id_prestamo;
END
//
DELIMITER ;



/*-------------------------  TERMINADO  ------------------------*/
/*----------------------------------------------------------------------*/
/*-------------------  DEVOLUCION LLAVE/OBJETOS  ---------------------------*/
/*--------------------------------------------------------------------*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_set_registro;
CREATE PROCEDURE sistema_llaves.sp_set_registro(
	in p_id_registro INT(11),
	in p_hora_salida TIMESTAMP,
	in p_id_prestamo INT(11),
	in p_id_control_arg VARCHAR(1000)
)
BEGIN
	DECLARE p_arreglo VARCHAR(500);
	SET p_arreglo = p_id_control_arg;

	SET @num = LENGTH(p_arreglo);
	IF (@num != 0) THEN 
		/*Calcular la cantidad de objetos para marcar su devolucion*/
		SET @num =(LENGTH(p_arreglo) - LENGTH(REPLACE(p_arreglo, ',', '')))+1;

		IF @num = 1 THEN
			UPDATE sistema_llaves.tprestamos SET estado=1 WHERE id=p_id_prestamo and id_control=p_arreglo;
		ELSEIF @num>1 THEN
			SET p_arreglo= CONCAT(p_arreglo,",");
			WHILE @num > 0 DO
				SET @argTemp=SUBSTRING(p_arreglo,1,LOCATE(",",p_arreglo)-1);

				UPDATE sistema_llaves.tprestamos SET estado=1 WHERE id=p_id_prestamo and id_control=CAST(@argTemp AS SIGNED INTEGER);

				SET @num = @num - 1;
				IF (@num >0) THEN
					SET p_arreglo := SUBSTRING(p_arreglo,LOCATE(",",p_arreglo)+1,LENGTH(p_arreglo));
				END IF;
			END WHILE;
		END IF;
	END IF;

	UPDATE sistema_llaves.tregistros SET hora_salida=p_hora_salida WHERE id=p_id_registro;

END
//
DELIMITER ;

/*https://manuales.guebs.com/mysql-5.0/error-handling.html*/
