-- 예약한 클래스 출석
DELIMITER //

CREATE PROCEDURE UpdateAttendanceStatus(
    IN reservation_id_param INT
)
BEGIN
    DECLARE current_status BOOLEAN;
    
    SELECT reservation_status
    INTO current_status
    FROM reservation
    WHERE reservation_id = reservation_id_param;

    IF current_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '예약이 존재하지 않습니다.';
    ELSE
        UPDATE reservation
        SET attend = TRUE
        WHERE reservation_id = reservation_id_param;
        
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '출석 상태 업데이트에 실패했습니다.';
        END IF;
    END IF;
    
END //

DELIMITER ;

-- CALL UpdateAttendanceStatus(3);