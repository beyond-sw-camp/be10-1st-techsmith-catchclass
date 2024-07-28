-- case 1) 신고가 들어옴 -> 신고 삽입 -> 5번 이상 신고가 된 거면 안보이게 바꿈 
DELIMITER //
CREATE OR REPLACE TRIGGER after_report_insert
	AFTER INSERT
	ON report
	FOR EACH ROW
BEGIN
DECLARE count_report INT;
IF NEW.report_type='class' THEN
	SELECT COUNT(*) INTO count_report
	FROM report
	WHERE class_id = NEW.class_id;
	
	IF count_report >=5 THEN
		UPDATE class
			SET class_status = FALSE
		WHERE class_id = NEW.class_id;
	END IF;
END IF;

IF NEW.report_type='post' THEN
	SELECT COUNT(*) INTO count_report
	FROM report
	WHERE post_id = NEW.post_id;
	
	IF count_report >=5 THEN
		UPDATE post
			SET post_status = FALSE
		WHERE post_id = NEW.post_id;
	END IF;
END IF;

IF NEW.report_type='comment' THEN
	SELECT COUNT(*) INTO count_report
	FROM report
	WHERE comment_id = NEW.comment_id;
	
	IF count_report >=5 THEN
		UPDATE comments
			SET comment_status = FALSE
		WHERE comment_id = NEW.comment_id;
	END IF;
END IF;

IF NEW.report_type='review' THEN
	SELECT COUNT(*) INTO count_report
	FROM report
	WHERE re_id = NEW.re_id;
	
	IF count_report >=5 THEN
		UPDATE review
			SET review_status = FALSE
		WHERE re_id = NEW.re_id;
	END IF;
END IF;

END //

DELIMITER ;


-- case 2) 해당 신고의 상태 바꾸고 -> 해당 신고랑 같은 게시물 신고의 신고 상태도 바꾸고 -> 게시물을 block
DROP PROCEDURE IF EXISTS ReportCheck;
DELIMITER //

CREATE PROCEDURE ReportCheck(IN report_id_para INT)
BEGIN
	DECLARE report_type_var VARCHAR(20);
	START TRANSACTION;
		SELECT report_type INTO report_type_var 
		FROM report
		WHERE report_id = report_id_para;
		
		IF report_type_var = 'class' THEN
			UPDATE report
				SET report_check = 'accept'
			WHERE report_type = 'class' 
				AND class_id = (SELECT class_id 
										FROM report 
									WHERE report_id = report_id_para);
			UPDATE class
				SET class_status = false
			WHERE class_id = (SELECT class_id 
										FROM report 
									WHERE report_id = report_id_para);
		END IF;
		
		IF report_type_var = 'post' THEN
			UPDATE report
				SET report_check = 'accept'
			WHERE report_type = 'post' 
				AND post_id = (SELECT post_id 
										FROM report 
									WHERE report_id = report_id_para);
			UPDATE post
				SET post_status = false
			WHERE post_id = (SELECT post_id 
										FROM report 
									WHERE report_id = report_id_para);
		END IF;
		
		IF report_type_var = 'comment' THEN
			UPDATE report
				SET report_check = 'accept'
			WHERE report_type = 'comment' 
				AND comment_id = (SELECT comment_id 
										FROM report 
									WHERE report_id = report_id_para);
			UPDATE comments
				SET comment_status = false
			WHERE comment_id = (SELECT comment_id 
										FROM report 
									WHERE report_id = report_id_para);
		END IF;

		IF report_type_var = 'review' THEN
			UPDATE report
				SET report_check = 'accept'
			WHERE report_type = 'review' 
				AND re_id = (SELECT re_id 
										FROM report 
									WHERE report_id = report_id_para);
			UPDATE review
				SET re_status = false
			WHERE re_id = (SELECT re_id 
										FROM report 
									WHERE report_id = report_id_para);
		END IF;
		
	COMMIT;
END //
DELIMITER ;

-- CALL ReportCheck(1);


-- case 3) 들어온 신고를 관리자가 decline 
UPDATE report 
	SET report_check = 'reject'
WHERE report_id = 2