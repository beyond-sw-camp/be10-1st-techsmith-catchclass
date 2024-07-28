-- 댓글 수정
-- DROP PROCEDURE IF EXISTS UpdateComment;

DELIMITER //

-- 새로운 프로시저 생성
CREATE PROCEDURE UpdateComment(
    IN c_user_id INT,
    IN c_comment_id INT,
    IN c_comment_content VARCHAR(100)
)
BEGIN
    DECLARE comment_author_id INT;
    DECLARE comment_status TINYINT;

    -- 댓글 작성자의 ID와 상태를 가져옴
    SELECT user_id, comment_status INTO comment_author_id, comment_status
    FROM comments
    WHERE comment_id = c_comment_id;

    -- 댓글이 존재하지 않는 경우 에러 처리
    IF comment_author_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '존재하지 않는 댓글입니다.';
    -- 댓글 상태가 false인 경우 에러 처리
    ELSEIF comment_status = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 삭제된 댓글은 수정할 수 없습니다.';
    -- 댓글 작성자가 현재 사용자와 다른 경우 에러 처리
    ELSEIF comment_author_id <> c_user_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '다른 사용자의 댓글은 수정할 수 없습니다.';
    ELSE
        -- 자신의 댓글을 업데이트
        UPDATE comments
        SET
            comment_content = c_comment_content,
            comment_update_time = NOW()
        WHERE comment_id = c_comment_id;
    END IF;
END //

DELIMITER ;


-- CALL UpdateComment(1,1,'네네');
-- SELECT * FROM comments;
