DROP PROCEDURE IF EXISTS InsertSubclass;
DELIMITER //

CREATE PROCEDURE InsertSubclass(
	IN t_tutor_name VARCHAR(100),
	IN sc_subclass_content VARCHAR(300),
	IN r_reservation_limit INT,
	IN	r_reservation_count INT,
	IN	r_room_info VARCHAR(20),
	IN	c_class_date DATETIME,
	IN	s_start_time DATETIME,
	IN	e_end_time DATETIME,
	IN	s_subclass_status ENUM('1', '2', '0'),
	IN	c_class_id INT
		)
BEGIN
		INSERT INTO subclass(
		    tutor_name,
		    subclass_content,
		    reservation_limit,
		    reservation_count,
		    room_info,
		    class_date,
		    start_time,
		    end_time,
		    subclass_status,
		    class_id
	                )
		VALUES
		(
		    t_tutor_name,
		    sc_subclass_content,
		    r_reservation_limit,
		    r_reservation_count,
		    r_room_info,
		    c_class_date,
		    s_start_time,
		    e_end_time,
		    s_subclass_status,
 		    c_class_id 
 );
 END //

DELIMITER ;		
 		
-- CALL InsertSubclass('Ivan', 'very hard', 15, 12,'B2',
--		 '2024-08-05 14:00:00',
--		 '2024-08-05 14:00:00',
--		 '2024-08-05 16:00:00',
--		 1,
--		 14);

-- select * from subclass;