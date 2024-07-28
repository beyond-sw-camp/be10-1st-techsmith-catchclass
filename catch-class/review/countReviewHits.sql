DELIMITER //

CREATE PROCEDURE ViewLikesCountByReid(
    IN input_re_id INT
)
BEGIN
    SELECT COUNT(DISTINCT user_id) AS 좋아요수 -- 등록된 유저 아이디 카운트
    FROM review_hits
    WHERE re_id = input_re_id; 
END //

DELIMITER ;

-- CALL ViewLikesCountByReid(10);