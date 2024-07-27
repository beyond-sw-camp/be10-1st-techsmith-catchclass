-- 예약 취소 프로시저
DELIMITER //

CREATE OR REPLACE PROCEDURE CancelReservation(
    IN reservation_id_param INT
)
BEGIN
    DECLARE round_id_value INT;
    DECLARE reservation_qty_value INT;
    DECLARE coupon_owner_id_value INT;
    DECLARE cancel_payment_status BOOLEAN;

    START TRANSACTION;

    SELECT 
        round_id, 
        reservation_qty, 
        coupon_owner_id
    INTO 
        round_id_value, 
        reservation_qty_value, 
        coupon_owner_id_value
    FROM 
        reservation
    WHERE 
        reservation_id = reservation_id_param;

    IF reservation_id_param IS NULL OR round_id_value IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '예약이 존재하지 않습니다.';
    END IF;

    IF (SELECT reservation_status FROM reservation WHERE reservation_id = reservation_id_param) = FALSE THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '예약이 이미 취소되었습니다.';
    END IF;

    CALL ProcessCancelPayment(@cancel_payment_status);

    IF @cancel_payment_status THEN
        CALL UpdateReservationAndSubclass(reservation_id_param, round_id_value, reservation_qty_value);
        
        IF coupon_owner_id_value IS NOT NULL THEN
            CALL RestoreCouponStatus(coupon_owner_id_value);
        END IF;

        COMMIT;

    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '결제 취소에 실패했습니다. 다시 진행해주세요.';
    END IF;
    
END //

DELIMITER ;

CALL CancelReservation(11);

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

-- 쿠폰 상태 복원 프로시저
DELIMITER //

CREATE PROCEDURE RestoreCouponStatus(
    IN coupon_owner_id_param INT
)
BEGIN
    DECLARE coupon_id_value INT;
    
    IF coupon_owner_id_param IS NOT NULL THEN
        SELECT coupon_id
        INTO coupon_id_value
        FROM coupon_owner
        WHERE coupon_owner_id = coupon_owner_id_param;

        IF coupon_id_value IS NOT NULL THEN
            UPDATE coupon
            SET coupon_amount = coupon_amount + 1
            WHERE coupon_id = coupon_id_value;

            UPDATE coupon_owner
            SET coupon_status = TRUE
            WHERE coupon_owner_id = coupon_owner_id_param;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '유효한 쿠폰이 없습니다.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '유효한 쿠폰 소유자가 아닙니다.';
    END IF;
END //

DELIMITER ;