DROP PROCEDURE IF EXISTS ClassList;
DELIMITER //

CREATE PROCEDURE ClassList()
BEGIN 
    SELECT 
        c.class_name AS 클래스명,
        u.user_name AS 사업자명
    FROM class c
    LEFT JOIN users u ON c.user_id = u.user_id
    WHERE c.class_status != 0;
END //

DELIMITER ;


 -- CALL ClassList();
 