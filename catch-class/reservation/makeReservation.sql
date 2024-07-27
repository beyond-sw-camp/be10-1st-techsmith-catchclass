/*
예약 등록
*/

-- 가격 계산 프로시저
DELIMITER //

CREATE PROCEDURE CalculateFinalPrice(
    IN round_id_param INT,
    IN reservation_qty_param INT,
    IN coupon_owner_id_param INT,
    OUT final_price_param INT
)
BEGIN
    DECLARE class_price INT;
    DECLARE coupon_price INT DEFAULT 0;

    SELECT price
    INTO class_price
    FROM class
    WHERE class_id = (
        SELECT class_id
        FROM subclass
        WHERE subclass_id = round_id_param
    );

    IF coupon_owner_id_param IS NOT NULL THEN
        SELECT c.coupon_price
        INTO coupon_price
        FROM coupon c
        JOIN coupon_owner co ON c.coupon_id = co.coupon_id
        WHERE co.coupon_owner_id = coupon_owner_id_param;

        IF coupon_price IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '유효한 쿠폰이 없습니다.';
        END IF;
    END IF;

    SET final_price_param = (class_price - coupon_price) * reservation_qty_param;

END //

DELIMITER ;

-- 예약 정보 insert 프로시저
DELIMITER //

CREATE PROCEDURE InsertReservation(
    IN user_id_param INT,
    IN round_id_param INT,
    IN reservation_qty_param INT,
    IN final_price_param INT,
    IN coupon_owner_id_param INT
)
BEGIN
    INSERT INTO reservation (
        user_id,
        round_id,
        reservation_qty,
        reservation_time,
        total_price,
        final_price,
        reservation_status,
        coupon_owner_id
    ) VALUES (
        user_id_param,
        round_id_param,
        reservation_qty_param,
        NOW(),
        (SELECT price FROM class WHERE class_id = (SELECT class_id FROM subclass WHERE subclass_id = round_id_param)) * reservation_qty_param,
        final_price_param,
        TRUE,
        coupon_owner_id_param
    );
END //

DELIMITER ;

-- 예약 인원 업데이트
DELIMITER //

CREATE PROCEDURE UpdateReservationCount(
    IN round_id_param INT,
    IN reservation_qty_param INT
)
BEGIN
    UPDATE subclass
    SET reservation_count = reservation_count + reservation_qty_param
    WHERE subclass_id = round_id_param;
END //

DELIMITER ;
