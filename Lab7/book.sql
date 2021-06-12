create database book;
use book;
create table publisher(
name varchar(20),
phone_no varchar(15),
address varchar(20),
primary key(name)
);

create table book(
book_id int,
title varchar(20),
pub_year varchar(20),
publisher_name varchar(20),
primary key(book_id),
foreign key(publisher_name) references publisher(name) on delete cascade
);

create table book_authors(
author_name varchar(20),
book_id int,
primary key(book_id,author_name),
foreign key(book_id) references book(book_id) on delete cascade
);

create table library_branch(
branch_id int,
branch_name varchar(50),
address varchar(50),
primary key(branch_id)
);

create table book_copies(
no_of_copies int,
book_id int,
branch_id int,
primary key(book_id,branch_id),
foreign key(book_id) references book(book_id) on delete cascade,
foreign key(branch_id) references library_branch(branch_id) on delete cascade
);

create table card(
card_no int,
primary key(card_no)
);

create table book_lending(
date_out date,
due_date date,
book_id int,
branch_id int,
card_no int,
primary key(book_id,branch_id,card_no),
foreign key(book_id) references book(book_id) on delete cascade,
foreign key(branch_id) references library_branch(branch_id) on delete cascade,
foreign key(card_no) references card(card_no) on delete cascade
);

insert into publisher
values("Mcgraw_Hill",9989076587,"Bangalore"),("Pearson",9889076565,"New_Delhi"),("Random_house",7455679345,"Hydrabad"),("Hachette_Liver",8970862340,"Chennai"),("Grupo_Planeta",7756120238,"Bangalore");

INSERT INTO book VALUES (1,"DBMS","JAN-2017", "Mcgraw_Hill");
INSERT INTO book VALUES (2,"ADBMS","JUN-2016", "Mcgraw_Hill");
INSERT INTO book VALUES (3,"CN","SEP-2016", "Pearson");
INSERT INTO book VALUES (4,"CG","SEP-2015","Grupo_Planeta");
INSERT INTO book VALUES (5,"OS","MAY-2016", "Pearson");

INSERT INTO book_authors VALUES ("NAVATHE", 1);
INSERT INTO book_authors VALUES ("NAVATHE", 2);
INSERT INTO book_authors VALUES ("TANENBAUM", 3);
INSERT INTO book_authors VALUES ("EDWARD ANGE", 4);
INSERT INTO book_authors VALUES ("GALVIN", 5);

INSERT INTO library_branch VALUES (10,"RR NAGAR","Bangalore");
INSERT INTO library_branch VALUES (11,"RNSIT","Bangalore");
INSERT INTO library_branch VALUES (12,"RAJAJI NAGAR", "Bangalore");
INSERT INTO library_branch VALUES (13,"NITTE","Mangalore");
INSERT INTO library_branch VALUES (14,"MANIPAL","Upupi");

INSERT INTO book_copies VALUES (10, 1, 10),
(5, 1, 11),
(2, 2, 12),
(5, 2, 13),
(7, 3, 14),
 (1, 5, 10),
(3, 4, 11);
truncate table book_copies;

INSERT INTO card VALUES (100);
INSERT INTO card VALUES (101);
INSERT INTO card VALUES (102);
INSERT INTO card VALUES (103);
INSERT INTO card VALUES (104);

INSERT INTO book_lending VALUES ("2017-01-01","2017-06-01", 1, 10, 101);
INSERT INTO book_lending VALUES ("2017-01-11","2017-03-11", 3, 14, 101);
INSERT INTO book_lending VALUES ("2017-02-21","2017-04-21", 2, 13, 101);
INSERT INTO book_lending VALUES ("2017-03-15","2017-07-15", 4, 11, 101);
INSERT INTO book_lending VALUES ("2017-04-12","2017-05-12", 1, 11, 104);

select * from book;
select * from book_authors;
select * from book_copies;
select * from book_lending;
select * from card;
select * from library_branch;
select * from publisher;

select b.book_id,b.title,b.publisher_name,a.author_name,l.branch_id,c.no_of_copies
from book b,book_authors a,book_copies c,library_branch
where b.book_id=a.book_id and b.book_id=c.book_id and l.branch_id=c.branch_id;

select card_no 
from book_lending b
where  date_out between "2017-01-01" and "2017-07-01"
group by card_no
having count(*)>3;

delete from book
where book_id=3;

create view publication as 
select pub_year
from book;
select * from publication;

create view v_book as 
select b.book_id,b.title,c.no_of_copies
from book b,book_authors a,book_copies c,library_branch l
where b.book_id=a.book_id and b.book_id=c.book_id and l.branch_id=c.branch_id;
select * from v_book;
