-- 게시글 작성 (작성 시간에 현재 시간을 입력)
INSERT INTO post (
    post_title,
    post_content,
    post_time,
    user_id,
    post_update
) VALUES (
    '수업 좋아요',
    '재밌게 채험하고 왔어요. 여러분들도 해 보세요~',
    LOCALTIMESTAMP(),
    1,
    NULL
);


-- 확인 :
-- SELECT * FROM users;