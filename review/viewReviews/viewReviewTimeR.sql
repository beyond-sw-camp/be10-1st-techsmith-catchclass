-- 후기 목록 오래된순 조회 프로시저 
DELIMITER //

CREATE PROCEDURE ViewReviewTimeR()
BEGIN
		SELECT
		       b.re_title
		     , b.re_content
		     , b.rating
		     , b.re_time
		     , COALESCE(c.user_name, '알수없음')
		  FROM review b
		  JOIN reservation a ON a.reservation_id = b.reservation_id
		  left JOIN users c ON c.user_id = a.user_id
		WHERE re_status = TRUE
		ORDER BY re_time;
END //

DELIMITER ;