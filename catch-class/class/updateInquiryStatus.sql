DROP PROCEDURE IF EXISTS UpdateInquiryStatus;
DELIMITER //

CREATE PROCEDURE UpdateInquiryStatus(
    IN i_inq_id INT,         
    IN u_user_id INT,       
    IN p_pwd VARCHAR(10) 
)
BEGIN
    DECLARE v_user_pwd VARCHAR(10);

    START TRANSACTION;

    -- 문의 ID와 사용자 ID에 해당하는 비밀번호 조회
    SELECT p_pwd INTO v_user_pwd
    FROM inquiry i
    JOIN users u ON i.user_id = u.user_id
    WHERE i.inq_id = i_inq_id
      AND i.user_id = u_user_id;

    -- 비밀번호 검증
    IF v_user_pwd = p_pwd THEN
        -- 문의 상태를 FALSE로 업데이트
        UPDATE inquiry
        SET inq_status = FALSE
        WHERE inq_id = i_inq_id
          AND user_id = u_user_id;

        COMMIT;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '비밀번호가 일치하지 않거나 해당 문의가 존재하지 않습니다.';
    END IF;
END //

DELIMITER ;


-- inq_id 11 인 문의 상태 변경 
-- CALL UpdateInquiryStatus(4, 3, 'pass3'); 
-- SELECT * FROM inquiry;