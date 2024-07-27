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

-- 예약 등록 프로시저
DELIMITER //

CREATE PROCEDURE MakeReservation(
    IN user_id_param INT,
    IN round_id_param INT,
    IN reservation_qty_param INT,
    IN coupon_owner_id_param INT
)
BEGIN
    DECLARE reservation_limit_value INT;
    DECLARE current_reservation_count INT;
    DECLARE final_price INT;
    DECLARE payment_status BOOLEAN;

    START TRANSACTION;

    SELECT reservation_limit, reservation_count
    INTO reservation_limit_value, current_reservation_count
    FROM subclass
    WHERE subclass_id = round_id_param;

    IF reservation_limit_value IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '회차가 존재하지 않습니다.';
    END IF;

    IF current_reservation_count + reservation_qty_param > reservation_limit_value THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '예약 정원을 초과하여 예약할 수 없습니다.';
    END IF;

    CALL CalculateFinalPrice(round_id_param, reservation_qty_param, coupon_owner_id_param, final_price);

    CALL ProcessPayment(payment_status);

    IF payment_status THEN
        CALL InsertReservation(user_id_param, round_id_param, reservation_qty_param, final_price, coupon_owner_id_param);

        CALL UpdateReservationCount(round_id_param, reservation_qty_param);

        COMMIT;

    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '결제에 실패했습니다. 다시 진행해주세요.';
    END IF;

END //

DELIMITER ;

-- CALL MakeReservation(2, 2, 2, 2);

-- 결제 프로시저
DELIMITER //

CREATE PROCEDURE ProcessPayment(
    OUT payment_status BOOLEAN
)
BEGIN
    -- 외부 결제 시스템 연동
    -- 결제 로직 구현 필요
    
    -- 결제 상태값 설정
    SET payment_status = TRUE; -- 결제 성공
END //

DELIMITER ;

-- 쿠폰 수량 감소 및 상태 변경 트리거
DELIMITER //

CREATE TRIGGER AfterReservationInsert
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
    IF NEW.coupon_owner_id IS NOT NULL THEN
        UPDATE coupon
        SET coupon_amount = coupon_amount - 1
        WHERE coupon_id = (
            SELECT coupon_id
            FROM coupon_owner
            WHERE coupon_owner_id = NEW.coupon_owner_id
        );

        UPDATE coupon_owner
        SET coupon_status = FALSE
        WHERE coupon_owner_id = NEW.coupon_owner_id;
    END IF;
END //

DELIMITER ;