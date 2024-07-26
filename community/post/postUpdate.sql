-- 게시글 수정
DROP PROCEDURE if EXISTS UpdatePost;
DELIMITER //

CREATE PROCEDURE UpdatePost(
    IN p_post_id INT,
    IN p_post_title VARCHAR(100),
    IN p_post_content VARCHAR(300)
)
BEGIN
    UPDATE post
    SET
        post_title = p_post_title,
        post_content = p_post_content,
        post_update = NOW()  -- 현재 로컬 타임스탬프
    WHERE post_id = p_post_id;
END //

DELIMITER ;

CALL UpdatePost(9, '수업 좋아요', '재밌게 채험하고 왔어요. 여러분들도 해 보세요~!~');

-- 확인
-- SELECT * FROM post;