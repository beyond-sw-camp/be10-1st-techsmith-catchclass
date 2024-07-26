-- 게시글 신고
DROP PROCEDURE if EXISTS ReportPost;
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
    -- 댓글 작성자의 ID를 가져옵니다.
    SELECT user_id INTO post_author_id
    FROM comments
    WHERE post_id = p_post_id;
    
    SELECT COUNT(*) INTO already_reported
    FROM report
    WHERE user_id = p_user_id
      AND post_id = p_post_id
      AND report_type = 'post';
    
    if post_author_id IS NOT NULL AND post_author_id <> p_user_id THEN
    	if already_reported = 0  then
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
	            -- 이미 신고한 게시물에 대해 다시 신고하려는 경우 에러 처리
	            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 신고한 게시물입니다.';
	        END IF;
	        
    ELSE
        -- 댓글 작성자와 신고자가 동일한 경우, 에러 처리 또는 메시지 출력 (선택적)
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '본인의 게시글은 신고할 수 없습니다';
    END IF;
END //

DELIMITER ;

CALL ReportPost('유언비어', '거짓말임.', 3, 2);

SELECT *FROM report;