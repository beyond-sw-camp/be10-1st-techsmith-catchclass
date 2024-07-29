-- 아이디 찾기
DROP PROCEDURE IF EXISTS FindId;
DELIMITER //

CREATE PROCEDURE FindId(IN name_para VARCHAR(15), IN telphone_para VARCHAR(15))
BEGIN
	DECLARE result_count INT;
	
	SELECT COUNT(*) INTO result_count
	FROM users
	WHERE user_name = name_para 
		AND telphone = telphone_para;
	
	IF result_count = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '일치하는 정보가 없습니다.';
	ELSE
		SELECT login_id
			FROM users
		WHERE user_name = name_para 
			AND telphone = telphone_para;
	END IF;
END //

DELIMITER ;

-- CALL FindId('Alice', '010-1234-5679');