/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran las vistas que tendra la base de datos
las cuales se utilizaran para realizar todas las consultas de informacion.
*/


/*--------------------------------------------------------*/
/*PARA LA INFORMACION A MOSTRAR EN LA PANTALLA PRINCIPAL*/
/*-------------------------------------------------------*/
CREATE VIEW view_index AS
SELECT r.id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(ll.area,ll.aula) as salon, r.hora_entrada, r.hora_salida
FROM bd_sistema_llaves.tregistros AS r 
INNER JOIN bd_sistema_llaves.thorarios AS h ON r.id_horario = h.id
INNER JOIN bd_sistema_llaves.tmaestros AS mae ON h.num_emp_maestro = mae.num_emp
INNER JOIN bd_sistema_llaves.tmaterias AS mat ON h.id_materia = mat.id
INNER JOIN bd_sistema_llaves.tllaves AS ll ON h.codigo_llave = ll.codigo
WHERE r.hora_entrada >= CURDATE();
/*-----------------------------------------------------------*/



/*---------------------------------------------------------*/
/*Vista para visualizar los objetos de la tabla objetos.*/
/*--------------------------------------------------------*/

CREATE VIEW view_objetos AS
SELECT id,nombre,marca,descripcion FROM tobjetos;

/*-----------------------------------------------------*/
