/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran algunas restricciones las cuales 
permitiran validar algunos campos de la base de datos.
*/


/*------------------------------------------------*/
/*Validar el campo rol de la tabla tusuarios
en el cual los posibles roles son 1, 2 y 3*/
/*-----------------------------------------------*/
DELIMITER //
DROP PROCEDURE IF EXISTS CHK_user_rol;
CREATE PROCEDURE CHK_user_rol(
IN rol CHAR(1)
)
BEGIN
SET @caracter= ASCII(rol);
IF @caracter<49 OR @caracter>51 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Ingresa un rol valido. roles:1,2,3';
END IF;
END//
DELIMITER ;


DELIMITER //
DROP TRIGGER IF EXISTS tg_users_rol_BI;
CREATE TRIGGER tg_users_rol_BI BEFORE INSERT 
ON users FOR EACH ROW
BEGIN
	CALL CHK_user_rol(new.rol);
END//
DELIMITER ;
/*------------------------------------------------*/