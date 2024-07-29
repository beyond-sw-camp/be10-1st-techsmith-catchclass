-- 게시글 삭제
-- DROP PROCEDURE if EXISTS DeletePost;

DELIMITER //

CREATE PROCEDURE DeletePost(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    DECLARE post_author_id INT;
	 DECLARE post_status_check BOOLEAN;     
    -- post 테이블에서 user_id를 가져옵니다.
    SELECT user_id, post_status INTO post_author_id, post_status_check
    FROM post
    WHERE post_id = p_post_id;

    -- 입력된 user_id와 post의 user_id가 다르면 에러를 발생시킵니다.
    IF post_author_id <> p_user_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '삭제 권한이 없습니다.';
    ELSEIF post_status_check = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 삭제된 게시글입니다.';
    ELSE
        -- 입력된 user_id가 post의 user_id와 일치하면 post와 comments의 상태를 false로 업데이트합니다.
        UPDATE post
        SET post_status = false
        WHERE post_id = p_post_id;

        UPDATE comments
        SET comment_status = false
        WHERE post_id = p_post_id;
    END IF;
END //

DELIMITER ;   

-- CALL DeletePost(1,1);
-- 확인 
-- SELECT *  FROM post;