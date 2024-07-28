DELIMITER //

CREATE PROCEDURE InsertReview(
    IN p_re_title VARCHAR(100),
    IN p_re_content VARCHAR(300),
    IN p_rating ENUM('1', '2', '3', '4', '5'),
    IN p_reservation_id INT
)
BEGIN
    DECLARE v_attend BOOLEAN;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '예약이 유효하지 않거나, 출석 여부가 확인되지 않았습니다.';
    END;

    -- reservation id 가 유효한지 및 attend 필드가 TRUE인지 검증
    SELECT attend INTO v_attend
    FROM reservation
    WHERE reservation_id = p_reservation_id;

    IF v_attend = TRUE THEN
        INSERT INTO review (
            re_title,
            re_content,
            rating,
            reservation_id,
            re_time,
            re_update_time,
            re_del_time,
            re_status
        )
        VALUES (
            p_re_title,
            p_re_content,
            p_rating,  
            p_reservation_id,
            NOW(),   -- 현재 시간으로 설정
            NULL,    -- 후기 수정 시간은 NULL
            NULL,    -- 후기 삭제 시간은 NULL
            TRUE     -- 후기 상태는 TRUE
        );
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '예약이 유효하지 않거나, 출석 여부가 확인되지 않았습니다.';
    END IF;
END //

DELIMITER ;


-- CALL InsertReview('Great Experience', 'The class was very informative and engaging.', '5', 2);