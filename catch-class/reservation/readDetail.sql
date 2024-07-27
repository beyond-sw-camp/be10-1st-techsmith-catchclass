-- 예약 상세 조회
DELIMITER //

CREATE PROCEDURE GetUserReservationsByUserId(
	IN user_id_param INT,
	IN reservation_id_param INT
)
BEGIN
    SELECT
        users.user_name AS '회원명',
        class.class_name AS '수업명',
        reservation.reservation_time AS '예약시간',
        reservation.reservation_qty AS '예약 인원',
        reservation.final_price AS '결제 금액',
        class.location AS '수업주소',
        subclass.room_info AS '강의실',
        subclass.class_date AS '수업 날짜',
        subclass.start_time AS '수업 시작 시간',
        subclass.end_time AS '수업 종료 시간',
        subclass.reservation_count AS '현재 인원',
        subclass.reservation_limit AS '정원'
    FROM
        reservation
        JOIN subclass ON reservation.round_id = subclass.subclass_id
        JOIN class ON subclass.class_id = class.class_id
        JOIN users ON reservation.user_id = users.user_id
    WHERE users.user_id = user_id_param
    AND reservation.reservation_id = reservation_id_param;
END//

DELIMITER ;

-- CALL GetUserReservationsByUserId(1, 1);