DELIMITER //

CREATE PROCEDURE AddReport(
    IN AR_id INT,
    IN AR_title VARCHAR(100),
    IN AR_content VARCHAR(300),
    IN AR_user_id INT,
    IN AR_re_id INT  
)
BEGIN
    -- 외래 키 제약 조건을 충족하는지 확인
    IF EXISTS (SELECT 1 FROM users WHERE user_id = AR_user_id) and
       EXISTS (SELECT 1 FROM review WHERE re_id = AR_re_id) THEN
        INSERT INTO report (
            report_id,
            report_title,
            report_content,
            report_type,
            user_id,
            re_id,
            class_id,
            comment_id,
            post_id,
            report_time,
            report_check
        )
        VALUES (
            AR_id,
            AR_title,
            AR_content,
            'review',  -- ENUM 값으로 'review' 하드코딩
            AR_user_id,
            AR_re_id,  -- 입력받은 re_id 값 사용
            NULL,      -- class_id에 NULL 설정
            NULL,      -- comment_id에 NULL 설정
            NULL,      -- post_id에 NULL 설정
            NOW(),     -- 현재 시간
            'unchecked'-- ENUM 값으로 'unchecked' 하드코딩
        );
    ELSE 
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'AR_re_id, AR_user_id 값이 참조 테이블에 유효하지 않습니다.';
    END if;
END //

DELIMITER ;

CALL AddReport(13, '블랙컨슈머', '악성 댓글 작성', 1, 1);