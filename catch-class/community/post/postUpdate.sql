-- 게시글 수정
DROP PROCEDURE if EXISTS UpdatePost;
DELIMITER //

CREATE PROCEDURE UpdatePost(
    IN p_user_id INT,
    IN p_post_id INT,
    IN p_post_title VARCHAR(100),
    IN p_post_content VARCHAR(300)
)
BEGIN
    DECLARE post_author_id INT;
    DECLARE post_status_check BOOLEAN;

    -- post 테이블에서 user_id와 post_status를 가져옵니다.
    SELECT user_id, post_status INTO post_author_id, post_status_check
    FROM post
    WHERE post_id = p_post_id;

    -- post_status가 false인 경우 에러를 발생시킵니다.
    IF post_status_check = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 삭제된 게시물입니다.';
    -- 입력된 user_id와 post의 user_id가 다르면 에러를 발생시킵니다.
    ELSEIF post_author_id <> p_user_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '수정 권한이 없습니다.';
    ELSE
        -- 입력된 user_id가 post의 user_id와 일치하고, post_status가 true인 경우 업데이트를 수행합니다.
        UPDATE post
        SET
            post_title = p_post_title,
            post_content = p_post_content,
            post_update = NOW()  -- 현재 로컬 타임스탬프
        WHERE post_id = p_post_id;
    END IF;
END //

DELIMITER ;

-- CALL UpdatePost(1, 1, '수업 좋아요', '재밌게 채험하고 왔어요. 여러분들도 해 보세요~!~');

-- 확인
-- SELECT * FROM post;