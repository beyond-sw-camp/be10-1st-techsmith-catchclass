DROP PROCEDURE IF EXISTS UpdateclassInfo;
DELIMITER //

CREATE PROCEDURE UpdateClassInfo(
    IN c_class_id INT,                
    IN sc_subclass_id INT,            
    IN c_class_name VARCHAR(100),     
    IN r_reservation_limit INT,        
    IN c_class_content VARCHAR(500), 
    IN sc_subclass_content VARCHAR(300),  
    IN c_user_id INT                  
)
BEGIN
    DECLARE v_class_user_id INT DEFAULT NULL;

    -- 클래스의 사업자 ID 확인
    SELECT user_id
    INTO v_class_user_id
    FROM class
    WHERE class_id = c_class_id;

    -- 클래스의 사업자 ID가 일치하지 않는 경우
    IF v_class_user_id IS NOT NULL AND v_class_user_id != c_user_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '사용자가 일치하지 않습니다. 클래스 업데이트 권한이 없습니다';
    ELSE

        UPDATE class
        SET class_name = c_class_name,
            class_content = c_class_content
        WHERE class_id = c_class_id;

        UPDATE subclass
        SET reservation_limit = r_reservation_limit,
            subclass_content = sc_subclass_content
        WHERE subclass_id = sc_subclass_id;
    END IF;
END //

DELIMITER ;

CALL UpdateClassInfo(2, 1, '클래스명 수정', 30, '클래스 내용 수정', '회차 내용 수정', 9); 

-- 테스트 코드 추가 
SELECT 
    c.class_id,
    c.class_name,
    c.class_content,
    s.subclass_id,
    s.reservation_limit,
    s.subclass_content
FROM 
    class c
INNER JOIN 
    subclass s ON c.class_id = s.class_id