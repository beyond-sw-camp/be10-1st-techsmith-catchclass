DELIMITER //

CREATE PROCEDURE DeleteReview(
    IN d_re_id bool
)
BEGIN
   UPDATE review
   SET re_status = FALSE,   -- 개시 상태 TRUE -> FALSE
       re_del_time = NOW()
   WHERE re_id = d_re_id;
END //

DELIMITER ;

-- CALL DeleteReview(13);