DELIMITER //
	
CREATE PROCEDURE InquiryList()
	BEGIN 
		SELECT
		    u.login_id 
		    i.inq_title 
		FROM inquiry i 
		JOIN users u ON i.user_id = u.user_id
		WHERE i.inq_secret = FALSE;
	END //
		
DELIMITER ; 

CALL InquiryList();	