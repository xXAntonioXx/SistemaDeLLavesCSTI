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

/*Registra llaves (y el aula en caso de no existir)*/
CALL sp_registrar_llave(22222222,8,"5J","201");
CALL sp_registrar_llave(33333333,9,"5J","202");
CALL sp_registrar_llave(44444444,24,"5J","203");
CALL sp_registrar_llave(55555555,10,"5J","204");
CALL sp_registrar_llave(66666666,7,"5K","204");
CALL sp_registrar_llave(77777777,23,"5K","102");
CALL sp_registrar_llave(88888888,22,"5K","203");
CALL sp_registrar_llave(99999999,21,"5G","204");
CALL sp_registrar_llave(10101010,18,"5G","101");
CALL sp_registrar_llave(11111111,15,"5G","103");
CALL sp_registrar_llave(12121212,14,"5G","204");


/*Registrar maestros*/
CALL sp_registrar_maestro(65654,"Jorge RomerO");
CALL sp_registrar_maestro(65655,"francisco Navarro");
CALL sp_registrar_maestro(65656,"ALVARO valuenzuela");
CALL sp_registrar_maestro(65657,"Raquel torres");
CALL sp_registrar_maestro(65658,"Francisco cirett");


/*Rgistrar materias*/
call sp_registrar_materia("SERVIDORES","ISI");
call sp_registrar_materia("base de datos1","ISI");
call sp_registrar_materia("Aplicaciones moviles","ISI");
call sp_registrar_materia("Mineria de datos","ISI");
call sp_registrar_materia("Introduccion al software de base","ISI");


/*Registrar horarios*/
call sp_registrar_horario(99999999,'2018','3',65654,"SERVIDORES","LUNES,MARTES,MIERCOLES,jueves",'07:00:00',"08:00:00");
call sp_registrar_horario(99999999,'2018','3',65655,"base de datos1","LUNES,MARTES,MIERCOLES,jueves,viernes",'09:00:00','10:00:00');
call sp_registrar_horario(44444444,'2018','3',65656,"Aplicaciones moviles","LUNES,MARTES,MIERCOLES,jueves",'16:00:00','17:00:00');
call sp_registrar_horario(33333333,'2018','3',65657,"Mineria de datos","LUNES,MARTES,MIERCOLES,jueves",'12:00:00',"13:00:00");
call sp_registrar_horario(33333333,'2018','3',65658,"Introduccion al software de base","LUNES,MARTES,MIERCOLES,jueves,viernes",'07:00:00','08:00:00');


/*Registrar Objetos*/
call sp_registrar_objeto("Control-A/C","mirage",5);
call sp_registrar_objeto("Control-A/C","YORK",5);
call sp_registrar_objeto("Control-Cañon","Epson",5);
call sp_registrar_objeto("bocinas","lanix",5);

/*Registrar prestamo*/
call sp_registrar_prestamo(0,"1,3,2");

SELECT * from tusuarios;
