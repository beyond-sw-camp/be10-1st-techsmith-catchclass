-- 사업자 인증 및 권한 변경 프로시저
DROP PROCEDURE IF EXISTS AcceptCert;

DELIMITER //

CREATE PROCEDURE AcceptCert(IN user_id_para INT)
BEGIN
	START TRANSACTION;
		UPDATE image
			SET cert_check = 'accept'
		WHERE img_ctg='certification' AND user_id = user_id_para;
		
		UPDATE users
			SET authority='tutor'
		WHERE user_id = user_id_para;
	COMMIT;
	-- ROLLBACK;	
END //
DELIMITER ;

-- CALL AcceptCert(5);

-- 사업자 인증 반려
DROP PROCEDURE IF EXISTS RejectCert;
DELIMITER //

CREATE PROCEDURE RejectCert(IN user_id_para INT)
BEGIN
	UPDATE image 
		SET cert_check = 'reject'
	WHERE user_id=user_id_para;
END //
DELIMITER ;

-- CALL RejectCert(2);