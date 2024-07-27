-- 찜한 목록 조회
DROP PROCEDURE IF EXISTS GetBookmarkList;

DELIMITER //
CREATE PROCEDURE GetBookmarkList (
    IN p_user_name VARCHAR(255)
)
BEGIN
    DECLARE user_exists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred while fetching bookmarks.';
    END;

    -- 사용자 존재 여부 확인
    SELECT COUNT(*) INTO user_exists
      FROM users
     WHERE user_name = p_user_name;

    -- 사용자가 존재하지 않으면 에러 발생
    IF user_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist.';
    ELSE
        -- 사용자가 존재하면 찜한 목록 조회
        SELECT 
               b.class_name
          FROM bookmark a
          JOIN class b USING (class_id)
         WHERE a.user_id = (SELECT user_id FROM users WHERE user_name = p_user_name);
    END IF;
END //
DELIMITER ;

-- CALL GetBookmarkList('Alice');