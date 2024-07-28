DELIMITER //

CREATE PROCEDURE AddReport(
    IN AR_id INT,
    IN AR_title VARCHAR(100),
    IN AR_content VARCHAR(300),
    IN AR_user_id INT,
    IN AR_re_id INT  -- re_id를 매개변수로 추가
)
BEGIN
    -- 외래 키 제약 조건을 충족하는지 확인
    IF EXISTS (SELECT 1 FROM users WHERE user_id = AR_user_id) and
       EXISTS (SELECT 1 FROM review WHERE re_id = AR_re_id) and
       NOT (TRIM(AR_title) = '') and
       NOT (TRIM(AR_content) = '') then
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
       SET MESSAGE_TEXT = 'AR_re_id, AR_user_id, report_title, report_content 값이 참조 테이블에 유효하지 않거나 빈 값입니다.';
    END if;
END //

DELIMITER ;

-- -- 후기 신고 트리거(글 카테고리가 선택 안됨을 방지)
-- DELIMITER //

-- CREATE TRIGGER EnsureAtLeastOneFkNotNull
-- BEFORE INSERT ON report
-- FOR EACH ROW
-- BEGIN
--     IF NEW.re_id IS NULL 
--        AND NEW.class_id IS NULL 
--        AND NEW.comment_id IS NULL 
--        AND NEW.post_id IS NULL THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '신고 대상 카테고리를 선택하시오';
--     END IF;
-- END//

-- DELIMITER ;


CALL AddReport(13, '블랙컨슈머', '악성 댓글 작성', 1, 1);