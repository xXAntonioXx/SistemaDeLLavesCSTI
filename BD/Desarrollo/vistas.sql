/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran algunas vistas que pueden
ayudar a visualizar la cierta información.

*/

DROP VIEW IF EXISTS vw_horarios;
CREATE DEFINER=CURRENT_USER
SQL SECURITY INVOKER
VIEW vw_horarios AS
SELECT DISTINCT(ho.id) AS id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(aul.area,'-',aul.aula) AS aula, tdi.dias AS dias, CONCAT(tho.hora_inicio,'-',tho.hora_fin) as hora
FROM thorarios AS ho
INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras;