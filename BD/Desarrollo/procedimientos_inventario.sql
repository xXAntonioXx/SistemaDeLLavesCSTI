
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
	in p_descripcion VARCHAR(255),
	in p_inventario INT(11)
) 
BEGIN
INSERT INTO sistema_llaves.tobjetos(id,nombre,marca,descripcion,inventario)
VALUES (null,UPPER(p_nombre),UPPER(p_marca),UPPER(p_descripcion),p_inventario);
END
//
DELIMITER ;


/*-----------------------------------------------------*/
/*---------------------- EDITAR ---------------------*/
/*---------------------------------------------------*/

DELIMITER //
DROP PROCEDURE IF EXISTS sp_editar_objeto;
CREATE PROCEDURE sistema_llaves.sp_editar_objeto(
	IN p_id_objeto INT(11),
	in p_nombre VARCHAR(50),
	in p_marca VARCHAR(50),
	in p_descripcion VARCHAR(255),
	in p_inventario INT(11)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM tobjetos WHERE id=p_id_objeto) THEN
		SIGNAL SQLSTATE '46010'
		SET MESSAGE_TEXT="El objeto no se encuentra en la base de datos.";
	END IF;
	CASE
		WHEN p_nombre IS NOT NULL AND p_marca IS NULL AND p_descripcion IS NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre WHERE id=p_id_objeto;
		
		WHEN p_nombre IS NULL AND p_marca IS NOT NULL AND p_descripcion IS NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET marca=p_marca WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NULL AND p_descripcion IS NOT NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET descripcion=p_descripcion WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NULL AND p_descripcion IS NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NOT NULL AND p_descripcion IS NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,marca=p_marca WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NULL AND p_descripcion IS NOT NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,descripcion=p_descripcion WHERE id=p_id_objeto;
	
		WHEN p_nombre IS NOT NULL AND p_marca IS NULL AND p_descripcion IS NULL AND p_inventario IS NOT NULL NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NOT NULL AND p_descripcion IS NOT NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET marca=p_marca,descripcion=p_descripcion WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NOT NULL AND p_descripcion IS NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET marca=p_marca,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NULL AND p_descripcion IS NOT NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET descripcion=p_descripcion,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NOT NULL AND p_descripcion IS NOT NULL AND p_inventario IS NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,marca=p_marca,descripcion=p_descripcion WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NOT NULL AND p_descripcion IS NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,marca=p_marca,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NULL AND p_descripcion IS NOT NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,descripcion=p_descripcion,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NULL AND p_marca IS NOT NULL AND p_descripcion IS NOT NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET marca=p_marca,descripcion=p_descripcion,inventario=p_inventario WHERE id=p_id_objeto;

		WHEN p_nombre IS NOT NULL AND p_marca IS NOT NULL AND p_descripcion IS NOT NULL AND p_inventario IS NOT NULL THEN
			UPDATE sistema_llaves.tobjetos SET nombre=p_nombre,marca=p_marca,descripcion=p_descripcion,inventario=p_inventario WHERE id=p_id_objeto;

	END CASE;

END
//
DELIMITER ;




/*-----------------------------------------------------*/
/*----------------- ELIMINAR OBJETO ------------------*/
/*---------------------------------------------------*/

DELIMITER //
DROP PROCEDURE IF EXISTS sistema_llaves.sp_eliminar_objeto;
CREATE PROCEDURE sistema_llaves.sp_eliminar_objeto (
	IN p_id_objeto INT(11)
)
BEGIN
	IF p_id_objeto IS NOT NULL AND EXISTS(SELECT id FROM tobjetos WHERE id=p_id_objeto) THEN
		DELETE FROM sistema_llaves.tobjetos WHERE id=p_id_objeto;
	ELSE
		SIGNAL SQLSTATE '46010'
		SET MESSAGE_TEXT="El objeto no se encuentra en la base de datos.";
	END IF;
END
//
DELIMITER ;
