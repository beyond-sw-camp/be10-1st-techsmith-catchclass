	-- #75 원데이 클래스 문의 목록 조회 

DROP PROCEDURE IF EXISTS GetInquiryList;

DELIMITER //

CREATE PROCEDURE GetInquiryList()
BEGIN 

    SELECT
        u.login_id AS 작성자ID,
        i.inq_title AS 제목,
        i.inq_secret AS 비밀글여부

    FROM inquiry i 
    JOIN users u ON i.user_id = u.user_id
    WHERE i.inq_secret = FALSE;
END //

DELIMITER ; 

CALL GetInquiryList();	
