DELIMITER //

CREATE PROCEDURE ViewReviewsTime()
BEGIN
		SELECT
		       b.re_title 후기제목
		     , b.re_content 후기내용
		     , b.rating 별점
		     , b.re_time 후기작성시간
		     , COALESCE(c.user_name, '알수없음') 회원명 -- 회원 정보 없는 경우 회원 이름 '알수없음'으로 변경
		  FROM review b
		  JOIN reservation a ON a.reservation_id = b.reservation_id
		  left JOIN users c ON c.user_id = a.user_id
		WHERE re_status = TRUE
		ORDER BY re_time DESC; -- 최신순으로 정렬
END //

DELIMITER ;

CALL ViewReviewsTime();