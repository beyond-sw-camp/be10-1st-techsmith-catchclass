-- 게시글에 댓글이 달리면 알림 생성
DROP TRIGGER IF EXISTS AfterCommentInsert;

DELIMITER //
CREATE TRIGGER AfterCommentInsert
   AFTER INSERT ON comments
   FOR EACH ROW
BEGIN
    DECLARE post_user_id INT;

    -- 댓글이 달린 게시글의 작성자 ID를 가져옵니다
    SELECT user_id INTO post_user_id
      FROM post
     WHERE post_id = NEW.post_id;

    -- 알림을 생성합니다
    INSERT INTO note (note_content, note_ctg, note_date, user_id, comment_id, class_id)
    VALUES (
        CONCAT('게시글 ID ', NEW.post_id, '에 댓글이 달렸습니다. ', '댓글 ID ',  NEW.comment_id, ' 보러가기'),
        'comment', 
        NOW(),
        post_user_id,
        NEW.comment_id,
        NULL  
    );
END //
DELIMITER ;

-- 문의에 답변이 달리면 알림 생성
DROP TRIGGER IF EXISTS AfterInquiryUpdate;

DELIMITER //
CREATE TRIGGER AfterInquiryUpdate
   AFTER UPDATE
   ON inquiry
   FOR EACH ROW
BEGIN
   DECLARE inquiry_user_id INT;
    
   -- 문의의 작성자 ID를 가져옵니다
   SELECT user_id INTO inquiry_user_id
     FROM inquiry
    WHERE inq_id = NEW.inq_id;

   -- res_content가 NULL에서 업데이트된 경우 알림을 생성합니다
   IF OLD.res_content IS NULL AND NEW.res_content IS NOT NULL THEN
       INSERT INTO note (note_content, note_ctg, note_date, user_id, class_id, inq_id)
       VALUES (
           CONCAT('문의 ID', NEW.inq_id, '에 답변이 달렸습니다.'),
           'inquiry',
           NOW(),
           inquiry_user_id,
           NEW.class_id,
           NEW.inq_id
       );
   END IF;
END //
DELIMITER ;
