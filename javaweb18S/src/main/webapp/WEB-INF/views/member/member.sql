show tables;

create table s_member (
	idx 		int 			not null 	auto_increment,		-- 고유번호
	mid 		varchar(20) 	not null,						-- 아이디(중복x)
	pwd 		varchar(100) 	not null,						-- 비밀번호(암호화)
	nickName	varchar(20) 	not null,						-- 닉네임(중복x/수정o)
	name 		varchar(20) 	not null,						-- 성명
	tel 		varchar(15)		not null,						-- 전화번호(010-1234-5678)
	email		varchar(50)		not null,						-- 이메일(아이디/비밀번호 찾기) *폼체크 필수
	image		varchar(100)	default 	'noimage.jpg',		-- 사진
	userDel		char(2)			default		'NO',				-- 탈퇴신청여부 OK:탈퇴신청중
	level		int				default		1,					-- 등급 0관리자 1회원
	membership	int				default		0,					-- 멤버십 0결제x 1결제o
	startDate	datetime		default		now(),				-- 최초 가입일
	lastDate	datetime		default		now(),				-- 최종 접속일
	primary key (idx),											
	unique key (mid, nickName)
);


desc member2;

select * from member2;

delete from member2 where idx='17';

update member2 set level='0' where idx='1';

alter table member2 add salt char(8);

drop table member2;

-- 실시간 채팅 테이블 (이미지 추가)
create table memberChat (
	idx	int not null auto_increment primary key,
	nickName varchar(20) not null,
	chat varchar(100) not null
);

desc memberChat;

select * from memberChat order by idx desc limit 50;

select chat.* from (select * from memberChat order by idx desc limit 50) chat order by idx asc;













