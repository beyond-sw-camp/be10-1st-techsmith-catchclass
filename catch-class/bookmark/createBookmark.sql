-- 찜하기
DROP PROCEDURE IF EXISTS InsertBookmark;

DELIMITER //
CREATE PROCEDURE InsertBookmark (
    IN p_user_name VARCHAR(255),
    IN p_class_name VARCHAR(255)
)
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_class_id INT;
    DECLARE user_exists INT;
    DECLARE class_exists INT;
    DECLARE bookmark_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred while inserting bookmark.';
    END;
    
    START TRANSACTION;

    -- 사용자 존재 여부 확인
    SELECT COUNT(*), user_id INTO user_exists, v_user_id
      FROM users
     WHERE user_name = p_user_name;
    
    -- 클래스 존재 여부 확인
    SELECT COUNT(*), class_id INTO class_exists, v_class_id
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
        -- 중복 북마크 확인
        SELECT COUNT(*) INTO bookmark_exists
          FROM bookmark
         WHERE user_id = v_user_id
           AND class_id = v_class_id;
        
        -- 이미 북마크가 존재하면 에러 발생
        IF bookmark_exists > 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bookmark already exists.';
        ELSE
            -- 북마크 추가
            INSERT INTO bookmark (user_id, class_id)
            VALUES (v_user_id, v_class_id);
        END IF;
    END IF;

    COMMIT;
END //
DELIMITER ;

-- CALL InsertBookmark('Alice', 'Basic Programming');

