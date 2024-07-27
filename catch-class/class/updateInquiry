-- #99 원데이 클래스 문의 게시글 수정
DROP PROCEDURE IF EXISTS UpdateInquiry;
DELIMITER //

CREATE PROCEDURE UpdateInquiry(
    IN i_inq_id INT,                
    IN i_user_id INT,              
    IN p_pwd VARCHAR(20),     
    IN i_inq_title VARCHAR(100),   
    IN i_inq_content VARCHAR(300),  
    IN i_inq_secret TINYINT(1)      
)
BEGIN
    DECLARE v_inquiry_count INT;
    DECLARE v_stored_pwd VARCHAR(20);

 SELECT COUNT(*)
    INTO v_inquiry_count
    FROM inquiry
    WHERE inq_id = i_inq_id AND user_id = i_user_id;

SELECT pwd
    INTO v_stored_pwd
    FROM users
    WHERE user_id = i_user_id;

 IF v_inquiry_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '본인의 문의가 아니거나 존재하지 않습니다.';
    ELSEIF v_stored_pwd != p_pwd THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '비밀번호가 일치하지 않습니다.';
    ELSE

        UPDATE inquiry
        SET inq_title = i_inq_title,
            inq_content = i_inq_content,
            inq_secret = i_inq_secret
        WHERE inq_id = i_inq_id
          AND user_id = i_user_id;
    END IF;
END //

DELIMITER ;

-- CALL UpdateInquiry(2, 2, 'pass3', '문의 제목 바꾸기', '내용 변경', '0');    -- 비밀번호 검증
-- CALL UpdateInquiry(1, 2, 'pass3', '문의 제목 바꾸기', '내용 변경', '0');    -- 문의 작성자 검증