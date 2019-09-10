DROP PROCEDURE IF EXISTS UpdateUser;
DELIMITER //
CREATE PROCEDURE UpdateUser(IN IdInput INT,IN contraInput VARCHAR(90),IN rolInput INT)
BEGIN
    DECLARE ContraNew VARCHAR(100);
    DECLARE RolNew INT;

    SELECT contrasena,rol INTO ContraNew,RolNew FROM tusuarios WHERE id = IdInput LIMIT 1;

    IF(contraInput IS NOT NULL)THEN
        SET ContraNew = contraInput;
    END IF;
    IF(rolInput IS NOT NULL)THEN
        SET RolNew = rolInput;
    END IF;

    UPDATE tusuarios SET contrasena=ContraNew,rol=RolNew WHERE id = IdInput;
END //
DELIMITER ; //
call UpdateUser(1,'$2y$10$nqr.iOGwmeEpOe.46IPd0eBXa.amkUqLXgY64T9ekPl6z4/nxIsue',null);