-- 댓글 신고 기능 
-- 본인 댓글, 이미 신고한 댓글 신고불가능
-- DROP PROCEDURE if EXISTS ReportComment;
DELIMITER //class_list

CREATE PROCEDURE ReportComment(
    IN p_report_title VARCHAR(100),
    IN p_report_content VARCHAR(300),
    IN p_user_id INT,
    IN p_comment_id INT
)
BEGIN
    DECLARE comment_author_id INT;
    DECLARE already_comment INT;

    -- 댓글 작성자의 ID를 가져옵니다.
    SELECT user_id INTO comment_author_id
    FROM comments
    WHERE comment_id = p_comment_id;

    -- 이미 신고한 댓글인지 확인합니다.
    SELECT COUNT(*) INTO already_comment
    FROM report
    WHERE user_id = p_user_id
      AND comment_id = p_comment_id
      AND report_type = 'comment';

    -- 댓글 작성자와 신고자가 다른 경우에만 신고를 기록합니다.
    IF comment_author_id IS NOT NULL AND comment_author_id <> p_user_id THEN
        IF already_comment = 0 THEN
            INSERT INTO report (
                report_title,
                report_content,
                report_type,
                user_id,
                comment_id,
                report_time
            ) VALUES (
                p_report_title,
                p_report_content,
                'comment',
                p_user_id,
                p_comment_id,
                NOW()
            );
        ELSE
            -- 이미 신고한 댓글에 대해 다시 신고하려는 경우 에러 처리
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 신고한 댓글입니다.';
        END IF;
    ELSE
        -- 댓글 작성자와 신고자가 동일한 경우, 에러 처리 또는 메시지 출력 (선택적)
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '본인의 댓글은 신고할 수 없습니다.';
    END IF;
END //

DELIMITER ;

CALL ReportComment('욕설 신고','욕했음',5,2);
-- SELECT * FROM report;