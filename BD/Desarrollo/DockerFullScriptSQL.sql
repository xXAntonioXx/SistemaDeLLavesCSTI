CREATE DATABASE IF NOT EXISTS sistema_llaves;

USE sistema_llaves;


DROP TABLE IF EXISTS taulas;
CREATE TABLE taulas(
id INT AUTO_INCREMENT,
numero INT(11) UNIQUE,
area VARCHAR(10),
aula VARCHAR(10),
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS tllaves;
CREATE TABLE tllaves(
id INT AUTO_INCREMENT,
codigo BIGINT(20) NOT NULL UNIQUE,
id_aula INT NOT NULL,
ref INT NULL DEFAULT NULL,
PRIMARY KEY (id),

CONSTRAINT FK_tllaves_taulas
FOREIGN KEY (id_aula) REFERENCES taulas(id)
);


DROP TABLE IF EXISTS tmaterias;
CREATE TABLE tmaterias(
id INT AUTO_INCREMENT,
nombre VARCHAR(150),
programa VARCHAR(100),
PRIMARY KEY(id) 
);


DROP TABLE IF EXISTS tdias;
CREATE TABLE tdias(
id INT AUTO_INCREMENT,
dias VARCHAR(52) NOT NULL,
PRIMARY KEY(id)
);


DROP TABLE IF EXISTS thoras;
CREATE TABLE thoras(
id INT AUTO_INCREMENT,
hora_inicio TIME NOT NULL,
hora_fin TIME NOT NULL,
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS tdias_horas;
CREATE TABLE tdias_horas(
id INT AUTO_INCREMENT,
idDias INT NOT NULL,
idHoras INT NOT NULL,
PRIMARY KEY (id),

CONSTRAINT FK_tdias_horas_tdias
FOREIGN KEY (idDias) REFERENCES tdias(id),

CONSTRAINT FK_tdias_horas_thoras
FOREIGN KEY (idHoras) REFERENCES thoras(id)
);


DROP TABLE IF EXISTS tmaestros;
CREATE TABLE tmaestros(
id INT AUTO_INCREMENT,
num_emp INT UNIQUE,
nombre VARCHAR(70),
PRIMARY KEY(id) 
);


DROP TABLE IF EXISTS thorarios;
CREATE TABLE thorarios(
id INT AUTO_INCREMENT,
year YEAR(4) NOT NULL,
ciclo CHAR(1) NOT NULL,
num_aula INT(11) NOT NULL,
num_emp_maestro INT NOT NULL,
id_materia INT NOT NULL,
id_dias_horas INT NOT NULL,

PRIMARY KEY (id),

CONSTRAINT FK_thorarios_taulas
FOREIGN KEY (num_aula) REFERENCES taulas(numero),

CONSTRAINT FK_thorarios_tmaestros
FOREIGN KEY (num_emp_maestro) REFERENCES tmaestros(num_emp),

CONSTRAINT FK_thorarios_tmaterias
FOREIGN KEY (id_materia) REFERENCES tmaterias(id),

CONSTRAINT FK_thorarios_tdias_horas
FOREIGN KEY (id_dias_horas) REFERENCES tdias_horas(id)
);


DROP TABLE IF EXISTS tobjetos;
CREATE TABLE tobjetos(
id INT AUTO_INCREMENT,
nombre VARCHAR(50),
marca  VARCHAR(50),
descripcion VARCHAR(255),
inventario INT,

PRIMARY KEY(id)
);


DROP TABLE IF EXISTS tprestamos;
CREATE TABLE tprestamos(
id INT,
id_control INT NOT NULL,
id_objeto INT NOT NULL,
estado BOOLEAN DEFAULT 0,

PRIMARY KEY(id,id_control),

CONSTRAINT FK_tprestamos_tobjetos
FOREIGN KEY(id_objeto) REFERENCES tobjetos(id)
);



DROP TABLE IF EXISTS texcepciones;
CREATE TABLE texcepciones(
id INT AUTO_INCREMENT,
num_aula INT(11),
num_emp INT NOT NULL,
PRIMARY KEY(id),

CONSTRAINT FK_texcepciones_tllaves
FOREIGN KEY(num_aula) REFERENCES taulas(numero) ON UPDATE CASCADE
);



DROP TABLE IF EXISTS tusuarios;
CREATE TABLE tusuarios(
id INT AUTO_INCREMENT,
nombre VARCHAR(150) UNIQUE,
contrasena VARCHAR(255),
rol CHAR(1) NOT NULL,
estado BOOLEAN DEFAULT 1,
PRIMARY KEY(id)
);


DROP TABLE IF EXISTS tregistros;
CREATE TABLE tregistros(
id INT AUTO_INCREMENT,
id_horario INT NULL,
hora_entrada TIMESTAMP NOT NULL,
hora_salida TIMESTAMP NULL,
id_excepcion INT NULL DEFAULT NULL,
id_prestamo INT NULL DEFAULT NULL,
id_usuario INT NOT NULL,

PRIMARY KEY(id),

CONSTRAINT FK_tregistros_thorarios
FOREIGN KEY(id_horario) REFERENCES thorarios(id),

CONSTRAINT FK_tregistros_texcepciones
FOREIGN KEY(id_excepcion) REFERENCES texcepciones(id),

CONSTRAINT FK_tregistros_tprestamos
FOREIGN KEY (id_prestamo) REFERENCES tprestamos(id),

CONSTRAINT FK_tregistros_tusuarios
FOREIGN KEY (id_usuario) REFERENCES tusuarios(id)
);


CREATE TABLE treportes(
id INT(11) AUTO_INCREMENT,
fecha_registro TIMESTAMP NOT NULL,
fecha_inicio TIMESTAMP NULL,
fecha_fin TIMESTAMP NULL,
descripcion VARCHAR(255) NOT NULL,
num_aula INT(11) NOT NULL,
PRIMARY KEY(id),
CONSTRAINT FK_treportes_taulas
FOREIGN KEY(num_aula) REFERENCES taulas(numero)
);


CREATE TABLE tcontrolHorarios(
  id_registro INT(11),
  codigo_llave BIGINT(20),
  id_horario  INT(11),
  estado BOOLEAN DEFAULT 0,
PRIMARY KEY(id_registro,codigo_llave,id_horario)
);



DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_llaves;
CREATE PROCEDURE sistema_llaves.sp_get_llaves(
	in p_codigo BIGINT(20)
)
BEGIN
	IF(p_codigo IS NULL or p_codigo=0)THEN
		SELECT tllaves.id,codigo,numero,CONCAT(area,'-',aula) as aula FROM tllaves INNER JOIN taulas ON tllaves.id_aula=taulas.id;
	ELSE
		SELECT tllaves.id,codigo,numero,CONCAT(area,'-',aula) as aula FROM tllaves INNER JOIN taulas ON tllaves.id_aula=taulas.id WHERE tllaves.codigo=p_codigo;
	END IF;
END
//
DELIMITER ;


DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_llave;
CREATE PROCEDURE sistema_llaves.sp_registrar_llave (
	in p_codigo BIGINT(20),
	in p_numero INT(11),
	in p_area VARCHAR(10),
	in p_aula VARCHAR(10)
)
BEGIN
	IF NOT EXISTS(SELECT * FROM sistema_llaves.tllaves WHERE codigo=UPPER(p_codigo)) THEN
		IF NOT EXISTS(SELECT * FROM sistema_llaves.taulas WHERE area=UPPER(p_area) and aula=UPPER(p_aula)) THEN
			INSERT INTO sistema_llaves.taulas(id,numero,area,aula) VALUES (null,p_numero,UPPER(p_area),UPPER(p_aula));
		END IF;
		SELECT @var1 := id FROM sistema_llaves.taulas WHERE aula=UPPER(p_aula) AND area=UPPER(p_area);
		INSERT INTO sistema_llaves.tllaves(id,codigo,id_aula) VALUES (null, p_codigo,@var1);
	END IF;
END
//
DELIMITER ;



DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_maestro;
CREATE PROCEDURE sistema_llaves.sp_registrar_maestro (
	in p_num_emp INT, 
	in p_nombre VARCHAR(70)
)
BEGIN
	INSERT INTO sistema_llaves.tmaestros(id,num_emp,nombre) VALUES (null,p_num_emp,UPPER(p_nombre));
END
//
DELIMITER ;


DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_materia;
CREATE PROCEDURE sistema_llaves.sp_registrar_materia (
	in p_nombre VARCHAR(150),
	in p_programa VARCHAR(10))
BEGIN
	INSERT INTO sistema_llaves.tmaterias(id,nombre,programa) VALUES (null, UPPER(p_nombre), UPPER(p_programa));
END 
//
DELIMITER ;



DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_horario;
CREATE PROCEDURE sistema_llaves.sp_registrar_horario(

	in p_num_emp_maestro INT,
	in p_nombre_maestro VARCHAR(70),
	in p_nombre_mat VARCHAR(150),
	in p_num_aula INT(11),
	in p_programa_mat VARCHAR(10),
	in p_dias VARCHAR(50),
	in p_hora_inicio TIME,
	in p_hora_fin TIME,
	in p_year YEAR(4),
	in p_ciclo CHAR(1)
)
BEGIN

	IF NOT EXISTS (SELECT id FROM sistema_llaves.taulas WHERE numero=p_num_aula) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='El aula indicada no se encuentra registrada.';
	END IF;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaterias WHERE nombre=UPPER(p_nombre_mat)) THEN
		CALL sp_registrar_materia(p_nombre_mat, p_programa_mat);
	END IF;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) THEN
		CALL sp_registrar_maestro(p_num_emp_maestro,p_nombre_maestro);
	END IF;


	IF NOT EXISTS (SELECT id FROM sistema_llaves.tdias WHERE dias=UPPER(p_dias)) THEN
		INSERT INTO sistema_llaves.tdias (id,dias) values(null,UPPER(p_dias));
	END IF;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin) THEN
		INSERT INTO sistema_llaves.thoras(id,hora_inicio,hora_fin) VALUES (null,p_hora_inicio,p_hora_fin);
	END IF;

	SELECT @var1 := id FROM sistema_llaves.tdias WHERE dias=UPPER(p_dias);
	SELECT @var2 := id FROM sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin;

	IF NOT EXISTS (SELECT id FROM sistema_llaves.tdias_horas WHERE idDias=@var1 AND idHoras=@var2) THEN
		INSERT INTO sistema_llaves.tdias_horas (id,idDias,idHoras) VALUES (null,@var1, @var2);
	END IF;

 
	SELECT @var3 := id FROM sistema_llaves.tmaterias WHERE nombre=UPPER(p_nombre_mat);
	SELECT @var4 := id FROM tdias_horas WHERE idDias=@var1 and idHoras=@var2;


	INSERT INTO sistema_llaves.thorarios(id,year,ciclo,num_aula,num_emp_maestro,id_materia,id_dias_horas)
	VALUES (null,p_year,p_ciclo,p_num_aula,p_num_emp_maestro,@var3,@var4);

	SET @var1 = NULL;
	SET @var2 = NULL;
	SET @var3 = NULL;
	SET @var4 = NULL;

END
//
DELIMITER ;




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


DELIMITER //
DROP  PROCEDURE IF EXISTS sp_get_llavesPrestadas;
 CREATE PROCEDURE sistema_llaves.sp_get_llavesPrestadas()
 BEGIN
 	SELECT r.id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(au.area,"-",au.aula) as salon, r.hora_entrada, tho.hora_fin as hora_salida,au.numero
	FROM sistema_llaves.tregistros AS r 
	INNER JOIN sistema_llaves.thorarios AS h ON r.id_horario = h.id
	INNER JOIN sistema_llaves.tmaestros AS mae ON h.num_emp_maestro = mae.num_emp
	INNER JOIN sistema_llaves.tmaterias AS mat ON h.id_materia = mat.id
	INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = h.id_dias_horas
	INNER JOIN sistema_llaves.thoras  AS tho  ON tho.id = tdh.idHoras
	INNER JOIN sistema_llaves.taulas AS au ON au.id=h.num_aula
	WHERE r.hora_entrada >= CURDATE() and r.hora_salida IS NULL;
 END
//
DELIMITER ;




DELIMITER //
DROP  PROCEDURE IF EXISTS sp_get_frmPrestamo;
CREATE PROCEDURE sistema_llaves.sp_get_frmPrestamo(
	in p_codigo_llave BIGINT(20),	
	in p_hora TIMESTAMP
)
 BEGIN
 	DECLARE expresion VARCHAR(9) DEFAULT 'null';
 	DECLARE p_ciclo INT(11) DEFAULT 1;
 	IF CONVERT(MINUTE(p_hora),UNSIGNED) > 39 THEN
 		SET p_hora = p_hora + INTERVAL (60 - CONVERT(MINUTE(p_hora),UNSIGNED)) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	ELSE 
 		SET p_hora = p_hora - INTERVAL CONVERT(MINUTE(p_hora),UNSIGNED) MINUTE;
 		SET P_hora = p_hora - INTERVAL (SECOND(p_hora)) SECOND;
 	END IF;

 	IF CONVERT(MONTH(p_hora),UNSIGNED)>=6 AND CONVERT(MONTH(p_hora),UNSIGNED)<=7 THEN
 		SET p_ciclo = 2;
 	ELSEIF CONVERT(MONTH(p_hora),UNSIGNED)>=8 AND CONVERT(MONTH(p_hora),UNSIGNED)<=12 THEN
 		SET p_ciclo = 3;
 	END IF;

 	SET expresion = (ELT(WEEKDAY(p_hora) + 1, 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO'));
 	SELECT ho.id AS id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(aul.area,'-',aul.aula) AS aula
 	FROM thorarios AS ho
 	INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
 	INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
 	INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
 	INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
 	INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
 	INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
 	INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras
 	WHERE llav.codigo=p_codigo_llave AND ho.ciclo=p_ciclo
 	AND ho.year=YEAR(p_hora) AND tho.hora_inicio=TIME(p_hora)
 	AND tdi.dias LIKE  CONCAT('%',expresion,'%');
 END
//
DELIMITER ;



DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_prestamo;
CREATE PROCEDURE sistema_llaves.sp_registrar_prestamo(
	in p_id_prestamo INT,	
	in p_id_objeto_arg VARCHAR(1000)
)
BEGIN
	/*Almacena el valor de entrada en una variable de usuario*/
	DECLARE p_id_control INT(11) DEFAULT 1;
	DECLARE p_mensaje VARCHAR(500) DEFAULT ''; 
	DECLARE p_arreglo VARCHAR(500);
	SET p_arreglo = p_id_objeto_arg;

	SET @num = LENGTH(p_arreglo);
	IF (@num = 0) THEN 
		SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se ingreso ningun objeto.';
	END IF;
	
	/*Asignar el ID a la variable "id_prest"*/
	/*que del registro que se almacenara*/

	IF p_id_prestamo=0 THEN 
		IF NOT EXISTS (SELECT id FROM sistema_llaves.tprestamos) THEN
			SET @id_prest = 1;
		ELSE
			SELECT @id_prest:= max(id) FROM sistema_llaves.tprestamos;
			SET @id_prest= @id_prest + 1;
		END IF;
	ELSE
		SELECT  @id_prest := MAX(id_control) FROM sistema_llaves.tprestamos WHERE id=p_id_prestamo;
		SET p_id_control = @id_prest + 1;
		SET @id_prest = p_id_prestamo;
	END IF;
	
	/*Calcular la cantidad de objetos a registrar*/
	SET @num =(LENGTH(p_arreglo) - LENGTH(REPLACE(p_arreglo, ',', '')))+1;

	IF @num = 1 THEN
		IF NOT EXISTS (SELECT id FROM sistema_llaves.tobjetos WHERE id=p_arreglo) THEN
			SET p_mensaje = CONCAT("El objeto con id ",p_arreglo, " no se encuentra en la base de datos.");
			SIGNAL SQLSTATE '46004'
			SET MESSAGE_TEXT= p_mensaje;
		ELSE
			INSERT INTO sistema_llaves.tprestamos(id,id_control,id_objeto,estado) VALUES (@id_prest,p_id_control,p_arreglo,DEFAULT);
		END IF;
	ELSEIF @num > 1 THEN
		SET p_arreglo= CONCAT(p_arreglo,",");
		WHILE @num > 0 DO
			SET @argTemp=SUBSTRING(p_arreglo,1,LOCATE(",",p_arreglo)-1);
			
			IF NOT EXISTS(SELECT id FROM sistema_llaves.tobjetos WHERE id=CAST(@argTemp AS SIGNED INTEGER)) THEN
				SET p_mensaje= CONCAT(p_mensaje,"El producto ", @argTemp," no se encuentra en la base de datos. ");
			ELSE
				INSERT INTO sistema_llaves.tprestamos(id,id_control,id_objeto,estado) VALUES (@id_prest,p_id_control,CAST(@argTemp AS SIGNED INTEGER),DEFAULT);
				SET p_id_control= p_id_control + 1;
			END IF;
			SET @num = @num - 1;
			
			IF (@num >0) THEN
				SET p_arreglo := SUBSTRING(p_arreglo,LOCATE(",",p_arreglo)+1,LENGTH(p_arreglo));
			END IF;
		END WHILE;
	ELSE
		SIGNAL SQLSTATE '46005'
		SET MESSAGE_TEXT='Error: Hay un problema en la cadena introducida.';
	END IF;

	SET @num = LENGTH(p_mensaje);
	IF (@num>0) THEN
		SIGNAL SQLSTATE '46006'
		SET MESSAGE_TEXT= p_mensaje;
	END IF;
	
	/*SELECT @VALOR := SUBSTRING(@VALOR,LOCATE(",",@VALOR)+1,LENGTH(@VALOR));
	INSERT INTO tprestamos(id,id_control,id_objeto,estado) VALUES (null,p_id,p_id_objeto,false);
	*/
END;
//
DELIMITER ;




DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_excepcion;
CREATE PROCEDURE sistema_llaves.sp_registrar_excepcion(
	in p_codigo_llave BIGINT(20),
	in p_num_emp_maestro INT
)
BEGIN
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	END IF;


	IF NOT EXISTS (SELECT id FROM sistema_llaves.tmaestros WHERE num_emp=p_num_emp_maestro) THEN
		SIGNAL SQLSTATE '46002'
		SET MESSAGE_TEXT='EL maestro indicado no se encuentra registrado.';
	END IF;

	SELECT @var1 := numero FROM sistema_llaves.tllaves AS tll INNER JOIN sistema_llaves.taulas AS tau ON tau.id = tll.id_aula WHERE tll.codigo= p_codigo_llave; 

	INSERT INTO texcepciones(id,codigo_llave,num_emp) VALUES (null,@var1,p_num_emp_maestro);

	SELECT @id_excepcion := MAX(id) FROM texcepciones;

END
//
DELIMITER ;




DELIMITER //

DROP  PROCEDURE IF EXISTS sp_registrar_registro;
CREATE PROCEDURE sistema_llaves.sp_registrar_registro(
	in p_codigo_llave BIGINT(20),
	in p_hora_entrada TIMESTAMP,
	in p_id_horario  INT(11),
	in p_id_usuario INT(11),
	in p_id_objeto_arg VARCHAR(1000)
)
 BEGIN
 	IF p_id_objeto_arg IS NOT NULL AND LENGTH(p_id_objeto_arg)>0 THEN
 		CALL sp_registrar_prestamo(0,p_id_objeto_arg);
 	END IF;
	 SET p_hora_entrada = DATE_FORMAT(p_hora_entrada,"%Y-%m-%d %H:%i:%s");
 	CASE
 		WHEN (p_id_horario > 0) AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NOT NULL) THEN 
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,@id_excepcion,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NULL) THEN 
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,null,null,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NULL) THEN 
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,@id_excepcion,null,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NOT NULL) THEN
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,null,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NOT NULL) THEN
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,@id_excepcion,@id_prest,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NOT NULL) THEN
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,null,@id_prest,p_id_usuario);
 		WHEN (p_id_horario > 0)  AND (@id_excepcion IS NULL) AND (@id_prest IS NULL) THEN
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,p_id_horario,p_hora_entrada,null,null,null,p_id_usuario);
 		WHEN (p_id_horario = 0)  AND (@id_excepcion IS NOT NULL) AND (@id_prest IS NULL) THEN
 			UPDATE tllaves SET ref=p_id_horario where codigo=p_codigo_llave;
			INSERT INTO sistema_llaves.tregistros(id,id_horario,hora_entrada,hora_salida,id_excepcion,id_prestamo,id_usuario) VALUES (null,null,p_hora_entrada,null,@id_excepcion,null,p_id_usuario);
 	END CASE;

 	SET @id_excepcion=null;
 	SET @id_prest=null;
END
//
DELIMITER ;




DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_esdevolucion;
CREATE PROCEDURE sistema_llaves.sp_get_esdevolucion(
	in p_codigo_llave BIGINT(20)
)
BEGIN
	IF NOT EXISTS (SELECT id FROM sistema_llaves.tllaves WHERE codigo=p_codigo_llave) THEN
		SIGNAL SQLSTATE '46000'
		SET MESSAGE_TEXT='La llave indicada no se encuentra registrada.';
	END IF;

	IF EXISTS(
	SELECT * FROM tregistros AS reg
 	INNER JOIN sistema_llaves.thorarios   AS ho   ON ho.id=reg.id_horario 
    INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
 	INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
 	WHERE llav.codigo=p_codigo_llave and reg.hora_salida IS NULL and llav.ref IS NOT NULL
 	and UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(DATE(CURDATE())) AND UNIX_TIMESTAMP(CONCAT(DATE(CURDATE()),' 23:59:59'))
 	) THEN
 		SELECT reg.id as id,mae.nombre, mat.nombre as materia, CONCAT(aul.area,"-",aul.aula) as aula, reg.hora_entrada,reg.id_prestamo 
 		FROM tregistros AS reg
 		INNER JOIN sistema_llaves.thorarios   AS ho   ON ho.id=reg.id_horario 
 		INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
 		INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
 		INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
 		INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
 		WHERE ho.id=(SELECT llav.ref where llav.codigo=p_codigo_llave) and UNIX_TIMESTAMP(reg.hora_entrada) BETWEEN UNIX_TIMESTAMP(DATE(CURDATE())) AND UNIX_TIMESTAMP(CONCAT(DATE(CURDATE()),' 23:59:59')) and reg.hora_salida IS NULL;
 	ELSE
 		SELECT CAST(0 AS UNSIGNED INTEGER) AS id;
 	END IF;

END
//
DELIMITER ;




DELIMITER //
DROP PROCEDURE IF EXISTS sp_get_objetos;
CREATE PROCEDURE sistema_llaves.sp_get_objetos(
	in p_id_prestamo INT(11)
)
BEGIN
	DECLARE p_mensaje VARCHAR(500) DEFAULT '';
	IF p_id_prestamo IS NOT NULL THEN 

	SET p_mensaje =CONCAT('No existe prestamo con id: ', p_id_prestamo);
	IF NOT EXISTS (SELECT id_control FROM sistema_llaves.tprestamos WHERE id=p_id_prestamo) THEN
		SIGNAL SQLSTATE '46009'
		SET MESSAGE_TEXT=p_mensaje;
	END IF;
	SELECT prs.id_control AS id_control,prs.id_objeto as id_objeto,obj.nombre,obj.marca
	FROM tprestamos AS prs
	INNER JOIN tobjetos AS obj ON  obj.id=prs.id_objeto
	WHERE prs.id=p_id_prestamo;
ELSE
	SELECT * FROM sistema_llaves.tobjetos;
END IF;
END
//

DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS sp_set_registro;
CREATE PROCEDURE sistema_llaves.sp_set_registro(
	in p_codigo_llave BIGINT(20),
	in p_id_registro INT(11),
	in p_hora_salida TIMESTAMP,
	in p_id_prestamo INT(11),
	in p_id_control_arg VARCHAR(1000)
)
BEGIN
	DECLARE p_arreglo VARCHAR(500);
	SET p_arreglo = p_id_control_arg;

	SET @num = LENGTH(p_arreglo);
	IF (@num != 0) THEN 
		/*Calcular la cantidad de objetos para marcar su devolucion*/
		SET @num =(LENGTH(p_arreglo) - LENGTH(REPLACE(p_arreglo, ',', '')))+1;

		IF @num = 1 THEN
			UPDATE sistema_llaves.tprestamos SET estado=1 WHERE id=p_id_prestamo and id_control=p_arreglo;
		ELSEIF @num>1 THEN
			SET p_arreglo= CONCAT(p_arreglo,",");
			WHILE @num > 0 DO
				SET @argTemp=SUBSTRING(p_arreglo,1,LOCATE(",",p_arreglo)-1);

				UPDATE sistema_llaves.tprestamos SET estado=1 WHERE id=p_id_prestamo and id_control=CAST(@argTemp AS SIGNED INTEGER);

				SET @num = @num - 1;
				IF (@num >0) THEN
					SET p_arreglo := SUBSTRING(p_arreglo,LOCATE(",",p_arreglo)+1,LENGTH(p_arreglo));
				END IF;
			END WHILE;
		END IF;
	END IF;
	UPDATE sistema_llaves.tregistros SET hora_entrada=(select hora_entrada where id=p_id_registro),hora_salida=p_hora_salida WHERE id=p_id_registro;
	UPDATE sistema_llaves.tllaves SET ref=NULL where codigo=p_codigo_llave;
	UPDATE sistema_llaves.tcontrolHorarios SET estado=1 WHERE id_registro=p_id_registro and codigo_llave=p_codigo_llave;
END
//
DELIMITER ;

DELIMITER //
DROP  PROCEDURE IF EXISTS sp_registrar_objeto;
CREATE PROCEDURE sistema_llaves.sp_registrar_objeto (
	in p_nombre VARCHAR(50),
	in p_marca VARCHAR(50),
	in p_descripcion VARCHAR(255),
	in p_inventario INT(11)
) 
BEGIN
INSERT INTO sistema_llaves.tobjetos(id,nombre,marca,descripcion,inventario)
VALUES (null,UPPER(p_nombre),UPPER(p_marca),UPPER(p_descripcion),p_inventario);
END
//
DELIMITER ;




DELIMITER //
DROP PROCEDURE IF EXISTS sp_editar_objeto;
CREATE PROCEDURE sistema_llaves.sp_editar_objeto(
	IN p_id_objeto INT(11),
	in p_nombre VARCHAR(50),
	in p_marca VARCHAR(50),
	in p_descripcion VARCHAR(255),
	in p_inventario INT(11)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM tobjetos WHERE id=p_id_objeto) THEN
		SIGNAL SQLSTATE '46010'
		SET MESSAGE_TEXT="El objeto no se encuentra en la base de datos.";
	END IF;
	CASE
		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre) WHERE id=p_id_objeto;
		
		WHEN (p_nombre IS NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET marca=UPPER(p_marca) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET descripcion=UPPER(p_descripcion) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),marca=UPPER(p_marca) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),descripcion=UPPER(p_descripcion) WHERE id=p_id_objeto;
	
		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET marca=UPPER(p_marca),descripcion=UPPER(p_descripcion) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET marca=UPPER(p_marca),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET descripcion=UPPER(p_descripcion),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),marca=UPPER(p_marca),descripcion=UPPER(p_descripcion) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),marca=UPPER(p_marca),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),descripcion=UPPER(p_descripcion),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET marca=UPPER(p_marca),descripcion=UPPER(p_descripcion),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

		WHEN (p_nombre IS NOT NULL) AND (p_marca IS NOT NULL) AND (p_descripcion IS NOT NULL) AND (p_inventario IS NOT NULL) THEN
			UPDATE sistema_llaves.tobjetos SET nombre=UPPER(p_nombre),marca=UPPER(p_marca),descripcion=UPPER(p_descripcion),inventario=UPPER(p_inventario) WHERE id=p_id_objeto;

	END CASE;

END
//
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS sistema_llaves.sp_eliminar_objeto;
CREATE PROCEDURE sistema_llaves.sp_eliminar_objeto (
	IN p_id_objeto INT(11)
)
BEGIN
	IF p_id_objeto IS NOT NULL AND EXISTS(SELECT id FROM tobjetos WHERE id=p_id_objeto) THEN
		DELETE FROM sistema_llaves.tobjetos WHERE id=p_id_objeto;
	ELSE
		SIGNAL SQLSTATE '46010'
		SET MESSAGE_TEXT="El objeto no se encuentra en la base de datos.";
	END IF;
END
//
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_obtener_reportes_para_soporte;
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_obtener_reportes_para_soporte(
)
BEGIN
    SELECT tr.id,tr.fecha_registro as fecha,CONCAT(ta.area,'-',ta.aula) as aula, tr.descripcion,if(fecha_inicio IS NULL,'Pendiente','En progreso') as estatus FROM treportes as tr INNER JOIN taulas as ta ON tr.num_aula=ta.numero WHERE tr.fecha_fin IS NULL;
END
//
DELIMITER ;




DROP PROCEDURE IF EXISTS sp_registrar_reporte;
DELIMITER //
CREATE PROCEDURE sistema_llaves.sp_registrar_reporte(
  in p_descripcion VARCHAR(255),
  in p_numAula INT(11)
)
BEGIN
  IF(p_descripcion IS NULL OR LENGTH(TRIM(p_descripcion))<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico una descripción.';
  END IF;


  IF(p_numAula IS NULL OR p_numAula<1)THEN
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se especifico el número de aula';
  END IF;

  
  IF EXISTS(SELECT numero from taulas where numero=p_numAula)THEN
    INSERT INTO treportes(fecha_registro,fecha_inicio,fecha_fin,descripcion,num_aula) VALUES(NOW(),null,null,CONCAT(UPPER(LEFT(p_descripcion,1)),LOWER(SUBSTR(p_descripcion,2))),p_numAula);
  ELSE
    SIGNAL SQLSTATE '46003'
		SET MESSAGE_TEXT='No se encontro registro con el aula o edificio especificado. Comuniquese con el administrador.';
  END IF;
END
//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS CHK_user_rol;
CREATE PROCEDURE CHK_user_rol(
IN rol CHAR(1)
)
BEGIN
SET @caracter= ASCII(rol);
IF @caracter<49 OR @caracter>51 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Ingresa un rol valido. roles:1,2,3';
END IF;
END//
DELIMITER ;


DELIMITER //
DROP TRIGGER IF EXISTS tg_users_rol_BI;
CREATE TRIGGER tg_users_rol_BI BEFORE INSERT 
ON sistema_llaves.tusuarios FOR EACH ROW
BEGIN
	CALL CHK_user_rol(new.rol);
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS tg_users_rol_BU;
CREATE TRIGGER tg_users_rol_BU BEFORE UPDATE 
ON sistema_llaves.tusuarios FOR EACH ROW
BEGIN
	CALL CHK_user_rol(new.rol);
END//
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS CHK_horario_ciclo;
CREATE PROCEDURE CHK_horario_ciclo(
IN ciclo CHAR(1)
)
BEGIN
SET @caracter= ASCII(ciclo);
IF @caracter<49 OR @caracter>51 THEN
SIGNAL SQLSTATE '45001'
SET MESSAGE_TEXT='Ingresa un ciclo valido. Ciclos:1,2,3';
END IF;
END//
DELIMITER ;


DELIMITER //
DROP TRIGGER IF EXISTS tg_horario_ciclo_BI;
CREATE TRIGGER tg_horario_ciclo_BI BEFORE INSERT 
ON sistema_llaves.thorarios FOR EACH ROW
BEGIN
	CALL CHK_horario_ciclo(new.ciclo);

	IF EXISTS(SELECT * FROM sistema_llaves.thorarios as th WHERE th.year=NEW.year AND th.ciclo=NEW.ciclo AND th.num_aula=NEW.num_aula AND th.num_emp_maestro=NEW.num_emp_maestro AND th.id_materia=NEW.id_materia AND th.id_dias_horas=NEW.id_dias_horas) THEN
		SIGNAL SQLSTATE '46011'
		SET MESSAGE_TEXT='Ya hay un horario con estas caracteristicas';
	END IF;
END//
DELIMITER ;



DROP VIEW IF EXISTS wv_horarios;
CREATE DEFINER=CURRENT_USER
SQL SECURITY INVOKER
VIEW wv_horarios AS
SELECT DISTINCT(ho.id) AS id, mae.nombre AS maestro, mat.nombre AS materia, CONCAT(aul.area,'-',aul.aula) AS aula, tdi.dias AS dias, CONCAT(tho.hora_inicio,'-',tho.hora_fin) as hora
FROM thorarios AS ho
INNER JOIN sistema_llaves.taulas  	  AS aul  ON aul.numero = ho.num_aula
INNER JOIN sistema_llaves.tllaves 	  AS llav ON llav.id_aula = aul.id 
INNER JOIN sistema_llaves.tmaestros   AS mae  ON mae.num_emp = ho.num_emp_maestro
INNER JOIN sistema_llaves.tmaterias   AS mat  ON mat.id = ho.id_materia
INNER JOIN sistema_llaves.tdias_horas AS tdh  ON tdh.id = ho.id_dias_horas
INNER JOIN sistema_llaves.tdias 	  AS tdi  ON tdi.id = tdh.idDias
INNER JOIN sistema_llaves.thoras 	  AS tho  ON tho.id = tdh.idHoras;



DROP PROCEDURE IF EXISTS UpdateUser;
DELIMITER //
CREATE PROCEDURE UpdateUser(IN IdInput INT,IN contraInput VARCHAR(90),IN rolInput INT)
BEGIN
    DECLARE ContraNew VARCHAR(100);
    DECLARE RolNew INT;

    SELECT contrasena,rol INTO ContraNew,RolNew FROM tusuarios WHERE id = IdInput LIMIT 1;


    IF((contraInput IS NOT NULL AND LENGTH(contraInput)>0) AND rolInput IS NOT NULL)THEN
        UPDATE tusuarios SET contrasena=contraInput,rol=rolInput WHERE id = IdInput;
    ELSEIF((contraInput IS NULL OR LENGTH(contraInput)=0) AND rolInput IS NOT NULL)THEN
        UPDATE tusuarios SET rol=rolInput WHERE id = IdInput;
    ELSEIF((contraInput IS NOT NULL AND LENGTH(contraInput)>0) AND rolInput IS NULL)THEN
        UPDATE tusuarios SET contrasena=contraInput WHERE id = IdInput;
    END IF;
    
END //
DELIMITER ;




CALL sp_registrar_maestro(1,"SIN ASIGNAR...");
CALL sp_registrar_materia("SIN ASIGNAR...","NO");


INSERT INTO tusuarios VALUES(null,'admin','$2y$10$37qmLtx9proueJJHmxXZuuQzj4Yf0WtjA05hjRSTZ3ZRYpLl.uDw2',1,DEFAULT);
