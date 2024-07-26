-- 게시글 삭제
-- DROP PROCEDURE if EXISTS DeletePost;

DELIMITER //

CREATE PROCEDURE DeletePost(IN p_post_id INT)
BEGIN
    update post
    	SET post_status = false
    WHERE post_id = p_post_id;
    update comments
    	SET comment_status = false
    WHERE post_id = p_post_id;
END // 

DELIMITER ;   

CALL DeletePost(1);
-- 확인 
-- SELECT *  FROM post;
