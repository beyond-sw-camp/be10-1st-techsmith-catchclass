-- 내 정보 수정(비밀번호)
DROP PROCEDURE IF EXISTS EditPwd;
DELIMITER //

CREATE PROCEDURE EditPwd(IN user_id_para INT, IN pwd_para VARCHAR(20))
BEGIN
	UPDATE users
	SET pwd=pwd_para
	WHERE user_id=user_id_para;
END //

DELIMITER ;

-- CALL EditPwd(3, 'pwd_3');


-- 내 정보 수정(전화번호)
DROP PROCEDURE IF EXISTS EditTel;
DELIMITER //

CREATE PROCEDURE EditTel(
	IN user_id_para INT
 ,	IN tel_para VARCHAR(15)
)
BEGIN
	UPDATE users
	SET telphone = tel_para
	WHERE user_id=user_id_para;
END //

DELIMITER ;

-- CALL EditTel(3, '010-7122-3462');


-- 정보 수정 예외처리 트리거
DELIMITER //

CREATE TRIGGER before_user_info_update
BEFORE update ON users
FOR EACH ROW
BEGIN
	IF NEW.pwd = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '비밀번호는 공백일 수 없습니다.';
	END IF;
	IF NEW.telphone = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '전화번호는 공백일 수 없습니다.';
	END IF;	
END //			

DELIMITER ;