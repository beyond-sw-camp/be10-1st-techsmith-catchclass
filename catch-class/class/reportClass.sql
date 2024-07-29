-- #113 원데이 클래스 게시글 신고 

DELIMITER //

DROP PROCEDURE IF EXISTS ReportClass;

CREATE PROCEDURE ReportClass(
    IN r_report_title VARCHAR(100),  
    IN r_report_content VARCHAR(300),  
    IN c_class_id INT,  
    IN u_user_id INT  
)
BEGIN 
    DECLARE class_user_id INT;  -- 클래스의 사용자 ID를 저장할 변수
    
    -- class_id에 해당하는 사용자 ID를 조회
    SELECT user_id INTO class_user_id
    FROM class
    WHERE class_id = c_class_id;
    
    -- 오인 신고 방지를 위한 입력받은 user_id가 해당 클래스  사업자의 user_id와 일치하는지 확인
    IF class_user_id = u_user_id THEN
        -- 신고를 생성
        INSERT INTO report (
            report_title, 
            report_content,
            report_type,
            user_id,
            class_id,
            report_time
        )
        VALUES (
            r_report_title,
            r_report_content,
            'class',  -- 신고 유형 ('class'로 고정)
            u_user_id,
            c_class_id,
            NOW()  -- 현재 시각
        );
    ELSE
        -- 클래스와 사업자 일치하지 않는 경우 오류
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '클래스와 사업자가 일치하지 않습니다.';
    END IF;
END //

DELIMITER ;

-- CALL ReportClass('불쾌한 발언', '불쾌감을 유발합니다.', 2, 3);

-- SELECT * FROM report;

