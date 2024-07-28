-- #106 원데이클래스 문의에 대한 답변 등록 (문의 하나에 답변 1개 등록)
DROP PROCEDURE IF EXISTS ResponseInquiry;
DELIMITER //

CREATE PROCEDURE ResponseInquiry(
	IN i_inq_id INT,
	IN i_res_content VARCHAR(300)
)
BEGIN 
	DECLARE inquiry_status BOOLEAN;
	
	SELECT inq_status INTO inquiry_status
    FROM inquiry
    WHERE inq_id = i_inq_id;
	
	IF inquiry_status = TRUE then 
	UPDATE inquiry
	SET 
		res_content = i_res_content,
		res_time = NOW(),
		inq_status = FALSE
		WHERE inq_id = i_inq_id;
	ELSE 
	
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = '이미 답변이 등록되었습니다';
	END IF;
END //

DELIMITER ;

-- CALL ResponseInquiry(2, '수고하셨습니다');