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
CREATE TABLE taulas(
id INT AUTO_INCREMENT,
area VARCHAR(8),
aula VARCHAR(8),
PRIMARY KEY (id)
);

/*En la tabla "tllaves" se almacenara
la informacion de identificacion de las
llaves*/
CREATE TABLE tllaves(
id INT AUTO_INCREMENT,
codigo BIGINT(20) NOT NULL UNIQUE,
numero INT(11),
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
CREATE TABLE tdias(
id INT AUTO_INCREMENT,
dias VARCHAR(50) NOT NULL,
PRIMARY KEY(id)
);

/*La tabla "thoras" almacenara la horass de entrada
y las horas de salida de las materias*/
CREATE TABLE thoras(
id INT AUTO_INCREMENT,
hora_inicio TIME NOT NULL,
hora_fin TIME NOT NULL,
PRIMARY KEY (id)
);


/*La tabla "tdias_horas" solo es una tabla
intermedia para formar el horario de una 
materia, usando las dos tablas anteriores*/
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

CREATE TABLE thorarios(
id INT AUTO_INCREMENT,
codigo_llave BIGINT(20),
num_emp_maestro INT NOT NULL,
id_materia INT NOT NULL,
id_dias_horas INT NOT NULL,

PRIMARY KEY (id),

CONSTRAINT FK_thorarios_tllaves
FOREIGN KEY (codigo_llave) REFERENCES tllaves(codigo),

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

CREATE TABLE tobjetos(
id INT AUTO_INCREMENT,
nombre VARCHAR(50),
marca  VARCHAR(50),
descripcion VARCHAR(100),
inventario INT,
PRIMARY KEY(id)
);

/*--------------------------------*/

/*------------------------------------------*/
/*En la tabla tprestamos se registraran
  los prestamos efectuados al momento
  de adquirir una llave de un aula*/
/*----------------------------------------*/

CREATE TABLE tprestamos(
id INT,
id_control INT NOT NULL,
id_objeto INT NOT NULL,
Estado BOOLEAN DEFAULT 0,

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
CREATE TABLE texcepciones(
id INT AUTO_INCREMENT,
codigo_llave BIGINT(20),
num_emp INT NOT NULL,
PRIMARY KEY(id),

CONSTRAINT FK_texcepciones_tllaves
FOREIGN KEY(codigo_llave) REFERENCES tllaves(codigo) ON UPDATE CASCADE
);

/*--------------------------------------------------------*/

/*------------------------------------------------------*/
/*En esta tabla "tusuarios"  se almacenaran
  los usarios que tendran acceso al sistema*/
/*----------------------------------------------------*/
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
CREATE TABLE tregistros(
id INT AUTO_INCREMENT,
id_horario INT,
hora_entrada TIMESTAMP NOT NULL,
hora_salida TIMESTAMP NULL,
id_excepcion INT,
id_prestamo INT NOT NULL,
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
