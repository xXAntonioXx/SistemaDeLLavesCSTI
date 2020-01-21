
DELIMITER //
DROP TRIGGER IF EXISTS tg_horaSiguiente_BI;
CREATE TRIGGER tg_horaSiguiente_BI BEFORE INSERT
ON tregistros FOR EACH ROW
BEGIN
	DECLARE p_hora TIMESTAMP DEFAULT NOW();
	SET p_hora = NEW.hora_entrada;
	IF CONVERT(MINUTE(p_hora),UNSIGNED) > 39 THEN
 		SET p_hora = p_hora + INTERVAL (60 - CONVERT(MINUTE(p_hora),UNSIGNED)) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	ELSE 
 		SET p_hora = p_hora - INTERVAL CONVERT(MINUTE(p_hora),UNSIGNED) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	END IF;
		IF EXISTS(
			SELECT *
			FROM thorarios AS ho
			INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
			INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
			INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
			INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
			INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
			INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
			INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras
			WHERE mae.num_emp=(SELECT num_emp_maestro FROM thorarios WHERE id=NEW.id_horario)
			AND  tho.hora_inicio=CONCAT(SUBSTRING((p_hora+INTERVAL 1 HOUR),12,2),":00:00") AND llav.ref=NEW.id_horario
			AND  aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario)
			AND tdi.dias LIKE  CONCAT('%',(ELT(WEEKDAY(NEW.hora_entrada) + 1, 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO')),'%')
			)THEN
			SET @codLlave := (SELECT codigo FROM tllaves WHERE ref=NEW.id_horario);
			SET @idhorario := (SELECT ho.id
				FROM thorarios AS ho
				INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
				INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
				INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
				INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
				INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
				INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
				INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras
				WHERE mae.num_emp=(SELECT num_emp_maestro FROM thorarios WHERE id=NEW.id_horario)
				AND  tho.hora_inicio=CONCAT(SUBSTRING((p_hora+INTERVAL 1 HOUR),12,2),":00:00") AND llav.ref=NEW.id_horario
				AND  aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario)
				AND tdi.dias LIKE  CONCAT('%',(ELT(WEEKDAY(NEW.hora_entrada) + 1, 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO')),'%')	
			);
			SET @idregistro := (SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA="sistema_llaves" AND TABLE_NAME="tregistros");
			INSERT INTO tcontrolHorarios VALUES(@idregistro,@codLlave,@idhorario,DEFAULT);
		END IF;
	
END//
DELIMITER ;




DELIMITER //
DROP PROCEDURE IF EXISTS sp_controlHorarios;
CREATE PROCEDURE sp_controlHorarios()
BEGIN
	-- declaramos variables
	DECLARE p_id_registro INT(11);
	DECLARE p_id_horario INT(11);
	DECLARE p_codigo_llave BIGINT(20);
	DECLARE done INT DEFAULT FALSE;



	-- declaramos cursor
	DECLARE cur_controlHorarios CURSOR FOR
		SELECT id_registro,codigo_llave,id_horario,thr.hora_inicio 
		FROM tcontrolHorarios as tch 
		INNER JOIN thorarios as th ON tch.id_horario=th.id 
		INNER JOIN tdias_horas as tdh ON th.id_dias_horas=tdh.id 
		INNER JOIN thoras as thr ON thr.id=tdh.idHoras 
		WHERE estado=0 AND thr.hora_inicio<NOW();
		FOR UPDATE;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done =TRUE;
	
	-- abrimos el cursor
	OPEN cur_controlHorarios;
		
	-- comenzamos a recorrer
	read_loop: LOOP

		-- emparejamos los campos con las variables
		FETCH cur_controlHorarios INTO p_id_registro,p_codigo_llave,p_id_horario;


		IF done THEN
			LEAVE read_loop;
		END IF;
		-- Iniciamos el proceso para registrar la hora actual y marcar la salida de la hora anterior.
		
		-- verificar si hay un prestamo relacionado
		IF (SELECT id_prestamo from tregistros WHERE id=p_id_registro) IS NULL THEN
			SET @idPrest=0;
		ELSE
			SET @idPrest := (SELECT id_prestamo from tregistros WHERE id=p_id_registro);
		END IF;
		
		-- concatenamos el id de los objetos en caso de estar en un prestmo
		IF @idPrest=0 OR @idPrest IS NULL THEN 
			SET @argObjetos="";
		ELSE
			SET @argObjetos := (SELECT GROUP_CONCAT(id_objeto) FROM tprestamos WHERE id=@idPrest GROUP BY id);
		END IF;

		IF NOT EXISTS(SELECT * FROM sistema_llaves.tregistros WHERE id_horario=p_id_horario AND hora_entrada=CONCAT(CURDATE()," ",EXTRACT(HOUR FROM CURRENT_TIMESTAMP),":00:00")) THEN
			-- marcar salida del registro anterior.
			CALL sp_set_registro(
				p_codigo_llave,
				p_id_registro,
				CONCAT(CURDATE(),' ',EXTRACT(HOUR FROM CURRENT_TIMESTAMP),':00:00'),
				@idPrest,
				@argObjetos
			);


			-- realizamos el nuevo registro
			CALL sp_registrar_registro(
				p_codigo_llave,
				CONCAT(CURDATE(),' ',EXTRACT(HOUR FROM CURRENT_TIMESTAMP),':00:01'),
				p_id_horario,
				(SELECT id_usuario FROM tregistros WHERE id=p_id_registro),
				@argObjetos
				);

		END IF;
	END LOOP;
	
	-- cerramos el cursor
    CLOSE cur_controlHorarios;

	DELETE FROM tcontrolHorarios WHERE estado=1;

END
//
DELIMITER ;




DELIMITER //
DROP EVENT IF EXISTS evt_controlHorarios;
CREATE EVENT IF NOT EXISTS evt_controlHorarios
ON SCHEDULE
EVERY 1 HOUR
STARTS '2019-01-01 05:15:00'
DO
BEGIN
	CALL sp_controlHorarios();
END
//
DELIMITER ;





