-- 1. 원데이클래스에 대한 수업 목록 조회(클래스명, 사업자명)
DELIMITER // 

CREATE PROCEDURE class_list()
BEGIN 
	SELECT 
		c.class_name AS 클래스명,
		u.user_name AS 사업자명
	FROM class c
 	left JOIN users u ON c.user_id = u.user_id;
END //

DELIMITER ;

CALL class_list();