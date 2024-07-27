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

CALL DeleteReviewHits(10,9);