-- 신고내역 목록 조회
DROP PROCEDURE IF EXISTS SelectReportAll;
DELIMITER //

CREATE PROCEDURE SelectReportAll()
BEGIN
	SELECT 
		  report_id AS 신고ID
		, report_title AS 신고제목
	 	, report_check AS 진행상태
	FROM report
	ORDER BY report_check, report_time DESC;
END //

DELIMITER ;

-- CALL SelectReportAll();


-- 신고내역 목록 조회 (report_check 별로)
DROP PROCEDURE IF EXISTS SelectReportAllByReportCheck;
DELIMITER //

CREATE PROCEDURE SelectReportAllByReportCheck(IN report_check_para VARCHAR(20))
BEGIN
	SELECT 
		  report_id AS 신고ID
		, report_title AS 신고제목
	 	, report_check AS 진행상태
	FROM report
	WHERE report_check = report_check_para
	ORDER BY report_time DESC;
END //

DELIMITER ;

-- CALL SelectReportAllByReportCheck('accept');
