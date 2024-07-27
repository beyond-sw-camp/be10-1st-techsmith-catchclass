-- 결제 취소 프로시저
DELIMITER //

CREATE PROCEDURE ProcessCancelPayment(
    OUT cancel_payment_status BOOLEAN
)
BEGIN
    -- 외부 결제 시스템 연동
    -- 결제 취소 로직 구현 필요
    
    -- 결제 취소 상태값 설정
    SET cancel_payment_status = TRUE; -- 결제 취소 성공
END //

DELIMITER ;

-- 예약 취소 시 상태 변경 및 회차 데이터 복원 프로시저
DELIMITER //

CREATE PROCEDURE UpdateReservationAndSubclass(
    IN reservation_id_param INT,
    IN round_id_param INT,
    IN reservation_qty_param INT
)
BEGIN
    UPDATE reservation
    SET reservation_status = FALSE
    WHERE reservation_id = reservation_id_param;

    UPDATE subclass
    SET reservation_count = reservation_count - reservation_qty_param
    WHERE subclass_id = round_id_param;
END //

DELIMITER ;