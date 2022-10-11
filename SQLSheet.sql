--학급 테이블
create table hw_class(
grade number(1) not null, 
class number(1) not null, 
constraint class_pk primary key(grade,class)
)
select * from hw_class

insert into hw_class values(1,1);
insert into hw_class values(2,1);
insert into hw_class values(3,1);
insert into hw_class values(4,1);
insert into hw_class values(5,1);
insert into hw_class values(6,1);
insert into hw_class values(6,2);

--유저 테이블
drop table hw_user
create table hw_user(
id varchar2(20) primary key not null, 
pw varchar2(20) not null, 
name varchar2(10) not null, 
tel varchar2(20) not null,
parent varchar2(20),
grade number(1) not null, 
class number(1) not null, 
num number(2) not null,
position varchar2(20) default '학생',
confirmed number(1) default 0
)
select * from hw_user where grade = 6 and class = 2 and position = '학생'
insert into hw_user values('fist','1234','김주먹','010-1111-2222','010-1111-3333','1','1','1','학생','0');
insert into hw_user values('hong','1234','홍길동','010-1111-2222','010-2222-3333','6','2','3','학생','0');
insert into hw_user values('kimg','1234','김길동','010-1111-2222','010-2222-3333','6','2','4','학생','0');
insert into hw_user values('teac','1234','홍사범','010-2222-4444',null,'6','2','3','선생','1');
select * from hw_user where id = 'hong'
select * from hw_user
--숙제 테이블
drop table hw_homework
create table hw_homework(
homeworkId number(10) primary key not null,
grade number(1) not null, 
class number(1) not null, 
title varchar2(100) not null,
subject varchar2(10),
stDate date default sysdate,
enDate date not null
)
select * from hw_homework

insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),6,2,'곱셈나눗셈','math','2022-04-06','2022-04-07');
insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),6,2,'덧셈뺄셈','math','2022-04-06','2022-04-07');
insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),1,1,'덧셈','math','2022-04-07','2022-04-20');
insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),3,1,'지구','science','2022-04-07','2022-04-10');
insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),3,1,'달','science','2022-04-07','2022-04-8');
insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),2,1,'독서록','korean','2022-04-07','2022-04-11');
select homeworkId, grade, class, title, subject, stDate, enDate, ceil(enDate - sysdate+1)as timeout from hw_homework order by (case when timeout > 0 then 1 end), timeout

--숙제의 문제 테이블
drop table hw_quest
create table hw_quest(
homeworkId number(10) not null,
questNum number(3) not null,
kind varchar2(10) not null,
quest varchar2(1000) not null,
answer varchar2(20),
first varchar2(100),
second varchar2(100),
third varchar2(100),
fourth varchar2(100),
fifth varchar2(100),
constraint quest_pk primary key(homeworkId,questNum)
)
select * from hw_quest;
--ㄷ한자로 기호 입력하기.
insert into hw_quest(homeworkId,questNum,kind,quest,answer) values(0,1,'short','(18×40)÷12 = ','60');
insert into hw_quest(homeworkId,questNum,kind,quest,answer) values(0,2,'short','28÷(7×2) = ','2');
insert into hw_quest(homeworkId,questNum,kind,quest,answer) values(0,3,'short','24÷(2×2) = ','6');
insert into hw_quest(homeworkId,questNum,kind,quest,answer) values(0,4,'short','(18÷6)×19 = ','38');
insert into hw_quest(homeworkId,questNum,kind,quest,answer) values(0,5,'short','(18×16)÷9 = ','32');
insert into hw_quest(homeworkId,questNum,kind,quest,answer,first,second,third,fourth) values(0,6,'four','계산이 바르지 않은 것을 모두 고르시오.','ㄱㄷ','24÷7＝3ㆍㆍㆍ2','34÷7＝4ㆍㆍㆍ6','40÷7＝5ㆍㆍㆍ2','29÷4＝3ㆍㆍㆍ1');
insert into hw_quest(homeworkId,questNum,kind,quest,answer,first,second,third,fourth) values(0,7,'four','계산이 바르지 않은 것을 모두 고르시오.','ㄷㄹ','80÷9＝7ㆍㆍㆍ8','54÷8＝6ㆍㆍㆍ6','70÷6＝11ㆍㆍㆍ2','57÷9＝6ㆍㆍㆍ5');
insert into hw_quest(homeworkId,questNum,kind,quest,answer,first,second,third,fourth,fifth) values(0,8,'five','다음 □안에 들어갈 수중에서 가장 큰 수를 고르시오.','5','24÷□＝8','72÷□＝9','48÷□＝8','35÷□＝5','18÷□＝2');
insert into hw_quest(homeworkId,questNum,kind,quest,answer,first,second,third,fourth,fifth) values(0,9,'five','계산결과가 가장 큰 것을 고르시오.','3','(18×5)÷9','(20÷4)×2','(24×6)÷12','(6×10)÷12','(22×5)÷11');
insert into hw_quest(homeworkId,questNum,kind,quest) values(0,10,'long','평행사변형의 조건을 서술하시오.');
select max(homeworkId) from hw_homework
insert into hw_quest values('5',1,'책한권 읽고 독서록 쓰기',null);
select * from hw_homework h inner join hw_quest q on h.homeworkId = q.homeworkId where h.homeworkId = '0'
select * from hw_quest where homeworkId = 0 order by questNum

--제출물 테이블
drop table hw_submit
create table hw_submit(
homeworkId number(10) not null,
id varchar2(20) not null,
grade number(1) not null, 
class number(1) not null, 
name varchar2(10) not null,
num number(1) not null,
explan varchar2(1000),
subDate date default sysdate,
confirm varchar2(3) default 'X',
constraint submit_pk primary key(homeworkId,id)
)
select * from hw_submit 

select * from hw_submit where homeworkId = 0
delete from hw_submit where id = 'teac'
--제출물의 문제 테이블
drop table hw_submitQ
create table hw_submitQ(
homeworkId number(10) not null,
questNum number(3) not null,
answer long not null,
id varchar2(20) not null,
explan varchar2(1000),
correct number(1),
constraint submitQ_pk primary key(homeworkId,id,questNum)
)
select * from hw_submitQ where homeworkId = 0 and id = 'hong' order by questNum
select * from hw_submitQ
update hw_submitQ set correct = 1 where homeworkId = 0 and id = 'hong' and questNum = 2


select u.num, u.name, s.subDate, s.confirm from hw_user u left join hw_submit s on s.id = u.id where u.grade = 6 and u.class = 2 and u.position = '학생'

select u.num, u.name, s.subDate, nvl(s.confirm, '미제출') as confirm, s.homeworkId, u.id 
from hw_user u left join hw_submit s on s.id = u.id
union select u.num, u.name, s.subDate, nvl(s.confirm, '미제출') as confirm, s.homeworkId, u.id 
from hw_user u right join hw_submit s on s.id = u.id where homeworkId = 1 order by num
select u.id, u.name, h.homeworkId, nvl(s.confirm, '미제출') as confirm from hw_user u,hw_homework h full outer join hw_submit s on h.homeworkId = s.homeworkId where u.position = '학생' order by u.num


select * from hw_submit where homeworkId = 0 and id = 'hong'
select homeworkId, grade, class, title, subject,stDate, enDate, ceil(enDate - sysdate+1) as timeout from hw_homework where homeworkId = 0
select * from hw_submit where homeworkId = 0 
CASE WHEN GENDER = '001' THEN '여' ELSE '남' END AS 성별

select a.id, a.num, a.name, case when a.subDate = b.subDate then a.subDate else null end as subDate, case when a.confirm = b.confirm then 'O' else 'X' end as confirm, a.homeworkId from
(select u.grade, u.class, u.id, u.num, u.name, s.subDate, h.homeworkId, s.confirm, u.position from hw_homework h, hw_user u left join hw_submit s on s.id = u.id ) a inner join
(select u.grade, u.class, u.id, u.num, u.name, s.subDate, h.homeworkId, s.confirm, u.position from hw_user u, hw_homework h left join hw_submit s on s.homeworkId = h.homeworkId) b
on a.id = b.id and a.homeworkId = b.homeworkId and a.position = '학생' where a.homeworkId = 0 order by a.num;

select a.id, a.grade, a.class, a.num, a.name, case when a.subDate = b.subDate then a.subDate else null end as subDate, case when a.confirm = b.confirm then 'O' else 'X' end as confirm, a.homeworkId from
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_homework h, hw_user u left join hw_submit s on s.id = u.id) a inner join
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u, hw_homework h left join hw_submit s on s.homeworkId = h.homeworkId) b
on a.id = b.id and a.homeworkId = b.homeworkId where a.homeworkId = 1 and a.grade = 6 and a.class = 2 and a.position = '학생' order by a.num ;


select * from hw_homework h, hw_user u left join hw_submit s on s.id = u.id where h.homeworkId = 0 
select * from hw_homework

select * from
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h inner join hw_submit s on h.homeworkId = s.homeworkId where u.grade = 6 and u.class = 2 and h.homeworkId = 6) a inner join
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h left join hw_submit s on u.id = s.id where u.grade = 6 and u.class = 2 and h.homeworkId = 6) b
on a.id = b.id and a.homeworkId = b.homeworkId where 


select a.id, a.grade, a.class, a.num, a.name, case when a.subDate = b.subDate then a.subDate else null end as subDate, case when a.confirm = b.confirm then 'O' else 'X' end as confirm, a.homeworkId from 
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h left join hw_submit s on h.homeworkId = s.homeworkId) a inner join
(select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h left join hw_submit s on u.id = s.id ) b
on a.id = b.id and a.homeworkId = b.homeworkId where a.grade = 6 and a.class = 2 and a.homeworkId = 0 and a.position = '학생' order by a.num

























