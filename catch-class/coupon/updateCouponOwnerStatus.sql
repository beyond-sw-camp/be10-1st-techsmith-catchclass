-- 쿠폰 사용 상태 변경
DROP PROCEDURE IF EXISTS UpdateCouponOwnerStatus;

DELIMITER //
CREATE PROCEDURE UpdateCouponOwnerStatus (
    IN p_coupon_name VARCHAR(255),
    IN p_user_name VARCHAR(255),
    IN p_coupon_status BOOLEAN
)
BEGIN
    DECLARE coupon_exists INT;
    DECLARE user_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 사용 상태를 업데이트하는 동안 오류가 발생했습니다.';
    END;
    
    -- 값 검증
    IF p_coupon_name IS NULL OR p_coupon_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 이름이 유효하지 않습니다.';
    END IF;

    IF p_user_name IS NULL OR p_user_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '사용자 이름이 유효하지 않습니다.';
    END IF;

    IF p_coupon_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 상태가 유효하지 않습니다.';
    END IF;

    START TRANSACTION;
    
    -- 쿠폰 존재 여부 확인
    SELECT COUNT(*) INTO coupon_exists
      FROM coupon
     WHERE coupon_name = p_coupon_name;

    -- 사용자 존재 여부 확인
    SELECT COUNT(*) INTO user_exists
      FROM users
     WHERE user_name = p_user_name;

    -- 쿠폰이 존재하지 않으면 에러 발생
    IF coupon_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰이 존재하지 않습니다.';
    -- 사용자가 존재하지 않으면 에러 발생
    ELSEIF user_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '사용자가 존재하지 않습니다.';
    ELSE
        -- 쿠폰과 사용자가 모두 존재하면 상태 변경
        UPDATE coupon_owner
           SET coupon_status = p_coupon_status
         WHERE coupon_id = (SELECT coupon_id FROM coupon WHERE coupon_name = p_coupon_name)
           AND user_id = (SELECT user_id FROM users WHERE user_name = p_user_name);

        -- 상태가 변경되지 않은 경우 에러 발생
        IF ROW_COUNT() = 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 소유자 기록이 존재하지 않습니다.';
        END IF;
    END IF;
    
    COMMIT;
END //
DELIMITER ;

-- CALL UpdateCouponOwnerStatus('coupon1', 'Alice', FALSE);
