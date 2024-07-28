DROP PROCEDURE IF EXISTS UpdateClassStatus;
DELIMITER //

CREATE PROCEDURE UpdateClassStatus()
BEGIN
    UPDATE subclass
    SET subclass_status = CASE
        WHEN NOW() >= end_time THEN 0 
        WHEN NOW() <= start_time AND reservation_limit > reservation_count THEN 1
        WHEN NOW() <= start_time and reservation_limit = reservation_count THEN 2
        ELSE subclass_status 
    END;
END //

DELIMITER ;


CALL UpdateClassStatus();
SELECT * FROM subclass;

-- 조건에 따른 테스트 구문 
INSERT INTO subclass (tutor_name, subclass_content, reservation_limit, reservation_count, room_info, class_date, start_time, end_time, class_id) VALUES
('종료test', '1', 20, 10, 'A1', '2024-08-01 10:00:00', '2024-07-20 10:00:00', '2024-07-20 12:00:00', 1),
('모집중tes', '2', 20, 10, 'A2', '2024-08-01 10:00:00', '2024-08-01 10:00:00', '2024-08-01 12:00:00', 1),
('모집완료test', '3', 20, 20, 'A3', '2024-08-01 10:00:00', '2024-08-01 10:00:00', '2024-08-01 12:00:00', 1)

-- CALL UpdateClassStatus();
-- SELECT * FROM subclass;