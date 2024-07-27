-- #91 원데이 클래스 문의 상세 조회
--  (클래스명, 작성자ID 제목, 내용, 작성시간, 비밀글 여부 상관x)
DROP PROCEDURE IF EXISTS DetailInquiry;

DELIMITER //

CREATE PROCEDURE DetailInquiry(
    IN inq_id INT,      
    IN u_user_id INT,   
    IN u_pwd VARCHAR(255) 
)
BEGIN
    DECLARE v_user_pwd VARCHAR(255);

    SELECT pwd
    INTO v_user_pwd
    FROM users
    WHERE user_id = u_user_id;

    -- 비밀번호가 일치하지 않는 경우 오류 메시지 반환
      IF v_user_pwd != u_pwd THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '비밀번호가 일치하지 않습니다.';
    ELSE
        -- 비밀번호가 일치할 때만 질문의 세부 정보 조회
        SELECT
            c.class_name AS 클래스명,       
            u.login_id AS 작성자ID,         
            i.inq_title AS 제목,            
            i.inq_content AS 내용,          
            i.inq_time AS 작성시간,         
            i.inq_secret AS 비밀글여부
        FROM inquiry i
        JOIN users u ON i.user_id = u.user_id
        JOIN class c ON i.class_id = c.class_id
        WHERE i.inq_id = inq_id              
          AND c.user_id = u_user_id;          
    END IF;
END //

DELIMITER ;

-- CALL DetailInquiry(11, 3, 'pass3'); -- 정상 TEST
-- CALL DetailInquiry(11, 3, 'pass1'); -- 오류 TEST