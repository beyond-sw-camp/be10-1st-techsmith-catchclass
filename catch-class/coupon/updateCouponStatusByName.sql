-- 쿠폰 상태 변경
DROP PROCEDURE IF EXISTS UpdateCouponStatusByName;

DELIMITER //
CREATE PROCEDURE UpdateCouponStatusByName (
    IN p_coupon_name VARCHAR(255),
    IN p_coupon_status BOOLEAN
)
BEGIN
    DECLARE coupon_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 상태 변경 도중 에러가 발생했습니다.';
    END;
    
    -- 값 검증
    IF p_coupon_name IS NULL OR p_coupon_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 이름이 유효하지 않습니다.';
    END IF;

    IF p_coupon_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 상태가 유효하지 않습니다.';
    END IF;
    
    START TRANSACTION;
    
    -- 쿠폰 이름으로 쿠폰 존재 여부 확인
    SELECT COUNT(*) INTO coupon_exists
      FROM coupon
     WHERE coupon_name = p_coupon_name;

    -- 쿠폰이 존재하지 않으면 에러 발생
    IF coupon_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '해당 이름을 가진 쿠폰이 존재하지 않습니다.';
    ELSE
        -- 쿠폰이 존재하면 상태 변경
        UPDATE coupon
           SET coupon_status = p_coupon_status
         WHERE coupon_name = p_coupon_name;
    END IF;
    
    COMMIT;
END //
DELIMITER ;

-- CALL UpdateCouponStatusByName('test', TRUE);
-- 승인(TRUE) 상태로 변경
