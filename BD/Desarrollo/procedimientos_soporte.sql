/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos que se utilizarán en la sección
de soporte, con la finalidad de tener un mejor control de todos los procedimientos que lleva el proyecto.
*/

/*-----------------------------------------------------*/
/*------- OBTENER REPORTES-----*/
/*---------------------------------------------------*/
DROP PROCEDURE IF EXISTS sp_obtener_reportes_para_soporte;
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_obtener_reportes_para_soporte(
)
BEGIN
    SELECT tr.id,tr.fecha_registro as fecha,CONCAT(ta.area,'-',ta.aula) as aula, tr.descripcion,if(fecha_inicio IS NULL,'Pendiente','En progreso') as estatus FROM treportes as tr INNER JOIN taulas as ta ON tr.num_aula=ta.numero WHERE tr.fecha_fin IS NULL;
END
//
DELIMITER ;

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
  in p_numAula INT(11)
)
BEGIN
  IF(p_descripcion IS NULL OR LENGTH(TRIM(p_descripcion))<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico una descripción.';
  END IF;


  IF(p_numAula IS NULL OR p_numAula<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico el número de aula';
  END IF;

  
  IF EXISTS(SELECT numero from taulas where numero=p_numAula)THEN
    INSERT INTO treportes(fecha_registro,fecha_inicio,fecha_fin,descripcion,num_aula) VALUES(NOW(),null,null,CONCAT(UPPER(LEFT(p_descripcion,1)),LOWER(SUBSTR(p_descripcion,2))),p_numAula);
  ELSE
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se encontro registro con el aula o edificio especificado. Comuniquese con el administrador.';
  END IF;
END
//
DELIMITER ;


/*-----------------------------------------------------*/
/*------- OBTIENE LAS LLAVES PARA LA MODAL DE REGISTRO DE REPORTES-----*/
/*---------------------------------------------------*/

DROP PROCEDURE IF EXISTS sp_obtener_llaves_para_reportes;
DELIMITER //
CREATE PROCEDURE IF EXISTS sistema_llaves.sp_obtener_llaves_para_reportes(
)
BEGIN
  SELECT numero,CONCAT(area,'-',aula) as aula FROM taulas order by aula asc;
END
//
DELIMITER ;