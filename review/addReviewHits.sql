-- 후기 좋아요 등록 프로시저

DELIMITER //

CREATE PROCEDURE AddReviewHits(
    IN a_re_user_id int,
    IN a_re_re_id int
)
BEGIN
		-- 외래키 제약 조건 확인
	    if	EXISTS (SELECT 1 FROM users WHERE user_id = a_re_user_id) AND	
	        EXISTS (SELECT 1 FROM review WHERE re_id = a_re_re_id) THEN
          INSERT INTO review_hits (
                      user_id,
                      re_id
			    )
					VALUES (
					        a_re_user_id,
			            a_re_re_id
			    );
	    ELSE
	    SIGNAL SQLSTATE '45000'
	    SET MESSAGE_TEXT = 'user_id, re_id값이 참조테이블에 유효하지 않습니다.';
	    END if;
   
END //

DELIMITER ;