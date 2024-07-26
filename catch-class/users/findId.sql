-- 아이디 찾기
DROP PROCEDURE IF EXISTS FindId;
DELIMITER //

CREATE PROCEDURE FindId(IN name_para VARCHAR(15), IN telphone_para VARCHAR(15))
BEGIN
	SELECT login_id
		FROM users
	WHERE user_name = name_para 
		AND telphone = telphone_para;
END //

DELIMITER ;

-- CALL FindId('Alice', '010-1234-5678');