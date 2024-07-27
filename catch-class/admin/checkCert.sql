-- 사업자 인증 신청 내역 전체 조회
DROP PROCEDURE IF EXISTS SelectCertAll;
DELIMITER //

CREATE PROCEDURE CheckCert()
BEGIN
	SELECT user_id, img_url
	FROM image
	WHERE img_ctg ='certification';
END //

DELIMITER ;

-- CALL CheckCert();


-- 사업자 인증 신청 내역 중 cert_check 상태 별로 조회
DROP PROCEDURE IF EXISTS SelectCertByCertCheck;
DELIMITER //

CREATE PROCEDURE SelectCertByCertCheck(IN cert_check_para VARCHAR(20))
BEGIN
	SELECT user_id, img_url
	FROM image
	WHERE img_ctg ='certification' 
		AND cert_check =cert_check_para;
END //

DELIMITER ;

-- CALL SelectCertByCertCheck('reject');
