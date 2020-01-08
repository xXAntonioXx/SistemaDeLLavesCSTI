/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos que se utilizarán en la sección
de soporte, con la finalidad de tener un mejor control de todos los procedimientos que lleva el proyecto.
*/

/*-----------------------------------------------------*/
/*------- REGISTRAR REPORTE-----*/
/*---------------------------------------------------*/
/*Con este procedimiento se podra hacer un registro de
de reporte el cual será atendido por los miembros del CSTI
*/

DROP PROCEDURE IF EXISTS sp_registrar_reporte;
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_reporte(
  in p_descripcion VARCHAR(255),
  in p_edificio varchar(3),
  in p_salon int(11)
)
BEGIN
  IF(p_descripcion IS NULL OR LENGTH(TRIM(p_descripcion))<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico una descripción.';
  END IF;

  IF(p_edificio IS NULL OR LENGTH(TRIM(p_edificio))<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico un edificio.';
  END IF;

  IF(p_salon IS NULL OR LENGTH(TRIM(p_salon))<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico el número de aula';
  END IF;

  SELECT numero INTO @numAula from taulas where area=UPPER(p_edificio) and aula=p_salon;
  IF (@numAula IS NOT NULL AND @numAula>0)THEN
    INSERT INTO treportes(fecha_registro,fecha_inicio,fecha_fin,descripcion,num_aula) VALUES(NOW(),null,null,LOWER(p_descripcion),@numAula);
  ELSE
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se encontro registro con el aula o edificio especificado. Comuniquese con el administrador.';
  END IF;
END
//
DELIMITER ;