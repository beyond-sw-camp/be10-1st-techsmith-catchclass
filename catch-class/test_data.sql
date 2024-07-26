INSERT INTO category (ctg_name) VALUES
('Art'), ('Music'), ('Cooking'), ('Sports'), ('Technology'), 
('Business'), ('Health'), ('Language'), ('Travel'), ('Photography');

INSERT INTO users (login_id, pwd, user_name, birthdate, telphone, gender, authority) VALUES
('user1', 'pass1', 'Alice', '1990-01-01', '010-1234-5678', 'F', 'user'),
('user2', 'pass2', 'Bob', '1985-05-15', '010-2345-6789', 'M', 'user'),
('user3', 'pass3', 'Charlie', '1992-07-21', '010-3456-7890', 'M', 'tutor'),
('user4', 'pass4', 'David', '1988-11-30', '010-4567-8901', 'M', 'admin'),
('user5', 'pass5', 'Eve', '1995-03-12', '010-5678-9012', 'F', 'user'),
('user6', 'pass6', 'Fay', '1993-06-22', '010-6789-0123', 'F', 'tutor'),
('user7', 'pass7', 'Grace', '1991-09-18', '010-7890-1234', 'F', 'user'),
('user8', 'pass8', 'Heidi', '1989-02-25', '010-8901-2345', 'F', 'user'),
('user9', 'pass9', 'Ivan', '1987-04-14', '010-9012-3456', 'M', 'tutor'),
('user10', 'pass10', 'Judy', '1994-08-10', '010-0123-4567', 'F', 'user');

INSERT INTO class (class_name, class_content, location, price, class_status, ctg_id, user_id) VALUES
('Painting Basics', 'first content', 'Seoul', 50000, true, 1, 3),
('Guitar for Beginners', 'second content', 'Busan', 60000, true, 2, 9),
('Italian Cooking', 'third content', 'Daegu', 70000, true, 3, 6),
('Yoga for Everyone', '4th content', 'Incheon', 40000, true, 4, 9),
('Basic Programming', '5th content', 'Daejeon', 80000, true, 5, 6),
('Entrepreneurship 101', '6th content', 'Ulsan', 90000, true, 6, 3),
('Nutrition and Wellness', '7th content', 'Sejong', 75000, true, 7, 6),
('Conversational English', '8th content', 'Gwangju', 65000, true, 8, 3),
('Travel Photography', '9th content', 'Jeju', 85000, true, 10, 9),
('Digital Marketing', '10th content', 'Seoul', 55000, true, 6, 3);

INSERT INTO subclass (tutor_name, subclass_content, reservation_limit, reservation_count, room_info, class_date, start_time, end_time, class_id) VALUES
('Charlie', 'first', 20, 10, 'A1', '2024-08-01 10:00:00', '2024-08-01 10:00:00', '2024-08-01 12:00:00', 1),
('Ivan', 'second', 15, 12, 'B2', '2024-08-05 14:00:00', '2024-08-05 14:00:00', '2024-08-05 16:00:00', 2),
('Fay', 'third', 25, 20, 'C3', '2024-08-10 09:00:00', '2024-08-10 09:00:00', '2024-08-10 11:00:00', 3),
('Ivan', '4th', 30, 25, 'D4', '2024-08-15 15:00:00', '2024-08-15 15:00:00', '2024-08-15 17:00:00', 4),
('Fay', '5th', 10, 8, 'E5', '2024-08-20 13:00:00', '2024-08-20 13:00:00', '2024-08-20 15:00:00', 5),
('Charlie', '6th', 12, 11, 'F6', '2024-08-25 11:00:00', '2024-08-25 11:00:00', '2024-08-25 13:00:00', 6),
('Fay', '7th', 18, 16, 'G7', '2024-08-30 16:00:00', '2024-08-30 16:00:00', '2024-08-30 18:00:00', 7),
('Charlie', '8th', 22, 20, 'H8', '2024-09-01 10:00:00', '2024-09-01 10:00:00', '2024-09-01 12:00:00', 8),
('Ivan', '9th', 15, 12, 'I9', '2024-09-05 14:00:00', '2024-09-05 14:00:00', '2024-09-05 16:00:00', 9),
('Charlie', '10th', 20, 15, 'J10', '2024-09-10 09:00:00', '2024-09-10 09:00:00', '2024-09-10 11:00:00', 10);

INSERT INTO reservation (reservation_qty, user_id, round_id, reservation_time, total_price, final_price, reservation_status, attend, coupon_owner_id) VALUES
(2, 1, 1, '2024-07-20 10:00:00', 100000, 95000, true, false, 1),
(1, 2, 2, '2024-07-21 14:00:00', 60000, 57000, true, false, 2),
(3, 3, 3, '2024-07-22 09:00:00', 210000, 200000, true, false, 3),
(2, 4, 4, '2024-07-23 15:00:00', 80000, 76000, true, false, 4),
(1, 5, 5, '2024-07-24 13:00:00', 80000, 76000, true, false, 5),
(2, 6, 6, '2024-07-25 11:00:00', 180000, 170000, true, false, 6),
(1, 7, 7, '2024-07-26 16:00:00', 75000, 70000, true, false, 7),
(3, 8, 8, '2024-07-27 10:00:00', 195000, 185000, true, false, 8),
(2, 9, 9, '2024-07-28 14:00:00', 170000, 160000, true, false, 9),
(1, 10, 10, '2024-07-29 09:00:00', 55000, 52000, true, false, 10);

INSERT INTO review (re_title, re_content, rating, reservation_id, re_time, re_update_time, re_del_time) VALUES
('Great Class', 'Learned a lot!', '5', 1, '2024-08-02 10:00:00', NULL, NULL),
('Good Experience', 'Very helpful.', '4', 2, '2024-08-06 14:00:00', NULL, NULL),
('Loved it', 'Fantastic class!', '5', 3, '2024-08-11 09:00:00', NULL, NULL),
('Highly Recommend', 'Worth every penny.', '5', 4, '2024-08-16 15:00:00', NULL, NULL),
('Not bad', 'Could be better.', '3', 5, '2024-08-21 13:00:00', NULL, NULL),
('Amazing', 'Great instructor.', '5', 6, '2024-08-26 11:00:00', NULL, NULL),
('Pretty Good', 'Learned new skills.', '4', 7, '2024-08-31 16:00:00', NULL, NULL),
('Fun Class', 'Had a lot of fun.', '5', 8, '2024-09-02 10:00:00', NULL, NULL),
('Excellent', 'Very informative.', '5', 9, '2024-09-06 14:00:00', NULL, NULL),
('Worth It', 'Would attend again.', '5', 10, '2024-09-11 09:00:00', NULL, NULL);

INSERT INTO review_hits (user_id, re_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), 
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO post (post_title, post_content, post_time, user_id, post_update, post_status) VALUES
('First Post', 'This is the content of the first post.', '2024-07-01 10:00:00', 1, NULL, true),
('Second Post', 'Content for the second post.', '2024-07-02 12:00:00', 2, NULL, true),
('Third Post', 'Here is the third post content.', '2024-07-03 14:00:00', 3, NULL, true),
('Fourth Post', 'Fourth post content here.', '2024-07-04 16:00:00', 4, NULL, true),
('Fifth Post', 'Content for the fifth post.', '2024-07-05 18:00:00', 5, NULL, true),
('Sixth Post', 'Sixth post content.', '2024-07-06 20:00:00', 6, NULL, true),
('Seventh Post', 'Content of the seventh post.', '2024-07-07 22:00:00', 7, NULL, true),
('Eighth Post', 'Eighth post content here.', '2024-07-08 08:00:00', 8, NULL, true),
('Ninth Post', 'Content for the ninth post.', '2024-07-09 10:00:00', 9, NULL, true),
('Tenth Post', 'This is the tenth post content.', '2024-07-10 12:00:00', 10, NULL, true);

INSERT INTO comments (comment_content, comment_time, post_id, user_id, comment_update_time, comment_status) VALUES
('First comment.', '2024-07-01 11:00:00', 1, 1, NULL, true),
('Second comment.', '2024-07-02 13:00:00', 2, 2, NULL, true),
('Third comment.', '2024-07-03 15:00:00', 3, 3, NULL, true),
('Fourth comment.', '2024-07-04 17:00:00', 4, 4, NULL, true),
('Fifth comment.', '2024-07-05 19:00:00', 5, 5, NULL, true),
('Sixth comment.', '2024-07-06 21:00:00', 6, 6, NULL, true),
('Seventh comment.', '2024-07-07 23:00:00', 7, 7, NULL, true),
('Eighth comment.', '2024-07-08 09:00:00', 8, 8, NULL, true),
('Ninth comment.', '2024-07-09 11:00:00', 9, 9, NULL, true),
('Tenth comment.', '2024-07-10 13:00:00', 10, 10, NULL, true);

INSERT INTO inquiry (
    inq_title,
    inq_content,
    inq_time,
    inq_secret,
    user_id,
    class_id,
    res_content,
    res_time,
    inq_status
) VALUES
('Question about class', 'I have a question about the painting class.', '2024-07-01 10:00:00', false, 1, 1, 'Answer to the question.', '2024-07-02 10:00:00', true),
('More details please', 'Can you provide more details on the guitar class?', '2024-07-02 12:00:00', false, 2, 2, 'Details provided.', '2024-07-03 12:00:00', true),
('Dietary restrictions', 'Are there any dietary restrictions for the cooking class?', '2024-07-03 14:00:00', true, 3, 3, 'No restrictions.', '2024-07-04 14:00:00', true),
('Yoga class time', 'Is the yoga class time flexible?', '2024-07-04 16:00:00', false, 4, 4, 'No, it is fixed.', '2024-07-05 16:00:00', true),
('Programming languages', 'Which programming languages will be covered?', '2024-07-05 18:00:00', true, 5, 5, 'Python and JavaScript.', '2024-07-06 18:00:00', true),
('Class prerequisites', 'Are there any prerequisites for the business class?', '2024-07-06 20:00:00', false, 6, 6, 'No prerequisites.', '2024-07-07 20:00:00', true),
('Health class topics', 'What topics will be covered in the health class?', '2024-07-07 22:00:00', true, 7, 7, 'Nutrition and wellness.', '2024-07-08 22:00:00', true),
('English class level', 'What level is the English class aimed at?', '2024-07-08 08:00:00', false, 8, 8, 'Intermediate level.', '2024-07-09 08:00:00', true),
('Photography equipment', 'Do I need to bring my own equipment?', '2024-07-09 10:00:00', true, 9, 9, 'Yes, please bring your own camera.', '2024-07-10 10:00:00', true),
('Marketing tools', 'Will digital marketing tools be provided?', '2024-07-10 12:00:00', false, 10, 10, 'Yes, tools will be provided.', '2024-07-11 12:00:00', true);


INSERT INTO note (note_content, note_ctg, note_date, user_id, class_id, comment_id, inq_id) VALUES
('New class available!', 'class', '2024-07-01 10:00:00', 1, 1, NULL, NULL),
('Your test received a comment.', 'comment', '2024-07-02 12:00:00', 2, NULL, 2, NULL),
('Your comment received a reply.', 'comment', '2024-07-03 14:00:00', 3, NULL, 3, NULL),
('New inquiry on your class.', 'inquiry', '2024-07-04 16:00:00', 4, NULL, NULL, 4),
('Class reminder.', 'class', '2024-07-05 18:00:00', 5, 5, NULL, NULL),
('test updated successfully.', 'comment', '2024-07-06 20:00:00', 6, NULL, 6, NULL),
('Comment deleted.', 'comment', '2024-07-07 22:00:00', 7, NULL, 7, NULL),
('Inquiry liked by user.', 'inquiry', '2024-07-08 08:00:00', 8, NULL, NULL, 8),
('Class booking confirmed.', 'class', '2024-07-09 10:00:00', 9, 9, NULL, NULL),
('Inquiry updated.', 'inquiry', '2024-07-10 12:00:00', 10, NULL, NULL, 10);

INSERT INTO coupon (coupon_name, coupon_price, coupon_amount, coupon_created, coupon_expire_date, class_id, coupon_status) VALUES
('coupon1', 5000, 100, '2024-07-01 10:00:00', '2024-12-31 23:59:59', 1, true),
('coupon2', 10000, 50, '2024-07-02 12:00:00', '2024-12-31 23:59:59', 2, true),
('coupon3', 7000, 70, '2024-07-03 14:00:00', '2024-12-31 23:59:59', 3, true),
('coupon4', 12000, 30, '2024-07-04 16:00:00', '2024-12-31 23:59:59', 4, true),
('coupon5', 8000, 80, '2024-07-05 18:00:00', '2024-12-31 23:59:59', 5, true),
('coupon6', 6000, 60, '2024-07-06 20:00:00', '2024-12-31 23:59:59', 6, true),
('coupon7', 11000, 40, '2024-07-07 22:00:00', '2024-12-31 23:59:59', 7, true),
('coupon8', 9000, 90, '2024-07-08 08:00:00', '2024-12-31 23:59:59', 8, true),
('coupon9', 5000, 50, '2024-07-09 10:00:00', '2024-12-31 23:59:59', 9, true),
('coupon10', 15000, 20, '2024-07-10 12:00:00', '2024-12-31 23:59:59', 10, true);

INSERT INTO coupon_owner (coupon_status, coupon_id, user_id) VALUES
(true, 1, 1),
(true, 2, 2),
(true, 3, 3),
(true, 4, 4),
(true, 5, 5),
(true, 6, 6),
(true, 7, 7),
(true, 8, 8),
(true, 9, 9),
(true, 10, 10);

INSERT INTO report (report_title, report_content, report_type, user_id, re_id, class_id, comment_id, post_id, report_time, report_check) VALUES
('Inappropriate content', 'The content is inappropriate.', 'post', 1, NULL, NULL, NULL, 1, '2024-07-01 10:00:00', 'unchecked'),
('Spam', 'This is a spam post.', 'post', 2, NULL, NULL, NULL, 2, '2024-07-02 12:00:00', 'unchecked'),
('Harassment', 'User is harassing others.', 'comment', 3, NULL, NULL, 3, NULL, '2024-07-03 14:00:00', 'unchecked'),
('Fake review', 'This review is fake.', 'review', 4, 4, NULL, NULL, NULL, '2024-07-04 16:00:00', 'unchecked'),
('Class issue', 'The class was not as described.', 'class', 5, NULL, 5, NULL, NULL, '2024-07-05 18:00:00', 'unchecked'),
('Post contains ads', 'The post contains ads.', 'post', 6, NULL, NULL, NULL, 6, '2024-07-06 20:00:00', 'unchecked'),
('Offensive comment', 'The comment is offensive.', 'comment', 7, NULL, NULL, 7, NULL, '2024-07-07 22:00:00', 'unchecked'),
('Inaccurate review', 'The review is inaccurate.', 'review', 8, 8, NULL, NULL, NULL, '2024-07-08 08:00:00', 'unchecked'),
('Class cancellation', 'The class was cancelled without notice.', 'class', 9, NULL, 9, NULL, NULL, '2024-07-09 10:00:00', 'unchecked'),
('Plagiarism', 'The post is plagiarized.', 'post', 10, NULL, NULL, NULL, 10, '2024-07-10 12:00:00', 'unchecked');

INSERT INTO image (img_url, img_ctg, class_id, re_id, post_id, user_id, cert_check) VALUES
('https://example.com/image1.jpg', 'post', NULL, NULL, 1, 1, 'unchecked'),
('https://example.com/image2.jpg', 'review', NULL, 2, NULL, 2, 'unchecked'),
('https://example.com/image3.jpg', 'class', 3, NULL, NULL, 3, 'unchecked'),
('https://example.com/image4.jpg', 'post', NULL, NULL, 4, 4, 'unchecked'),
('https://example.com/image5.jpg', 'review', NULL, 5, NULL, 5, 'unchecked'),
('https://example.com/image6.jpg', 'class', 6, NULL, NULL, 6, 'unchecked'),
('https://example.com/image7.jpg', 'post', NULL, NULL, 7, 7, 'unchecked'),
('https://example.com/image8.jpg', 'review', NULL, 8, NULL, 8, 'unchecked'),
('https://example.com/image9.jpg', 'class', 9, NULL, NULL, 9, 'unchecked'),
('https://example.com/image10.jpg', 'post', NULL, NULL, 10, 10, 'unchecked');

INSERT INTO bookmark (user_id, class_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);