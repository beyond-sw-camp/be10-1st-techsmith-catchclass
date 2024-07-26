-- 게시글 조회 / 기본 (게시글 리스트, 화면에 보이는 댓글 갯수)
SELECT 
	    p.post_title AS 게시글_제목,
	    COALESCE(concat(p.post_update,'(수정)'), p.post_time) AS 게시글_작성시간,
	    COALESCE(u.user_name, '알수없음') AS 작성자_이름,
	    COUNT(c.comment_id) AS 댓글_수,
	    i.img_url AS 이미지
	FROM post p
LEFT JOIN users u ON u.user_id = p.user_id
LEFT JOIN comments c ON c.post_id = p.post_id
LEFT JOIN image i ON i.post_id = p.post_id
GROUP BY p.post_id;

-- 확인 :
-- SELECT * FROM post;

-- 게시글 조회 / 최신순 (게시글 리스트, 화면에 보이는 댓글 갯수)
SELECT 
    p.post_title AS 게시글_제목,
    COALESCE(CONCAT(p.post_update, '(수정)'), p.post_time) AS 게시글_작성시간,
    COALESCE(u.user_name, '알수없음') AS 작성자_이름,
    COUNT(c.comment_id) AS 댓글_수,
    i.img_url AS 이미지
FROM post p
LEFT JOIN users u ON u.user_id = p.user_id
LEFT JOIN comments c ON c.post_id = p.post_id
LEFT JOIN image i ON i.post_id = p.post_id
GROUP BY p.post_id, p.post_update, p.post_time, u.user_name, i.img_url
ORDER BY COALESCE(p.post_update, p.post_time) DESC;

-- 확인 :
-- SELECT * FROM post

-- 게시글 조회 / 댓글 많은 순서  (게시글 리스트, 화면에 보이는 댓글 갯수)

SELECT 
    p.post_title AS 게시글_제목,
    COALESCE(CONCAT(p.post_update, '(수정)'), p.post_time) AS 게시글_작성시간,
    COALESCE(u.user_name, '알수없음') AS 작성자_이름,
    COUNT(c.comment_id) AS 댓글_수,
    i.img_url AS 이미지
FROM post p
LEFT JOIN users u ON u.user_id = p.user_id
LEFT JOIN comments c ON c.post_id = p.post_id
LEFT JOIN image i ON i.post_id = p.post_id
GROUP BY p.post_id, p.post_update, p.post_time, u.user_name, i.img_url
ORDER BY 댓글_수 DESC;

-- 확인 :
-- SELECT * FROM post;

-- post_update가 있으면 '수정'합쳐서 출력
-- 작성자가 탈퇴를 했을 user_name이 null이 되어  '알수없음'으로 출력