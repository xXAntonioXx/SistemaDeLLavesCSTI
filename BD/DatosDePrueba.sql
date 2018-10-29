/*
******************************************
ESTA MANERA SERIA SIN EL PROCEDIMIENTO
******************************************
INSERT INTO taulas(id,area,aula) VALUES 
(null, "5j","201"),
(null, "5j","202"),
(null, "5j","203");

INSERT INTO tllaves(id,codigo,numero,id_aula) VALUES
(null,22222222,10,2),
(null,33333333,9,2),
(null,44444444,9,2);
*/

/*Registra una llave y el aula en caso de no existir*/
CALL sp_registrar_llave(22222222,8,"5j","201");
CALL sp_registrar_llave(33333333,9,"5j","202");
CALL sp_registrar_llave(44444444,10,"5j","203");
CALL sp_registrar_llave(55555555,11,"5j","204");




/*Registrar un horario*/
CALL sp_registrar_dias_horas();