
/*--------------------------------------*/
/*----------------EN PROCESO--------------*/
/*-------------------------------------*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_busqueda;
CREATE PROCEDURE sistema_llaves.sp_get_busqueda(
	in p_desde TIMESTAMP,
	in p_hasta TIMESTAMP,
	in p_dias VARCHAR(50),
	in p_maestro VARCHAR(70),
	in p_materia VARCHAR(50),
	in p_area VARCHAR(8),
	in p_aula VARCHAR(8)
)
BEGIN
	CASE
		WHEN (p_desde IS NULL AND p_hasta IS NULL AND p_dias IS NULL AND p_maestro IS NULL AND p_materia IS NULL AND p_area IS NULL AND p_aula IS NULL) THEN 
			SELECT ho.id AS id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(aul.area,'-',aul.aula) AS aula
 			FROM thorarios AS ho
 			INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.codigo = ho.codigo_llave
 			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.id = llav.id_aula
 			INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
 			INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
 			INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
 			INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
 			INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras;

		WHEN (p_desde IS NOT NULL AND p_hasta IS NOT NULL AND p_dias IS NOT NULL AND p_maestro AND p_materia IS NOT NULL AND p_area IS NOT NULL AND p_aula IS NOT NULL) THEN 

		WHEN (p_desde IS NOT NULL AND p_hasta IS NULL and p_dias IS NULL AND p_maestro IS NULL AND p_materia IS NULL AND p_area IS NULL AND p_aula IS NULL) THEN
	END CASE;
END
//
DELIMITER ;