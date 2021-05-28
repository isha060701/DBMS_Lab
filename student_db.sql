create database student_db;
use student_db;
CREATE TABLE student(
 snum INT,
 sname VARCHAR(10),
 major VARCHAR(2),
 lvl VARCHAR(2),
 age INT, primary key(snum));
 
 CREATE TABLE faculty(
 fid INT,fname VARCHAR(20),
 deptid INT,
 PRIMARY KEY(fid));
 
 CREATE TABLE class(
 cname VARCHAR(20),
 metts_at TIMESTAMP,
 room VARCHAR(10),
 fid INT,
 PRIMARY KEY(cname),
 FOREIGN KEY(fid) REFERENCES faculty(fid));
 
 alter table class rename column metts_at to meets_at;
 
 CREATE TABLE enrolled(
 snum INT,
 cname VARCHAR(20),
 PRIMARY KEY(snum,cname),
 FOREIGN KEY(snum) REFERENCES student(snum),
FOREIGN KEY(cname) REFERENCES class(cname));

insert into student (snum,sname,major,lvl,age) VALUES
(1, 'jhon', 'CS', 'Sr', 19),
(2, 'Smith', 'CS', 'Jr', 20),
(3 , 'Jacob', 'CV', 'Sr', 20),
(4, 'Tom ', 'CS', 'Jr', 20),
(5, 'Rahul', 'CS', 'Jr', 20),
(6, 'Rita', 'CS', 'Sr', 21);
select * from student;

INSERT INTO faculty VALUES
(11, 'Harish', 1000),
(12, 'MV', 1000),
(13 , 'Mira', 1001),
(14, 'Shiva', 1002),
(15, 'Nupur', 1000);
select * from faculty;

insert into class values
('class1', '12/11/15 10:15:16', 'R1', 14),
('class10', '12/11/15 10:15:16', 'R128', 14),
('class2', '12/11/15 10:15:20', 'R2', 12),
('class3', '12/11/15 10:15:25', 'R3', 12),
('class4', '12/11/15 20:15:20', 'R4', 14),
('class5', '12/11/15 20:15:20', 'R3', 15);

insert into class values
('class6', '12/11/15 13:20:20', 'R2', 14),
('class7', '12/11/15 10:10:10', 'R3', 14);
update class set fid=11 where cname='class3';
select * from class;

insert into enrolled values
(1, 'class1'),
(2, 'class1'),
(3, 'class3'),
(4, 'class3'),
(5, 'class4'),
(1, 'class5'),
(2, 'class5'),
(3, 'class5'),
(4, 'class5'),
(5, 'class5');
select * from enrolled;

select sname
from student
where lvl='Jr' and snum in
(select snum 
from enrolled e,class c,faculty f
where e.cname=c.cname and c.fid=f.fid and f.fname='Harish');


select distinct c.cname
from class c
where c.room='R128' or cname in
(select cname
from enrolled 
group by cname
having count(*)>=5);
 
SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum IN (SELECT E1.snum
FROM Enrolled E1, Enrolled E2, Class C1, Class C2
WHERE E1.snum = E2.snum AND E1.cname<> E2.cname
AND E1.cname = C1.cname
AND E2.cname = C2.cname AND C1.meets_at = C2.meets_at);
 
 
 
 select f.fname
 from faculty f,class c
 where c.fid=f.fid 
 group by c.fid
 having count(c.fid)=
 (select count(distinct room)
 from class);

 

select fname
from faculty
where fid not in
(select f.fid
from faculty f,class c,enrolled e
where e.cname=c.cname and c.fid=f.fid
group by e.cname
having count(*)>=5);


select sname
from student s
where s.snum not in
(select e.snum
from enrolled e);


select s.age,s.lvl
from student s
group by s.age
having s.lvl in
(select s1.lvl 
from student s1
where s1.age=s.age
group by s1.age
having count(*)>=all(select s2.lvl from student s2
where s2.age=s1.age 
group by s2.age));
