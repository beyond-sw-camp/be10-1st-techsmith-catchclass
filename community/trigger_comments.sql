-- comments에 관한 trigger
-- DROP TRIGGER IF EXISTS before_comment_insert;
-- DROP TRIGGER IF EXISTS before_comment_update;

-- ''을 comment에 insert할 때 예외처리
DELIMITER //

CREATE TRIGGER before_comment_insert
BEFORE INSERT ON comments
FOR EACH ROW
BEGIN
    IF NEW.comment_content = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '댓글에 문자를 입력해 주세요.';
    END IF;

    IF NEW.comment_time IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '작성 시간이 null일수 없습니다.';
    END IF;
END //

-- ''을 comment에 update할 때 예외처

CREATE TRIGGER before_comment_update
BEFORE UPDATE ON comments
FOR EACH ROW
BEGIN
    IF NEW.comment_content = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '댓글에 문자를 입력해 주세요.';
    END IF;

    IF NEW.comment_time IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '작성 시간이 null일수 없습니다.';
    END IF;
END //

DELIMITER ;
