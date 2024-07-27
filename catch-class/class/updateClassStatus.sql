DROP PROCEDURE IF EXISTS UpdateClassStatus;
DELIMITER //

CREATE PROCEDURE UpdateClassStatus()
BEGIN
    UPDATE subclass
    SET subclass_status = CASE
        WHEN NOW() >= end_time THEN 0 
        WHEN NOW() <= start_time AND reservation_limit > reservation_count THEN 1
        WHEN NOW() <= start_time and reservation_limit = reservation_count THEN 2
        ELSE subclass_status 
    END;
END //

DELIMITER ;


CALL UpdateClassStatus();
SELECT * FROM subclass;