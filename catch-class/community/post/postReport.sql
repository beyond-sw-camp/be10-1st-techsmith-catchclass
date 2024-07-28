-- 게시물 목록 조회
-- DROP PROCEDURE if EXISTS ReportPost;
DELIMITER //

CREATE PROCEDURE ReportPost(
    IN p_report_title VARCHAR(100),
    IN p_report_content VARCHAR(300),
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    DECLARE post_author_id INT;
    DECLARE already_reported INT;

    -- 게시물 작성자의 ID를 가져옵니다.
    SELECT user_id INTO post_author_id
    FROM comments
    WHERE post_id = p_post_id
    LIMIT 1;

    -- 게시물이 존재하지 않는 경우 오류를 발생시킵니다.
    IF post_author_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '해당 게시물이 존재하지 않습니다.';
    ELSE
        -- 사용자가 이미 해당 게시물을 신고했는지 확인합니다.
        SELECT COUNT(*) INTO already_reported
        FROM report
        WHERE user_id = p_user_id
          AND post_id = p_post_id
          AND report_type = 'post';

        -- 게시물 작성자가 신고자와 동일하지 않은지 확인합니다.
        IF post_author_id <> p_user_id THEN
            -- 사용자가 아직 해당 게시물을 신고하지 않은 경우
            IF already_reported = 0 THEN
                INSERT INTO report (
                    report_title,
                    report_content,
                    report_type,
                    user_id,
                    post_id,
                    report_time
                ) VALUES (
                    p_report_title,
                    p_report_content,
                    'post',
                    p_user_id,
                    p_post_id,
                    NOW()
                );
            ELSE
                -- 이미 신고한 게시물에 대해 다시 신고하려는 경우 오류 처리
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 신고한 게시물입니다.';
            END IF;
        ELSE
            -- 댓글 작성자와 신고자가 동일한 경우 오류 처리
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '본인의 게시글은 신고할 수 없습니다.';
        END IF;
    END IF;
END //

DELIMITER ;

-- 절차 테스트
CALL ReportPost('신고', '신고 내용', 5, 2);

-- 확인 :
SELECT * FROM report;
