create table s_chart (
	idx		int		not null auto_increment,	-- 고유번호
	songIdx	int	not null,					-- s_song테이블 외래키
	image	text	not null,					-- 앨범 썸네일
	title	varchar(100)	not null,			-- 곡 제목
	artist	varchar(100)	not null,			-- 아티스트
	album	varchar(100)	not null,			-- 앨범 이름
	ranking	int		not null,					-- 순위
	primary key (idx),
	foreign key(songIdx) references s_song(idx)	-- 외래키 설정
	on update cascade
	on delete cascade
);

drop table s_chart;