-- 신고내역 상세 조회
DROP PROCEDURE IF EXISTS SelectReportDetail;
DELIMITER //

CREATE PROCEDURE SelectReportDetail(IN report_id_para VARCHAR(20))
BEGIN
	SELECT 
		  report_id AS 신고ID
		, report_title AS 신고제목
		, report_content AS 신고내용
	 	, report_type AS 신고유형
	   , user_id AS 신고회원ID
	 	, re_id AS 후기ID
	 	, class_id AS 클래스ID
	 	, comment_id AS 댓글ID
	 	, post_id AS 게시글ID
	 	, report_time AS 신고일시
	 	, report_check AS 진행상태
	FROM report
	WHERE report_id = report_id_para;
END //

DELIMITER ;

CALL SelectReportDetail(3);
