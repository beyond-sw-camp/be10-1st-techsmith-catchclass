-- 찜하기 취소
DROP PROCEDURE IF EXISTS DeleteBookmark;

DELIMITER //
CREATE PROCEDURE DeleteBookmark (
    IN p_user_name VARCHAR(255),
    IN p_class_name VARCHAR(255)
)
BEGIN
    DECLARE user_exists INT;
    DECLARE class_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred while deleting bookmark.';
    END;

    START TRANSACTION;

    -- 사용자 존재 여부 확인
    SELECT COUNT(*) INTO user_exists
      FROM users
     WHERE user_name = p_user_name;

    -- 클래스 존재 여부 확인
    SELECT COUNT(*) INTO class_exists
      FROM class
     WHERE class_name = p_class_name;

    -- 사용자 또는 클래스가 존재하지 않으면 에러 발생
    IF user_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist.';
    ELSEIF class_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Class does not exist.';
    ELSE
        -- 사용자와 클래스가 모두 존재하면 찜하기 취소
        DELETE FROM bookmark
        WHERE user_id = (SELECT user_id FROM users WHERE user_name = p_user_name)
          AND class_id = (SELECT class_id FROM class WHERE class_name = p_class_name);

        -- 해당 찜하기 기록이 없는 경우 에러 발생
        IF ROW_COUNT() = 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bookmark record does not exist.';
        END IF;
    END IF;

    COMMIT;
END //
DELIMITER ;

-- CALL DeleteBookmark('Alice', 'Basic Programming');