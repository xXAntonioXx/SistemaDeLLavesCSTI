/*
--------------------
Autor:Murillo Mario
--------------------
En este archivo se encuentran todos los procedimientos
almacenados que realizara la base de datos.
*/


/*Registro de un objeto en la base de datos*/

/*CREATE DEFINER = CURRENT_USER PROCEDURE....*/
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_objeto (p_nombre VARCHAR(50),p_marca VARCHAR(50),p_inventario INT(11)) 
INSERT INTO bd_sistema_llaves.tobjetos(id,nombre,marca,inventario) VALUES (null,p_nombre,p_marca,p_inventario);




/*Registro un prestamo en la base de datos*/
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_prestamo(p_hora_entrada,p_id_horariop_)







/*Registro de un maestro en la base de datos*/
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_maestro (p_num_emp INT, p_nombre VARCHAR(70),p_imagen TEXT)
INSERT INTO bd_sistema_llaves.tmaestros(id,num_emp,nombre,imagen) VALUES (null,p_num_emp,p_nombre,p_imagen);


/*Registro de un posible horario en la tabla "tdias_horas"*/
DELIMITER //
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_dias_horas(
	in p_dias VARCHAR(50),
	in p_hora_inicio TIME,
	in p_hora_fin TIME
)
BEGIN
	if not exists (SELECT * FROM bd_sistema_llaves.tdias WHERE dias=p_dias) then
		INSERT INTO bd_sistema_llaves.tdias (id,dias) values(null,p_dias);
	end if;

	if not exists (SELECT * FROM bd_sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin) then
		INSERT INTO bd_sistema_llaves.thoras(id,hora_inicio,hora_fin) VALUES (null,p_hora_inicio,p_hora_fin);
	end if;

	SELECT @var1 := id FROM bd_sistema_llaves.tdias WHERE dias=p_dias;
	SELECT @var2 := id FROM bd_sistema_llaves.thoras WHERE hora_inicio=p_hora_inicio and hora_fin=p_hora_fin;

	if not exists (SELECT dh.id FROM bd_sistema_llaves.tdias_horas as dh  INNER JOIN bd_sistema_llaves.tdias as d on dh.idDias = d.id INNER JOIN  bd_sistema_llaves.thoras as h on dh.idHoras = h.id) then
		INSERT INTO bd_sistema_llaves.tdias_horas (id,idDias,idHoras) VALUES (null,@var1, @var2);
	end if;
END;
//

/*Registro de una materia en la base de datos*/
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_materia (p_nombre VARCHAR(50),p_programa VARCHAR(10))
INSERT INTO bd_sistema_llaves.tmaterias(id,nombre,programa) VALUES (null, p_nombre, p_programa);


/*Registro de una llave en la base de datos*/
DELIMITER //
CREATE PROCEDURE bd_sistema_llaves.sp_registrar_llave (
	in p_codigo BIGINT(20),
	in p_numero INT(11),
	in p_area VARCHAR(8),
	in p_aula VARCHAR(8)
)
BEGIN
	if not exists(SELECT * FROM bd_sistema_llaves.taulas WHERE area=p_area and aula=p_aula)then
		INSERT INTO bd_sistema_llaves.taulas(id,area,aula) VALUES (null,p_area,p_aula);
	end if;
	
	SELECT @var1 := id FROM bd_sistema_llaves.taulas WHERE aula=p_aula AND area=p_area;

	INSERT INTO bd_sistema_llaves.tllaves(id,codigo,numero,id_aula) VALUES (null, p_codigo,p_numero,@var1);
END;
//
