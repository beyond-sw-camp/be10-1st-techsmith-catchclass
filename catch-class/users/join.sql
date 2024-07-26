-- 회원가입
INSERT INTO users(login_id, pwd, user_name, birthdate, telphone, gender, authority) VALUES
('user_12', 'pass12', 'Stella', '2001-10-15', '010-7122-3462', 'F', 'user');

SELECT * FROM USERs;
-- 회원가입 예외처리 트리거
DELIMITER //

CREATE TRIGGER before_sign_up_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	IF NEW.login_id = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '아이디는 공백일 수 없습니다.';
	END IF;
	
	IF NEW.pwd = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '비밀번호는 공백일 수 없습니다.';
	END IF;
	
	IF NEW.user_name = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이름은 공백일 수 없습니다.';
	END IF;
	
	IF NEW.birthdate = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '생년월일은 공백일 수 없습니다.';
	END IF;
	
	IF NEW.telphone = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '전화번호는 공백일 수 없습니다.';
	END IF;
END //	
		
DELIMITER ;