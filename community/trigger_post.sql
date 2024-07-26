-- post에 관한 trigger
-- DROP TRIGGER IF EXISTS before_post_insert;
-- DROP TRIGGER IF EXISTS before_post_update;

-- post insert 전에 null, '' 처리
DELIMITER //

CREATE TRIGGER before_post_insert
BEFORE INSERT ON post
FOR EACH ROW
BEGIN
    IF NEW.post_title = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시물 제목에 문자를 입력해주세요.';
    END IF;

    IF NEW.post_content = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시물 내용에 문자를 입력해주세요';
    END IF;

    IF NEW.post_time IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '작성시간이 null일수 없습니다.';
    END IF;
END //

-- post update 전에 null, '' 처리

CREATE TRIGGER before_post_update
BEFORE UPDATE ON post
FOR EACH ROW
BEGIN
    IF NEW.post_title = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시물 제목에 문자를 입력하세요.';
    END IF;

    IF NEW.post_content = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시물 내용에 문자를 입력하세요.';
    END IF;

    IF NEW.post_time IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '작성시간이 null일수 없습니다.';
    END IF;
END //

DELIMITER ;
