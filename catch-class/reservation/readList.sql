-- 예약 조회
SELECT
	users.user_name
	, class.class_name
	FROM reservation reservation
	JOIN users users ON reservation.user_id = users.user_id
	JOIN subclass subclass ON reservation.round_id = subclass.subclass_id
	JOIN class class ON subclass.class_id = class.class_id
	ORDER BY reservation.user_id;
	
-- 예약 조회 프로시저
DELIMITER //

CREATE PROCEDURE GetUserClassList(IN user_id_param INT)
BEGIN
    SELECT
        users.user_name AS user_name,
        class.class_name AS class_name
    FROM
        reservation
        JOIN users ON reservation.user_id = users.user_id
        JOIN subclass ON reservation.round_id = subclass.subclass_id
        JOIN class ON subclass.class_id = class.class_id
    WHERE users.user_id = user_id_param
    ORDER BY reservation.user_id;
END//

DELIMITER ;

-- CALL GetUserClassList(3);