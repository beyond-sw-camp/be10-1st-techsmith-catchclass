DROP TABLE IF EXISTS image CASCADE;
DROP TABLE IF EXISTS bookmark CASCADE;
DROP TABLE IF EXISTS report CASCADE;
DROP TABLE IF EXISTS coupon_owner CASCADE;
DROP TABLE IF EXISTS coupon CASCADE;
DROP TABLE IF EXISTS note CASCADE;
DROP TABLE IF EXISTS inquiry CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS review_hits CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS reservation CASCADE; 
DROP TABLE IF EXISTS subclass CASCADE;
DROP TABLE IF EXISTS class CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS category CASCADE;

-- category
CREATE TABLE IF NOT EXISTS category
(
   ctg_id   INT NOT NULL AUTO_INCREMENT COMMENT '카테고리ID',
   ctg_name VARCHAR(100) NOT NULL COMMENT '카테고리 이름',
   PRIMARY KEY (ctg_id)
) COMMENT = '카테고리';

-- user
CREATE TABLE IF NOT EXISTS users
(
    user_id      INT NOT NULL AUTO_INCREMENT COMMENT '회원ID',
    login_id     VARCHAR(20) NOT NULL UNIQUE KEY COMMENT '로그인ID',
    pwd          VARCHAR(20) NOT NULL COMMENT '비밀번호',
    user_name    VARCHAR(15) NOT NULL COMMENT '이름',
    birthdate    DATE NOT NULL COMMENT '생년월일',
    telphone     VARCHAR(15) NOT NULL COMMENT '전화번호',
    gender       ENUM('F','M') NOT NULL COMMENT '성별',
    authority    ENUM('user', 'tutor', 'admin') NOT NULL COMMENT '회원 권한' DEFAULT 'user',
    PRIMARY KEY (user_id)
) COMMENT = '회원';

-- class
CREATE TABLE IF NOT EXISTS class
(
    class_id      INT NOT NULL AUTO_INCREMENT COMMENT '클래스ID',
    class_name    VARCHAR(100) NOT NULL COMMENT '클래스 이름',
    class_content VARCHAR(500) NOT NULL COMMENT '클래스 내용',
    location      VARCHAR(100) NOT NULL COMMENT '장소',
    price         INT NOT NULL COMMENT '가격',
    class_status  BOOLEAN NOT NULL COMMENT '클래스 상태' DEFAULT TRUE,
    ctg_id        INT NOT NULL COMMENT '카테고리ID',
    user_id       INT NULL COMMENT '회원ID',
    PRIMARY KEY (class_id),
    FOREIGN KEY (ctg_id) REFERENCES category(ctg_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    	ON DELETE SET NULL
) COMMENT = '원데이클래스';

-- subclass
CREATE TABLE IF NOT EXISTS subclass
(
    subclass_id       INT NOT NULL AUTO_INCREMENT COMMENT '회차ID',
    tutor_name        VARCHAR(100) NOT NULL COMMENT '강사 이름',
    subclass_content  VARCHAR(300) NOT NULL COMMENT '상세 내용',
    reservation_limit INT NOT NULL COMMENT '예약 정원',
    reservation_count INT NOT NULL COMMENT '현재 예약 인원',
    room_info         VARCHAR(5) NOT NULL COMMENT '강의실',
    class_date        DATETIME NOT NULL COMMENT '클래스 날짜',
    start_time        DATETIME NOT NULL COMMENT '클래스 시작 시간',
    end_time          DATETIME NOT NULL COMMENT '클래스 종료 시간',
    subclass_status   ENUM('1', '2', '0') NOT NULL DEFAULT 1 COMMENT '회차 상태' ,
    class_id          INT NOT NULL COMMENT '클래스ID',
    PRIMARY KEY (subclass_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id) 
) COMMENT = '회차';

-- reservation
CREATE TABLE IF NOT EXISTS reservation
(
    reservation_id      INT NOT NULL AUTO_INCREMENT COMMENT '예약ID',
    reservation_qty     INT NOT NULL COMMENT '예약인원',
    user_id             INT NULL COMMENT '회원ID',
    round_id            INT NOT NULL COMMENT '회차ID',
    reservation_time    DATETIME NOT NULL COMMENT '예약 확정 시간',
    total_price         INT NOT NULL COMMENT '기존 금액',
    final_price         INT NOT NULL COMMENT '최종 금액',
    reservation_status  BOOLEAN NOT NULL COMMENT '예약 상태' DEFAULT TRUE,  
    attend              BOOLEAN NOT NULL COMMENT '출석 여부' DEFAULT FALSE,
    coupon_owner_id     INT NULL COMMENT '쿠폰 소유자ID',
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
	 	ON DELETE SET NULL
	,FOREIGN KEY (round_id) REFERENCES subclass(subclass_id)
) COMMENT = '예약';

-- review
CREATE TABLE IF NOT EXISTS review
(
    re_id             INT NOT NULL AUTO_INCREMENT COMMENT '후기ID',
    re_title          VARCHAR(100) NOT NULL COMMENT '후기 제목',
    re_content        VARCHAR(300) NOT NULL COMMENT '후기 내용',
    rating            ENUM('1','2','3','4','5') NOT NULL COMMENT '별점',
    reservation_id    INT NOT NULL COMMENT '예약ID',
    re_time           DATETIME NOT NULL COMMENT '후기 작성 시간',
    re_update_time    DATETIME COMMENT '후기 수정 시간',
    re_del_time       DATETIME COMMENT '후기 삭제 시간',
    re_status         BOOLEAN NOT NULL COMMENT '후기 상태' DEFAULT TRUE ,
    PRIMARY KEY (re_id)
) COMMENT = '후기';

-- review_hits
CREATE TABLE IF NOT EXISTS review_hits
(
    user_id    INT NULL COMMENT '회원ID',
    re_id      INT NOT NULL COMMENT '후기ID',
    PRIMARY KEY (user_id, re_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
	 	ON DELETE CASCADE,
    FOREIGN KEY (re_id) REFERENCES review(re_id)
) COMMENT = '후기 좋아요';

-- post
CREATE TABLE IF NOT EXISTS post
(
    post_id        INT NOT NULL AUTO_INCREMENT COMMENT '게시글 ID',
    post_title     VARCHAR(100) NOT NULL COMMENT '게시글 제목',
    post_content   VARCHAR(300) NOT NULL COMMENT '게시글 내용',
    post_time      DATETIME NOT NULL COMMENT '게시글 작성 시간',
    user_id        INT NULL COMMENT '회원ID',
    post_update    DATETIME COMMENT '게시글 수정 시간',
    post_status    BOOLEAN NOT NULL DEFAULT TRUE COMMENT '게시글 상태', -- 게시 ture, 탈퇴 false
    PRIMARY KEY (post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
    	ON DELETE SET NULL
) COMMENT = '커뮤니티 게시글';

-- comment
CREATE TABLE IF NOT EXISTS comments
(
    comment_id           INT NOT NULL AUTO_INCREMENT COMMENT '댓글ID',
    comment_content      VARCHAR(100) NOT NULL COMMENT '댓글 내용',
    comment_time         DATETIME NOT NULL COMMENT '댓글 작성시간',
    post_id              INT NOT NULL COMMENT '게시글 ID',
    user_id              INT NULL COMMENT '회원ID',
    comment_update_time  DATETIME COMMENT '댓글 수정 시간',
    comment_status       BOOLEAN DEFAULT TRUE COMMENT '댓글 상태',
    PRIMARY KEY (comment_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)  
    	ON DELETE SET NULL
) COMMENT = '커뮤니티 댓글';

-- inquiry
CREATE TABLE IF NOT EXISTS inquiry
(
    inq_id       INT NOT NULL AUTO_INCREMENT COMMENT '문의ID',
    inq_title    VARCHAR(100) NOT NULL COMMENT '문의 제목',
    inq_content  VARCHAR(300) NOT NULL COMMENT '문의 내용',
    inq_time     DATETIME NOT NULL COMMENT '문의 등록 시간',
    inq_secret   BOOLEAN NOT NULL COMMENT '비밀글 여부',
    user_id      INT NULL COMMENT '회원ID',
    class_id     INT NOT NULL COMMENT '클래스ID',
    res_content  VARCHAR(300) COMMENT '답변 내용',
    res_time     DATETIME COMMENT '답변 시간',
    inq_status   BOOLEAN NOT NULL COMMENT '문의 상태' DEFAULT TRUE,
    PRIMARY KEY (inq_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
	 	ON DELETE SET NULL,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
) COMMENT = '문의';


-- note
CREATE TABLE IF NOT EXISTS note (
    note_id      INT NOT NULL AUTO_INCREMENT COMMENT '알림ID',
    note_content VARCHAR(100) NOT NULL COMMENT '알림 내용',
    note_ctg     ENUM('class', 'comment', 'inquiry') NOT NULL COMMENT '알림 유형',
    note_date    DATETIME NOT NULL COMMENT '알림 발생 일시',
    user_id      INT NOT NULL COMMENT '회원ID',
    class_id     INT NULL COMMENT '클래스ID',
    comment_id   INT NULL COMMENT '댓글ID',
    inq_id    INT NULL COMMENT '문의ID',
    PRIMARY KEY (note_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
	 	ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES class (class_id),
    FOREIGN KEY (comment_id) REFERENCES comments (comment_id),
    FOREIGN KEY (inq_id) REFERENCES inquiry (inq_id)
) COMMENT = '알림';

-- coupon
CREATE TABLE IF NOT EXISTS coupon
(
    coupon_id             INT NOT NULL AUTO_INCREMENT COMMENT '쿠폰ID',
    coupon_name           VARCHAR(100) NOT NULL COMMENT '쿠폰 이름', 
    coupon_price          INT NOT NULL COMMENT '차감 금액',
    coupon_amount         INT NOT NULL COMMENT '쿠폰 수량',
    coupon_count          INT NOT NULL COMMENT '쿠폰 발급 수량' DEFAULT 0,
    coupon_created        DATETIME NOT NULL COMMENT '쿠폰 생성일',
    coupon_expire_date    DATETIME NOT NULL COMMENT '쿠폰 유효기간',
    class_id              INT NOT NULL COMMENT '클래스ID',
    coupon_status         BOOLEAN NOT NULL COMMENT '쿠폰 승인 상태' DEFAULT FALSE,
    PRIMARY KEY (coupon_id),
    FOREIGN KEY (class_id) REFERENCES class (class_id)
) COMMENT = '쿠폰';

-- coupon_owner
CREATE TABLE IF NOT EXISTS coupon_owner
(
    coupon_owner_id    INT NOT NULL AUTO_INCREMENT COMMENT '쿠폰 소유자ID',
    coupon_status      BOOLEAN NOT NULL COMMENT '쿠폰 상태' DEFAULT FALSE,
    coupon_id          INT NOT NULL COMMENT '쿠폰ID',
    user_id            INT NULL COMMENT '회원ID',
    PRIMARY KEY (coupon_owner_id),
    FOREIGN KEY (coupon_id) REFERENCES coupon (coupon_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    	ON DELETE CASCADE
) COMMENT = '쿠폰 소유자';

-- report
CREATE TABLE IF NOT EXISTS report
(
    report_id         INT NOT NULL AUTO_INCREMENT COMMENT '신고ID',
    report_title      VARCHAR(100) NOT NULL COMMENT '신고 제목',
    report_content    VARCHAR(300) NOT NULL COMMENT '신고 내용',
    report_type       ENUM('post', 'comment', 'review', 'class') NOT NULL COMMENT '신고 유형',
    user_id           INT NULL COMMENT '회원ID',
    re_id             INT COMMENT '후기ID',
    class_id          INT COMMENT '클래스ID',
    comment_id        INT COMMENT '댓글ID',
    post_id           INT COMMENT '게시글 ID',
    report_time       DATETIME NOT NULL COMMENT '신고 일시',
    report_check      ENUM('unchecked', 'reject', 'accept') NOT NULL COMMENT '신고 확인 여부' DEFAULT 'unchecked',
    PRIMARY KEY (report_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
	 	ON DELETE SET NULL,
    FOREIGN KEY (re_id) REFERENCES review (re_id),
    FOREIGN KEY (class_id) REFERENCES class (class_id),
    FOREIGN KEY (comment_id) REFERENCES comments (comment_id),
    FOREIGN KEY (post_id) REFERENCES post (post_id)
) COMMENT = '신고';

-- image
CREATE TABLE IF NOT EXISTS image
(
    img_id     INT NOT NULL AUTO_INCREMENT COMMENT '첨부 파일ID',
    img_url    VARCHAR(100) NOT NULL COMMENT '사진',
    img_ctg    ENUM('certification', 'post', 'review', 'class') NOT NULL COMMENT '게시 유형',
    class_id   INT COMMENT '클래스ID',
    re_id      INT COMMENT '후기ID',
    post_id    INT COMMENT '게시글 ID',
    user_id    INT COMMENT '회원ID',
    cert_check ENUM('unchecked', 'reject', 'accept') NOT NULL COMMENT '관리자 확인 여부' DEFAULT 'unchecked',
    
    PRIMARY KEY (img_id ),
    FOREIGN KEY (re_id) REFERENCES review (re_id),
    FOREIGN KEY (class_id) REFERENCES class (class_id),
    FOREIGN KEY (post_id) REFERENCES post (post_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
    	ON DELETE SET NULL
) COMMENT = '이미지';

-- bookmark
CREATE TABLE IF NOT EXISTS bookmark
(
    user_id     INT NOT NULL COMMENT '회원ID',
    class_id    INT NOT NULL COMMENT '클래스ID',
    PRIMARY KEY (user_id, class_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
	 	ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
) comment = '찜';

