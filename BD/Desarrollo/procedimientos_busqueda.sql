/*
-------------------------------
---- Autor:Murillo Mario ------
-------------------------------


*/


DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_busqueda;
CREATE PROCEDURE sistema_llaves.sp_get_busqueda(
	in p_desde TIMESTAMP,
	in p_hasta TIMESTAMP,
	in p_maestro VARCHAR(70),
	in p_materia VARCHAR(50),
	in p_area VARCHAR(8),
	in p_aula VARCHAR(8)
)
BEGIN
	CASE
		WHEN (p_desde IS NULL) AND (p_hasta IS NULL) AND (p_maestro IS NULL) AND (p_materia IS NULL) AND (p_area IS NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro;
			
		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NOT NULL) AND (p_area IS NOT NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE  mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%') AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%')
			AND TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta);
		
		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NULL) AND (p_area IS NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta);

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NULL) AND (p_area IS NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NOT NULL) AND (p_area IS NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NULL) AND (p_area IS NOT NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NULL) AND (p_area IS NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NULL) AND (p_area IS NOT NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NULL) AND (p_area IS NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%') AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NOT NULL) AND (p_area IS NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NULL) AND (p_area IS NOT NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NOT NULL) AND (p_area IS NOT NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NOT NULL) AND (p_area IS NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NULL) AND (p_area IS NOT NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%') AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NULL) AND (p_materia IS NOT NULL) AND (p_area IS NOT NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND aul.aula LIKE CONCAT('%',UPPER(p_aula),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NOT NULL) AND (p_area IS NULL) AND (p_aula IS NOT NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND  aul.aula LIKE CONCAT('%',UPPER(p_aula),'%') AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');

		WHEN (p_desde IS NOT NULL) AND (p_hasta IS NOT NULL) AND (p_maestro IS NOT NULL) AND (p_materia IS NOT NULL) AND (p_area IS NOT NULL) AND (p_aula IS NULL) THEN
			SELECT reg.id as id, mat.nombre as materia, mae.nombre as maestro, CONCAT(aul.area,'-',aul.aula) as aula, reg.hora_entrada as entrada, reg.hora_salida as salida, reg.id_prestamo as id_prestamo
			FROM sistema_llaves.tregistros AS reg
			INNER JOIN sistema_llaves.thorarios  AS hor ON hor.id = reg.id_horario
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = hor.num_aula
			INNER JOIN sistema_llaves.tmaterias  AS mat ON mat.id = hor.id_materia
			INNER JOIN sistema_llaves.tmaestros  AS mae ON mae.num_emp = hor.num_emp_maestro
			WHERE TIME(reg.hora_entrada) BETWEEN TIME(p_desde) AND TIME(p_hasta)
			AND UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(p_desde) AND UNIX_TIMESTAMP(p_hasta)
			AND  aul.area LIKE CONCAT('%',UPPER(p_area),'%') AND mae.nombre LIKE CONCAT('%',UPPER(p_maestro),'%') AND mat.nombre LIKE CONCAT('%',UPPER(p_materia),'%');
	END CASE;
END			
//
DELIMITER ;
