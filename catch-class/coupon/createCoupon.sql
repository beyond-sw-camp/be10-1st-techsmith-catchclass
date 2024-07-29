-- 쿠폰 등록
DROP PROCEDURE IF EXISTS InsertCoupon;

DELIMITER //
CREATE PROCEDURE InsertCoupon (
    IN p_coupon_name VARCHAR(255),
    IN p_coupon_price INT,
    IN p_coupon_amount INT,
    IN p_coupon_created DATETIME,
    IN p_coupon_expire_date DATETIME,
    IN p_class_id INT
)
BEGIN
    DECLARE coupon_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰을 등록할 때 에러가 발생했습니다.';
    END;
    
    -- 값 검증
    IF p_coupon_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰이름은 공백일 수 없습니다.';
    END IF;
    IF p_coupon_price <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 가격은 0보다 커야 합니다.';
    END IF;
    IF p_coupon_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 수량은 0보다 커야 합니다.';
    END IF;
    IF p_coupon_created IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 생성 날짜는 NULL일 수 없습니다.';
    END IF;
    IF p_coupon_expire_date IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 만료 날짜는 NULL일 수 없습니다.';
    END IF;
    IF p_class_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '클래스 ID는 0보다 커야 합니다.';
    END IF;
    
    START TRANSACTION;
    
    -- 쿠폰 이름의 중복 여부 확인
    SELECT COUNT(*) INTO coupon_exists
      FROM coupon
     WHERE coupon_name = p_coupon_name;
     
    IF coupon_exists > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 존재하는 쿠폰의 이름입니다.';
    ELSE
        INSERT INTO coupon (
            coupon_name,
            coupon_price,
            coupon_amount,
            coupon_created,
            coupon_expire_date,
            class_id
        ) VALUES (
            p_coupon_name,
            p_coupon_price,
            p_coupon_amount,
            p_coupon_created,
            p_coupon_expire_date,
            p_class_id
        );
    END IF;

    COMMIT;
END //
DELIMITER ;

-- CALL InsertCoupon('test', 3000, 10, '2024-07-01 10:00:00', '2024-12-01 23:59:59', 1);
-- 생성시 쿠폰 상태는 FALSE로 생성됨(미승인)
