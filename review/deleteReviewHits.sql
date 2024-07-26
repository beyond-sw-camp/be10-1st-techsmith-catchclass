--  후기 좋아요 삭제 프로시저

DELIMITER //

CREATE PROCEDURE DeleteReviewHits(
    IN d_rehit_user_id INT,
    IN d_rehit_re_id INT 
)
BEGIN
   DELETE FROM review_hits
	WHERE user_id = d_rehit_user_id
   AND re_id = d_rehit_re_id;
END //

DELIMITER ;

-- 10. 후기 좋아요 수 조회 프로시저
DELIMITER //

CREATE PROCEDURE ViewLikesCountByReid(
    IN input_re_id INT
)
BEGIN
    SELECT COUNT(DISTINCT user_id) AS likes_count
    FROM review_hits
    WHERE re_id = input_re_id;
END //

DELIMITER ;