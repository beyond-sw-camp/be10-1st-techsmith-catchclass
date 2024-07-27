SELECT 
    c.class_name AS 클래스,
    c.class_content AS 설명,
    u.user_name AS 사업자,
    c.price AS 가격,
    sc.reservation_limit AS 예약정원,
    sc.reservation_count AS 예약현황,
    sc.start_time AS 시작시간,
    CONCAT(c.location, '_', sc.room_info) AS 장소
FROM class c 
JOIN users u ON c.user_id = u.user_id
JOIN subclass sc ON c.class_id = sc.class_id;