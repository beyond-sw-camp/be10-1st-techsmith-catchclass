DROP PROCEDURE IF EXISTS DeleteClassInfo;
DELIMITER //

CREATE PROCEDURE DeleteClassInfo(
    IN c_class_id INT,  
    IN u_user_id INT   
)
BEGIN 
    DECLARE v_exists INT; 

    -- 클래스 존재 여부 및 사업자 ID 확인
    SELECT COUNT(*)
    INTO v_exists 
    FROM class
    WHERE class_id = c_class_id 
      AND user_id = u_user_id;
      
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '존재하지 않는 클래스이거나 본인의 클래스가 아닙니다.';
    ELSE
        -- 클래스 상태를 0으로 (사업자가 클래스 종료(삭제) 의미 구현)
        UPDATE class
        SET class_status = 0
        WHERE class_id = c_class_id AND user_id = u_user_id;
    END IF;
END //

DELIMITER ;


-- CALL DeleteClassInfo(1,3);
-- SELECT * FROM class;
