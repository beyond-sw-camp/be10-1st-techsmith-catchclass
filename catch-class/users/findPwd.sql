-- 비밀번호 찾기
DROP PROCEDURE IF EXISTS FindPwd;
DELIMITER //

CREATE PROCEDURE FindPwd(IN login_id_para VARCHAR(20), IN name_para VARCHAR(15), IN telphone_para VARCHAR(15))
BEGIN
	DECLARE result_count INT;
	
	SELECT COUNT(*) INTO result_count
	FROM users
	WHERE login_id = login_id_para
		AND user_name = name_para 
		AND telphone = telphone_para;
	
	IF result_count = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '일치하는 정보가 없습니다.';
	ELSE
		SELECT pwd
			FROM users
		WHERE login_id = login_id_para
		AND user_name = name_para 
		AND telphone = telphone_para;
	END IF;
END //

DELIMITER ;

CALL FindPwd('user2', 'Bob', '010-2345-6780');