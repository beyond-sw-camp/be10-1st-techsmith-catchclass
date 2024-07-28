-- 댓글 입력
INSERT INTO 
	comments(
	  comment_content
	, comment_time
	, post_id
	, user_id
) VALUES( 
	 'hihi'
	, NOW()
	, 1
	, 1
);
-- 확인
-- SELECT * FROM comments;