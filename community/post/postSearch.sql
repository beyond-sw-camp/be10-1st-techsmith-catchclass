-- 게시물 검색
-- DROP PROCEDURE if EXISTS SearchCommunity;
DELIMITER //

CREATE PROCEDURE SearchCommunity(
    IN search_content VARCHAR(50)
)

BEGIN

    -- 검색 문자열이 공백일 경우 오류 발생
    IF TRIM(search_content) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '검색 문자열은 공백일 수 없습니다';
    END IF;

    -- 검색 결과 반환
    SELECT 
        p.post_title AS 게시글_제목,
        COALESCE(p.post_update, p.post_time) AS 게시글_작성시간,
        COALESCE(u.user_name, '알수없음') AS 작성자_이름,
        COUNT(c.comment_id) AS 댓글_수,
        i.img_url AS 이미지
    FROM post p 
    LEFT JOIN users u ON u.user_id = p.user_id
    LEFT JOIN comments c ON c.post_id = p.post_id
    LEFT JOIN image i ON i.post_id = p.post_id
    WHERE p.post_content LIKE CONCAT('%', search_content, '%')
       OR p.post_title LIKE CONCAT('%', search_content, '%')
    GROUP BY p.post_id, p.post_title, p.post_time, u.user_name, p.post_update, i.img_url;

END //

DELIMITER ;


-- 테스트
CALL SearchCommunity('f');

