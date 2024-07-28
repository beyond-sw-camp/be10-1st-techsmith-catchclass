-- 댓글 삭제
-- DROP PROCEDURE IF EXISTS DeleteComment;
DELIMITER //

CREATE PROCEDURE DeleteComment(
    IN c_user_id INT,
    IN c_comment_id INT
)
BEGIN
    DECLARE comment_author_id INT;
    DECLARE comment_status BOOLEAN;

    -- 댓글 작성자의 ID와 상태를 가져옵니다.
    SELECT user_id, comment_status INTO comment_author_id, comment_status
    FROM comments
    WHERE comment_id = c_comment_id;

    -- 댓글이 존재하지 않는 경우 에러 처리
    IF comment_author_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '존재하지 않는 댓글입니다.';
    -- 이미 삭제된 댓글인 경우 에러 처리
    ELSEIF comment_status = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 삭제된 댓글입니다.';
    -- 댓글 작성자가 현재 사용자와 다른 경우 에러 처리
    ELSEIF comment_author_id <> c_user_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '다른 사용자의 댓글은 삭제할 수 없습니다.';
    ELSE
        -- 댓글 상태를 false로 업데이트
        UPDATE comments
        SET comment_status = false
        WHERE comment_id = c_comment_id
        AND user_id = c_user_id;
    END IF;
END //

DELIMITER ;


-- CALL DeleteComment(1,1);
-- 확인
-- SELECT * FROM comments;