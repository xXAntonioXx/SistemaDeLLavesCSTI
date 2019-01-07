/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran toda la estructura de la BD.
*/



/*Las tablas deben crearse en el orden en el
  que se encuentran en el script; al no seguir
  este mismo orden puede que tenga errores por
  las llaves foraneas.*/

/*---------------------------------------*/
/*En las siguientes dos tablas se
almacenara la informacion sobre las
llaves.*/
/*---------------------------------------*/

/* En la tabla "taulas" se 
almacenara la informacion de las aulas
a las que puede pertenecer una llave*/
DROP DATABASE IF EXISTS sistema_llaves;

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

/*En la tabla "tllaves" se almacenara
la informacion de identificacion de las
llaves*/
DROP TABLE IF EXISTS tllaves;
CREATE TABLE tllaves(
id INT AUTO_INCREMENT,
codigo BIGINT(20) NOT NULL UNIQUE,
id_aula INT NOT NULL,
PRIMARY KEY (id),

CONSTRAINT FK_tllaves_taulas
FOREIGN KEY (id_aula) REFERENCES taulas(id)
);
/*-----------------------------------------*/

/*------------------------------------------*/
/*La tabla "tmaterias" es donde se almacenara
  la informacion mas basica de las materias*/
/*------------------------------------------*/
DROP TABLE IF EXISTS tmaterias;
CREATE TABLE tmaterias(
id INT AUTO_INCREMENT,
nombre VARCHAR(150),
programa VARCHAR(100),
PRIMARY KEY(id) 
);
/*------------------------------------------*/


/*----------------------------------------------*/
/*Las siguientes 3 tablas se usaran para formar
los dias y horas de los horarios de clases de 
los maestros*/
/*---------------------------------------------*/

/*Tabla "tdias" almacenara la combinaciones
de dias en las cuales se inpartiran las clases*/
DROP TABLE IF EXISTS tdias;
CREATE TABLE tdias(
id INT AUTO_INCREMENT,
dias VARCHAR(52) NOT NULL,
PRIMARY KEY(id)
);

/*La tabla "thoras" almacenara la horass de entrada
y las horas de salida de las materias*/
DROP TABLE IF EXISTS thoras;
CREATE TABLE thoras(
id INT AUTO_INCREMENT,
hora_inicio TIME NOT NULL,
hora_fin TIME NOT NULL,
PRIMARY KEY (id)
);


/*La tabla "tdias_horas" solo es una tabla
intermedia para formar el horario de una 
materia, usando las dos tablas anteriores*/
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

/*-----------------------------------------------*/


/*-------------------------------------------*/
/*En esta tabla "tmaestros" se registraran
  a los distintos maestros"*/
/*-----------------------------------------*/
DROP TABLE IF EXISTS tmaestros;
CREATE TABLE tmaestros(
id INT AUTO_INCREMENT,
num_emp INT UNIQUE,
nombre VARCHAR(70),
PRIMARY KEY(id) 
);

/*-------------------------------------*/


/*------------------------------------*/
/*En la "thorarios" se almacenara
los horarios de cada maestro*/
/*----------------------------------*/
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

/*---------------------------------------------*/

/*---------------------------------------*/
/*En la siguiente tabla "tobjetos" se
  estaran almacenando los objetos
  disponibles para prestamos*/
/*-------------------------------------*/
DROP TABLE IF EXISTS tobjetos;
CREATE TABLE tobjetos(
id INT AUTO_INCREMENT,
nombre VARCHAR(50),
marca  VARCHAR(50),
inventario INT,
PRIMARY KEY(id)
);

/*--------------------------------*/

/*------------------------------------------*/
/*En la tabla tprestamos se registraran
  los prestamos efectuados al momento
  de adquirir una llave de un aula*/
/*----------------------------------------*/
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

/*--------------------------------------------*/

/*-----------------------------------------------------------*/
/*En la tabla "texepciones" se almacenara solo el codigo de 
  la llave la cual proporcionara la informacion necesaria 
  sobre el aula a la cual se le dio acceso al maestro 
  la cual no es es el aula indicada en su horario*/
/*----------------------------------------------------------*/
DROP TABLE IF EXISTS texcepciones;
CREATE TABLE texcepciones(
id INT AUTO_INCREMENT,
num_aula INT(11),
num_emp INT NOT NULL,
PRIMARY KEY(id),

CONSTRAINT FK_texcepciones_tllaves
FOREIGN KEY(num_aula) REFERENCES taulas(numero) ON UPDATE CASCADE
);

/*--------------------------------------------------------*/

/*------------------------------------------------------*/
/*En esta tabla "tusuarios"  se almacenaran
  los usarios que tendran acceso al sistema*/
/*----------------------------------------------------*/
DROP TABLE IF EXISTS tusuarios;
CREATE TABLE tusuarios(
id INT AUTO_INCREMENT,
nombre VARCHAR(150) UNIQUE,
contrasena VARCHAR(255),
rol CHAR(1) NOT NULL,
estado BOOLEAN DEFAULT 1,
PRIMARY KEY(id)
);
/*-----------------------------------------------*/


/* En la siguiente tabla se llevara el control de
   la hora de entrada y salida de los maestros,
   asi como tambien si tiene algun prestamo*/
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

