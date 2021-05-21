create database supplier;
use supplier;

create table SUPPLIERS(
sid int primary key, 
sname varchar(20), 
city varchar(20)
);

create table PARTS
(pid int primary key, 
pname varchar(20), 
color varchar(10));

create table CATALOG(sid int, pid int, foreign key(sid)
references SUPPLIERS(sid), foreign key(pid) references PARTS(pid), cost float(6),
primary key(sid, pid));

insert into SUPPLIERS (sid,sname,city) values
(10001, 'Acme Widget','Bangalore'),
(10002, 'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004, 'Reliance','Delhi'),
(10005, 'Mahindra','Mumbai');
select * from SUPPLIERS;

insert into PARTS (pid,pname,color) values
(20001, 'Book','Red'),
(20002, 'Pen','Red'),
(20003, 'Pencil','Green'),
(20004, 'Mobile','Green'),
(20005, 'Charger','Black');
select * from PARTS;

insert into CATALOG (sid,pid,cost) values
(10001, 20001,10);

insert into CATALOG (sid,pid,cost) values
(10001, 20002,10),
(10001, 20003,30),
(10001, 20004,10),
(10001, 20005,10),
(10002, 20001,10),
(10002, 20002,20),
(10003, 20003,30),
(10004, 20003,40);
select * from CATALOG;

SELECT DISTINCT P.pname
from PARTS P,CATALOG C
WHERE P.pid=C.pid;

SELECT s.sname
from SUPPLIERS s,CATALOG c
where s.sid=c.sid
group by c.sid
having count(distinct c.pid)=(select count(*) from PARTS);

SELECT distinct s.sname
from SUPPLIERS s,CATALOG c
where s.sid=c.sid and c.pid in(select pid from PARTS where color='red');

select pname
from PARTS p, SUPPLIERS s1, CATALOG c1
where p.pid=c1.pid and s1.sid=c1.sid and s1.sname='Acme Widget' and not exists
(select *
from CATAlOG c2,SUPPLIERS s2
where c1.pid=c2.pid and s2.sname<>'Acme Widget' and s2.sid=c2.sid);

select sid
from CATALOG c1
where cost >
(select avg(cost)
from CATALOG c2
where c1.pid=c2.pid); 

select pid, sname
from CATALOG c1,SUPPLIERS S
where c1.sid=s.sid and cost =
(select max(cost)
from CATALOG c2
where c1.pid=c2.pid); 


