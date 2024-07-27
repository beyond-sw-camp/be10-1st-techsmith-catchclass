-- 예약자 상세 조회
DELIMITER //

CREATE PROCEDURE GetReservationUserDetail(
    IN reservation_id_param INT
)
BEGIN
    SELECT 
        class.class_name,
        subclass.tutor_name,
        subclass.class_date,
        subclass.start_time,
        subclass.end_time,
        class.location,
        subclass.room_info,
        users.user_name,
        users.telphone
    FROM reservation
    JOIN users ON reservation.user_id = users.user_id
    JOIN subclass ON reservation.round_id = subclass.subclass_id
    JOIN class ON subclass.class_id = class.class_id
    WHERE reservation.reservation_id = reservation_id_param;

END //

DELIMITER ;

-- CALL GetReservationUserDetail(5);