-- 쿠폰 목록 조회
-- (적용 클래스, 쿠폰 이름, 할인 가격, 수량, 남은 수량, 만료기간)
DROP PROCEDURE IF EXISTS GetCouponList;

DELIMITER //
CREATE PROCEDURE GetCouponList ()
BEGIN
    SELECT
           a.class_name AS '적용 클래스',
           b.coupon_name AS '쿠폰 이름',
           b.coupon_price AS '할인 가격',
           b.coupon_amount AS '수량',
           (b.coupon_amount - b.coupon_count) AS '남은 수량',
           b.coupon_expire_date AS '만료기간'
      FROM class a
      JOIN coupon b USING (class_id)
     ORDER BY a.class_name, b.coupon_created, b.coupon_expire_date;
END //
DELIMITER ;

-- CALL GetCouponList();