
	DECLARE codLlave BIGINT(20) DEFAULT 0;
DELIMITER //
DROP TRIGGER IF EXISTS tg_horaSigueinte_BI;
CREATE TRIGGER IF NOT EXISTS tg_horaSigueinte_BI BEFORE INSERT
ON tregistros FOR EACH ROW
BEGIN
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
	 	AND  tho.hora_inicio=(NEW.hora_entrada+INTERVAL 1 HOUR)
	 	AND  aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario)
	 	AND tdi.dias LIKE  CONCAT('%',(ELT(WEEKDAY(NEW.hora_entrada) + 1, 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO')),'%')
		)THEN
		SET @codLlave := (SELECT llav.codigo FROM tllaves AS llav INNER JOIN taulas AS aul ON llav.id_aula = aul.id WHERE llav.ref=1 AND aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario));
		INSERT INTO tcontrolHorarios VALUES(NEW.id,codLlave,NEW.id_horario,DEFAULT);
	END IF;
END//
DELIMITER ;



DELIMITER //
DROP TRIGGER IF EXISTS tg_horaSigueinte_BU;
CREATE TRIGGER IF NOT EXISTS tg_horaSigueinte_BU BEFORE UPDATE
ON tregistros FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT * FROM tcontrolHorarios WHERE codigo_llave=(SELECT llav.codigo FROM tllaves AS llav INNER JOIN taulas AS aul ON llav.id_aula = aul.id WHERE llav.ref=1 AND aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario))
		)THEN
		DELETE FROM tcontrolHorarios WHERE codigo_llave=(SELECT llav.codigo FROM tllaves AS llav INNER JOIN taulas AS aul ON llav.id_aula = aul.id WHERE llav.ref=1 AND aul.numero=(SELECT num_aula FROM thorarios WHERE id=NEW.id_horario));
	END IF;
END//
DELIMITER ;


DELIMITER //
DROP TRIGGER IF EXISTS tg_horaSigueinte_BD;
CREATE TRIGGER IF NOT EXISTS tg_horaSigueinte_BD BEFORE DELETE
ON tcontrolHorarios FOR EACH ROW
BEGIN
	IF OLD.estado=1 THEN	
		IF (SELECT id_prestamo from tregistros WHERE id=OLD.id_registro IS NULL) THEN
			SET @idPrest=0;
		ELSE
			SET @idPrest := (SELECT id_prestamo from tregistros WHERE id=OLD.id_registro);
		END IF;

		IF @idPrest=0 OR @idPrest IS NULL THEN 
			SET @argObjetos="";
		ELSE
			SET @argObjetos := (SELECT GROUP_CONCAT(id_objeto) FROM tprestamos WHERE id=@idPrest GROUP BY id);
		END IF;

		CALL sp_registrar_registro(
			OLD.codigo_llave,
			CONCAT(CURDATE(),' ',EXTRACT(HOUR FROM CURRENT_TIMESTAMP),':00:00'),
			OLD.id_horario,
			(SELECT id_usuario FROM tregistros WHERE id=OLD.id_registro),
			@argObjetos
			);

		IF @idPrest!=0 AND @idPrest IS NOT NULL THEN
			UPDATE tprestamos SET estado=1 WHERE id=@idPrest;
		END IF;
	END IF;
END//
DELIMITER ;





