DROP PROCEDURE IF EXISTS InsertClass;
DELIMITER //

CREATE PROCEDURE InsertClass(
	IN c_class_name VARCHAR(100),
	IN c_class_content VARCHAR(500),
	IN l_location VARCHAR(100),
	IN p_price INT,
	IN c_class_status TINYINT(1),
	IN c_ctg_id INT, 
	IN u_user_id INT
)
BEGIN
		INSERT INTO class(
		class_name,
		class_content,
		location,
		price,
		class_status,
		ctg_id,
		user_id
		)
		VALUES(
		c_class_name,
		c_class_content,
		l_location,
		p_price,
		c_class_status,
		c_ctg_id,
		u_user_id
	);
END //

DELIMITER ;

-- CALL InsertClass('축구', '공놀이', '상암', '5000', 1, 2, 3);

-- SELECT * FROM class;
