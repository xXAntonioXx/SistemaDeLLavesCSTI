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
CALL sp_registrar_llave(100000001,1,"5K","101");
CALL sp_registrar_llave(100000002,2,"5K","102");
CALL sp_registrar_llave(100000003,3,"5K","201");
CALL sp_registrar_llave(100000004,4,"5K","202");
CALL sp_registrar_llave(100000005,5,"5K","203");
CALL sp_registrar_llave(100000006,6,"5K","204");
CALL sp_registrar_llave(100000007,7,"5K","205");
CALL sp_registrar_llave(100000008,8,"5K","301");
CALL sp_registrar_llave(100000009,9,"5K","302");
CALL sp_registrar_llave(100000010,10,"5K","303");
CALL sp_registrar_llave(100000011,11,"5K","304");
CALL sp_registrar_llave(100000012,12,"5K","305");
CALL sp_registrar_llave(100000013,13,"5K","201");
CALL sp_registrar_llave(100000014,14,"5M","202");
CALL sp_registrar_llave(100000015,15,"5M","203");
CALL sp_registrar_llave(100000016,16,"5M","205");
CALL sp_registrar_llave(100000017,17,"5M","206");
CALL sp_registrar_llave(100000018,18,"5M","101");
CALL sp_registrar_llave(100000019,19,"5G","102");
CALL sp_registrar_llave(100000020,20,"5G","201");
CALL sp_registrar_llave(100000021,21,"5G","202");
CALL sp_registrar_llave(100000022,22,"5G","203");
CALL sp_registrar_llave(100000023,23,"5G","204");
CALL sp_registrar_llave(100000024,24,"5G","205");


CALL sp_registrar_llave(100000036,36,"5J","201");
CALL sp_registrar_llave(100000037,37,"5J","202");
CALL sp_registrar_llave(100000038,38,"5J","203");
CALL sp_registrar_llave(100000039,39,"5J","204");
CALL sp_registrar_llave(100000040,40,"5J","301");
CALL sp_registrar_llave(100000041,41,"5J","302");
CALL sp_registrar_llave(100000042,42,"5J","303");
CALL sp_registrar_llave(100000043,43,"5J","304");
CALL sp_registrar_llave(100000044,44,"5J","305");





/*Registrar maestros*/
CALL sp_registrar_maestro(65654,"Jorge RomerO");
CALL sp_registrar_maestro(65655,"francisco Navarro");
CALL sp_registrar_maestro(65656,"ALVARO valuenzuela");
CALL sp_registrar_maestro(65657,"Raquel torres");
CALL sp_registrar_maestro(65658,"Francisco cirett");
CALL sp_registrar_maestro(65659,"ARACELI torres");
CALL sp_registrar_maestro(65660,"Isidro Torres");
CALL sp_registrar_maestro(65661,"Mario Barcelo");
CALL sp_registrar_maestro(65662,"GERARDO SANCHEZ");
CALL sp_registrar_maestro(65663,"alejandro valenzuela");

CALL sp_registrar_maestro(65664,"Isrrael Contreras");
CALL sp_registrar_maestro(65665,"Alfonso Romero");
CALL sp_registrar_maestro(65666,"Miguel Romero");
CALL sp_registrar_maestro(65667,"Ivan Amador");
CALL sp_registrar_maestro(65668,"Ivan chavez");
CALL sp_registrar_maestro(65669,"Ivan dosto");



/*Rgistrar materias*/
call sp_registrar_materia("SERVIDORES","ISI");
call sp_registrar_materia("PROGRAMACION VISUAL E INTERNET","ISI");
call sp_registrar_materia("TOPICOS AVANZADOS DE PROGRAMACION","ISI");
call sp_registrar_materia("GRAFICACION Y MULTIMEDIA","ISI");
call sp_registrar_materia("TOPICOS DE MATEMATICAS DISCRETAS","ISI");
call sp_registrar_materia("Mineria de datos","ISI");
call sp_registrar_materia("Introduccion al software de base","ISI");
call sp_registrar_materia("programacion PARA INGENIEROS 1","ISI");
call sp_registrar_materia("ESTRUCTURA DE DATOS","ISI");
call sp_registrar_materia("iNTELIGENCIA ARTIFICIAL","ISI");
call sp_registrar_materia("SISTEMAS BASADOS EN WEB","ISI");
call sp_registrar_materia("SISTEMAS DE INFORMACION","ISI");
call sp_registrar_materia("SIMULACION DE SISTEMAS","ISI");
call sp_registrar_materia("INVESTIGACION DE OPERACIONES","ISI");
call sp_registrar_materia("INGENIERIA DE SISTEMAS","ISI");
call sp_registrar_materia("planeacion estrategica","ISI");
call sp_registrar_materia("introduccion a la ing de istemas de informacion","ISI");
call sp_registrar_materia("analisis y diseño de sistemas","ISI");
call sp_registrar_materia("COSTOS EN LA INGENIERIA","ISI");



/*Registrar horarios*/
/*call sp_registrar_horario([COD-LLAVE],[AÑO-CILO],[CICLO: 1,2 Ó 3],65654,"[MATERIA]","[DIA1,DIA2...]",'[HORA:INICIO]','[HORA_FIN]');*/
/*
CICLOS:
1 - ENERO -> JUNIO
2 - JULIO (VERANO) 
3 - AGOSTO ->DICIEMBRE
 */
call sp_registrar_horario(100000001,'2018','3',65654,"SERVIDORES","LUNES,MARTES,MIERCOLES,jueves",'07:00:00',"08:00:00");
call sp_registrar_horario(100000002,'2018','3',65655,"PROGRAMACION VISUAL E INTERNET","LUNES,MARTES,MIERCOLES,jueves,viernes",'07:00:00','08:00:00');
call sp_registrar_horario(100000003,'2018','3',65656,"ANALISIS Y DISEÑO DE SISTEMAS","LUNES,MARTES,MIERCOLES,jueves,viernes",'07:00:00','08:00:00');
call sp_registrar_horario(100000004,'2018','3',65657,"GRAFICACION Y MULTIMEDIA","LUNES,MARTES,MIERCOLES,jueves,VIERNES",'07:00:00','08:00:00');
call sp_registrar_horario(100000005,'2018','3',65658,"simulacion de sistemas","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000006,'2018','3',65659,"INTELIGENCIA ARTIFICIAL","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000007,'2018','3',65660,"Introduccion al software de base","LUNES,MARTES,MIERCOLES,jueves,viernes",'07:00:00','08:00:00');
call sp_registrar_horario(100000008,'2018','3',65661,"INTELIGENCIA ARTIFICIAL","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');

call sp_registrar_horario(100000009,'2018','3',65662,"introduccion a la ing de istemas de informacion","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000010,'2018','3',65663,"INVESTIGACION DE OPERACIONES","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000011,'2018','3',65664,"ESTRUCTURA DE DATOS","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000012,'2018','3',65665,"INTELIGENCIA ARTIFICIAL","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000013,'2018','3',65666,"COSTOS EN LA INGENIERIA","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000014,'2018','3',65667,"analisis y diseño de sistemas","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000015,'2018','3',65668,"GRAFICACION Y MULTIMEDIA","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');
call sp_registrar_horario(100000016,'2018','3',65669,"INTELIGENCIA ARTIFICIAL","LUNES,MARTES,MIERCOLES,jueves",'07:00:00','08:00:00');

/*Registrar Objetos*/
call sp_registrar_objeto("Control-A/C","mirage","control blanco con rojo",5);
call sp_registrar_objeto("Control-A/C","YORK","contorl blanco con azul",5);
call sp_registrar_objeto("Control-Cañon","Epson","control blanco con botones de colores",5);
call sp_registrar_objeto("bocinas","lanix","color gris, con fuente de poder",5);

/*Registrar prestamo*/
call sp_registrar_prestamo(0,"1,3,2");
call sp_registrar_registro('2018-11-15 07:10:00',1,1);
call sp_registrar_registro('2018-11-15 07:10:00',2,1);
call sp_registrar_registro('2018-11-15 07:10:00',3,1);
call sp_registrar_registro('2018-11-15 07:10:00',4,1);
call sp_registrar_registro('2018-11-15 07:10:00',5,1);
call sp_registrar_registro('2018-11-15 07:10:00',6,1);
call sp_registrar_registro('2018-11-15 07:10:00',7,1);
call sp_registrar_registro('2018-11-15 07:10:00',8,1);
call sp_registrar_registro('2018-11-15 07:10:00',9,1);
call sp_registrar_registro('2018-11-15 07:10:00',10,1);
call sp_registrar_registro('2018-11-15 07:10:00',11,1);
call sp_registrar_registro('2018-11-15 07:10:00',12,1);
call sp_registrar_registro('2018-11-15 07:10:00',13,1);
call sp_registrar_registro('2018-11-15 07:10:00',14,1);
call sp_registrar_registro('2018-11-15 07:10:00',15,1);
call sp_registrar_registro('2018-11-15 07:10:00',16,1);
/*Ejemplo de un nuevo registro*/

/*Primero que todo se debe identificar si la llave ingresada al sistema esta siendo procesada para un prestamo o una devolucion*/
/*Si el siguiente procedimiento regresa un campo llamado "id" con el  valor entero "0" quiere decir que la llave se prepara para un prestamo.*/
/*En caso de mostrar un id distinto de "0" se tratara de una devolucion de la llave*/
/*NOTA: si es una devolucion la consulta devuelve el id del registro, nombre del maestro, el nombre de la materia,*/
/* la fecha y hora en que se registro la entrada y el id del prestamo asocialdo*/
/*los campos del siguiente metodo se presentan de la siguiente manera*/
/*  | id  |  nombre  |  materia  |  hora_entrada  | id_prestamo  |  */
/*call sp_get_esdevolucion('codigo_llave');*/

/*si es una devolucion y ademas si el "id_prestamo" es distinto de null entonces debemos ejecutar el siguiente metodo*/
/*call sp_get_objetos('id_prestamo'); devueve una lista de objetos con los campos |id_control|id_objeto|nombre|marca|*/

/*Seguimos con el caso de ser una devolucion...*/
/*Para realizar la devolucion pertinente ejecutaremos el siguiente metodo*/
/*call sp_set_registro('id_registro','hora_salida','id_prestamo','arg_id_objetos');*/
/*NOTA: los datos del metodo son obtenidos de los dos metodos ejecutados con aterioridad.*/
/*El ultimo parametro es un arreglo con los id de SOLO los objetos que se estan devolviendo*/

/*En caso de no ser una devolucion osea que el primer metodo returne en el campo id el valor '0' */
/*ejecutamos lo siguiente (lo que sigue es lo que ya tenias)*/

/*al leer el codigo de la llave se busca el horario(que incluye id,maestro,aula) para llenar el formulario, con el procedimiento*/
/*call sp_get_frmPrestamo('codigo_llave','fecha y hora');*/
/*al seleccionar un objeto del combo box en la ventana modal tendremos que usar el procedimiento para un nuevo prestamo al darle click al boton "aceptar"
/*call sp_registrar_prestamo(0,'Objeto1,Objeto2,ObjetoN')si es la primera vez*/
/*call sp_registrar_prestamo('id_de_prestamo','Objeto1,Objeto2,ObjetoN')si NO es la primera vez*/
/*finalmente para generar un nuevo registro utilizamos*/
/*call sp_registrar_registro('FECHA Y HORA','id_horario','id_usuario')id horario lo tomamos de sp_get_frmPrestamo*/

/*SELECT * from tusuarios;*/
