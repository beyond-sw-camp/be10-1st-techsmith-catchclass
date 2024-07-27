DELIMITER //

CREATE PROCEDURE ViewReviewTimeR()
BEGIN
		SELECT
		       b.re_title
		     , b.re_content
		     , b.rating
		     , b.re_time
		     , COALESCE(c.user_name, '알수없음') -- 회원 탈퇴 시 회원 이름 '알수없음'으로 변경
		  FROM review b
		  JOIN reservation a ON a.reservation_id = b.reservation_id
		  left JOIN users c ON c.user_id = a.user_id
		WHERE re_status = TRUE
		ORDER BY re_time; -- 오래된 순으로 정렬
END //

DELIMITER ;

CALL ViewReviewTimeR();