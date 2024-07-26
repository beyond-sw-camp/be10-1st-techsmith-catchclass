--  후기 목록 기본 조회 프로시저
DELIMITER //

CREATE PROCEDURE ViewReviews()
BEGIN
		SELECT 
		       b.re_title 후기제목
		     , b.re_content 후기내용
		     , b.rating 별점
		     , b.re_time 후기작성시간
		     , COALESCE(c.user_name, '알수없음') 후기작성자
		     , e.class_name 클래스이름
		     , d.class_date 클래스날짜
		     , d.start_time 클래스시간
		  FROM review b
		  JOIN reservation a ON a.reservation_id = b.reservation_id
		  left JOIN users c ON c.user_id = a.user_id
		  JOIN subclass d ON d.subclass_id = a.round_id
		  JOIN class e ON e.class_id = d.class_id
		WHERE re_status = TRUE;
END //

DELIMITER ;

CALL ViewReviews();