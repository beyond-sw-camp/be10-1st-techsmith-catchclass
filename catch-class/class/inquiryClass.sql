-- #69. 원데이 클래스 문의 작성


DROP PROCEDURE IF EXISTS InquiryClass;
DELIMITER //

CREATE PROCEDURE InquiryClass(
    IN inq_title VARCHAR(255),       
    IN inq_content TEXT,           
    IN inq_secret TINYINT,            
    IN user_id INT,                
    IN class_id INT             
)
BEGIN
    INSERT INTO inquiry (
        inq_title,
        inq_content,
        inq_time,
        inq_secret,
        user_id,
        class_id,
        res_content,
        res_time
    )
    VALUES (
        inq_title,       
        inq_content,     
        LOCALTIMESTAMP(),
        inq_secret,     
        user_id,         
        class_id,        
        NULL,           
        NULL           
    );
END //

DELIMITER ;
CALL InquiryClass('문의1', '문의내용1', 1, 3, 1);

-- 실행 확인
-- SELECT * FROM inquiry;	
