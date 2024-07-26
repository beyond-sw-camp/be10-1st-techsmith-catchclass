-- 내 정보 조회
DROP PROCEDURE IF EXISTS CheckUserInfo;
DELIMITER //

CREATE PROCEDURE CheckUserInfo(IN user_id_para INT, pwd_para VARCHAR(20))
BEGIN
	SELECT 
			 user_name
		  , birthdate
		  , telphone
		  , gender
		FROM users
	WHERE user_id = user_id_para AND pwd = pwd_para;
END //

DELIMITER ;
-- CALL CheckUserInfo(3, 'pass3');