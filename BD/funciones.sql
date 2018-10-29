/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran toda la estructura de la BD.
*/


/*NO FUNCIONAAAAAAA*/
* from sistema_llaves.tobjetos;
delimiter //
CREATE procedure prueba(
	in p_codigo_llave BIGINT(20), out)
BEGIN 
 	select CONCAT(nombre,apellido),apellido,edad,fehcaNac;
END //