DROP PROCEDURE IF EXISTS InsertCouponOwner;
DROP TRIGGER IF EXISTS CheckCouponAmount;

DELIMITER //
CREATE PROCEDURE InsertCouponOwner (
    IN p_coupon_name VARCHAR(255),
    IN p_user_name VARCHAR(255)
)
BEGIN
    DECLARE v_coupon_id INT;
    DECLARE v_user_id INT;
    DECLARE coupon_exists INT;
    DECLARE user_exists INT;
    DECLARE v_coupon_status BOOLEAN;
    DECLARE coupon_owner_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰을 발급하는 동안 오류가 발생했습니다.';
    END;

    -- 값 검증
    IF p_coupon_name IS NULL OR p_coupon_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰 이름이 유효하지 않습니다.';
    END IF;

    IF p_user_name IS NULL OR p_user_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '사용자 이름이 유효하지 않습니다.';
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
        -- 쿠폰과 사용자 ID를 가져옵니다.
        SELECT coupon_id, coupon_status INTO v_coupon_id, v_coupon_status
          FROM coupon
         WHERE coupon_name = p_coupon_name;

        SELECT user_id INTO v_user_id
          FROM users
         WHERE user_name = p_user_name;
         
        -- 동일한 쿠폰이 동일한 사용자에게 발급되었는지 확인
        SELECT COUNT(*) INTO coupon_owner_exists
          FROM coupon_owner
         WHERE coupon_id = v_coupon_id
           AND user_id = v_user_id;
           
        -- 동일한 쿠폰이 동일한 사용자에게 이미 발급된 경우 오류 발생
        IF coupon_owner_exists > 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '동일한 쿠폰이 이미 사용자에게 발급되었습니다.';
        ELSE
            -- 쿠폰이 미승인 상태이면 발급 불가
            IF v_coupon_status = FALSE THEN
                ROLLBACK;
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰이 승인되지 않았습니다.';
            ELSE
                -- 쿠폰 발급
                INSERT INTO coupon_owner (coupon_status, coupon_id, user_id)
                VALUES (TRUE, v_coupon_id, v_user_id);
                
                -- 쿠폰 발급 수량 업데이트
                UPDATE coupon
                   SET coupon_count = coupon_count + 1
                 WHERE coupon_id = v_coupon_id;
            END IF;
        END IF;
    END IF;
    
    COMMIT;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER CheckCouponAmount
   BEFORE INSERT 
   ON coupon_owner
   FOR EACH ROW
BEGIN
   DECLARE available_amount INT;
   DECLARE used_count INT;
    
   -- 현재 쿠폰의 총량
   SELECT coupon_amount INTO available_amount
     FROM coupon
    WHERE coupon_id = NEW.coupon_id;
    
   -- 쿠폰의 발급 횟수
   SELECT coupon_count INTO used_count
     FROM coupon
    WHERE coupon_id = NEW.coupon_id;

   -- 쿠폰의 총량이 발급 횟수보다 작으면 오류 발생
   IF available_amount <= used_count THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '쿠폰을 발급할 수 없습니다.: 쿠폰 총량 초과됨';
   END IF;
END //
DELIMITER ;

-- CALL InsertCouponOwner('coupon1', 'Alice');
