show tables;

create table s_song (
	idx		int		not null auto_increment,	-- 고유번호
	image	text			not null,			-- 앨범 썸네일
	title	varchar(100)	not null,			-- 곡 제목
	artist	varchar(100)	not null,			-- 아티스트
	album	varchar(100)	not null,			-- 앨범 이름
	music		varchar(1000) default null,		-- 음원 파일
	releaseDate	datetime,						-- 발매일
	genre		varchar(100),					-- 장르
	lyrics		text,							-- 가사
	primary key (idx)
);

drop table s_playList;


CREATE TABLE s_playList (
    idx INT NOT NULL AUTO_INCREMENT,      -- 고유번호
    memberIdx INT NOT NULL,               -- 회원 고유번호
    songIdx INT NOT NULL,                 -- 곡 고유번호
    name VARCHAR(100) NOT NULL,           -- 플리 이름
    content TEXT,                         -- s_song title
    PRIMARY KEY (idx),
    FOREIGN KEY (memberIdx) REFERENCES s_member(idx)   -- 외래키 설정
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

