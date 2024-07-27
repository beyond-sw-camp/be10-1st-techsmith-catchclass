-- 사업자 인증 신청 내역(미확인된 것) 조회
DROP PROCEDURE IF EXISTS CheckCert;
DELIMITER //

CREATE PROCEDURE CheckCert()
BEGIN
	SELECT user_id, img_url
	FROM image
	WHERE img_ctg ='certification' 
		AND cert_check ='unchecked';
END //

DELIMITER ;

CALL CheckCert();