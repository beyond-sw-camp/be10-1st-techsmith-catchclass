-- 예약자 목록 조회
DELIMITER //

CREATE PROCEDURE GetReservationUserList(
    IN reservation_id_param INT
)
BEGIN
    SELECT 
        class.class_name,
        subclass.class_date,
        users.user_name
    FROM reservation
    JOIN users ON reservation.user_id = users.user_id
    JOIN subclass ON reservation.round_id = subclass.subclass_id
    JOIN class ON subclass.class_id = class.class_id
    WHERE reservation.reservation_id = reservation_id_param;

END //

DELIMITER ;

-- CALL GetReservationUserList(5);