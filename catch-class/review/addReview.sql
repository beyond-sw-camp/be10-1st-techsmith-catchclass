DELIMITER //

CREATE PROCEDURE InsertReview(
    IN p_re_title VARCHAR(100),
    IN p_re_content VARCHAR(300),
    IN p_rating ENUM('1', '2', '3', '4', '5'),
    IN p_reservation_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- 오류가 발생하면 롤백
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '예약이 유효하지 않거나, 삽입 중 오류가 발생했습니다.';
    END;

    -- 트랜잭션 시작
    START TRANSACTION;
    
    -- reservation id 가 유효하고, attend 가 true 인지 검증
    IF EXISTS (SELECT 1 FROM reservation WHERE reservation_id = p_reservation_id AND attend = TRUE) THEN
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
        -- 트랜잭션 커밋
        COMMIT;reservation
    ELSE
        -- 유효하지 않은 reservation_id 경우
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'reservation_id가 참조 테이블에 유효하지 않거나, attend가 TRUE가 아닙니다.';
    END IF;
END //

DELIMITER ;

-- attend = 0 입력 x, reservation_id가 유효하지 않을때 입력 x

CALL InsertReview('wpw', 'sldkmf', '5', 1);
