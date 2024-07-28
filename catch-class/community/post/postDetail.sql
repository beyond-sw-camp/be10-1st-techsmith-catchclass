-- 게시물 상세조회
DROP PROCEDURE IF EXISTS DetailPost;

DELIMITER //

CREATE PROCEDURE DetailPost(
    IN p_post_id INT
)
BEGIN 
    SELECT 
        p.post_title AS 게시글_제목,
        p.post_content AS 게시글_내용,
        COALESCE(u.user_name, '알수없음') AS 게시물_작성자,
        CASE 
            WHEN c.comment_content IS NULL THEN '아직 댓글이 없음'
            ELSE COALESCE(cu.user_name, '알수없음')
        END AS 댓글_작성자_이름,
        c.comment_content AS 댓글_내용,
        COALESCE(CONCAT(c.comment_update_time, '(수정)'), c.comment_time) AS 최근_댓글_작성시간
    FROM post p
    LEFT JOIN users u ON u.user_id = p.user_id
    LEFT JOIN comments c ON c.post_id = p.post_id
    LEFT JOIN users cu ON cu.user_id = c.user_id
    WHERE p.post_id = p_post_id;
END //

DELIMITER ;

-- CALL DetailPost(1);
