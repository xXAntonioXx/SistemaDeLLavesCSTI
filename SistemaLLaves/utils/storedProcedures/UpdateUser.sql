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
DELIMITER ; //
call UpdateUser(1,'$2y$10$nqr.iOGwmeEpOe.46IPd0eBXa.amkUqLXgY64T9ekPl6z4/nxIsue',null);