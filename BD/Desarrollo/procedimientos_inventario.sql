
/*-----------------------------------------------------*/
/*---------------- REGISTRO DE OBJETOS ---------------*/
/*---------------------------------------------------*/
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
INSERT INTO sistema_llaves.tobjetos(id,nombre,marca,inventario)
VALUES (null,UPPER(p_nombre),UPPER(p_marca),p_inventario);
END
//
DELIMITER ;


