CREATE DATABASE MOVIE;
USE MOVIE;

CREATE TABLE ACTOR ( 
ACT_ID INT, 
ACT_NAME VARCHAR (20), 
ACT_GENDER CHAR (1), 
PRIMARY KEY (ACT_ID)); 

CREATE TABLE DIRECTOR ( 
DIR_ID INT, 
DIR_NAME VARCHAR (20), 
DIR_PHONE LONG, 
PRIMARY KEY (DIR_ID)); 

CREATE TABLE MOVIES ( 
MOV_ID INT, 
MOV_TITLE VARCHAR (25), 
MOV_YEAR INT, 
MOV_LANG VARCHAR (12), 
DIR_ID INT, 
PRIMARY KEY (MOV_ID), 
FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR (DIR_ID));

CREATE TABLE MOVIE_CAST ( 
ACT_ID INT, 
MOV_ID INT, 
AROLE VARCHAR(10), 
PRIMARY KEY (ACT_ID, MOV_ID), 
FOREIGN KEY(ACT_ID) REFERENCES ACTOR(ACT_ID) ON DELETE CASCADE, 
FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE); 

CREATE TABLE RATING ( 
MOV_ID INT, 
REV_STARS VARCHAR (25), 
PRIMARY KEY (MOV_ID), 
FOREIGN KEY (MOV_ID) REFERENCES MOVIES (MOV_ID));

INSERT INTO ACTOR VALUES (301,'ANUSHKA','F'); 
INSERT INTO ACTOR VALUES (302,'PRABHAS','M'); 
INSERT INTO ACTOR VALUES (303,'PUNITH','M'); 
INSERT INTO ACTOR VALUES (304,'JERMY','M'); 
select * from actor;


INSERT INTO DIRECTOR VALUES (60,'RAJAMOULI', 8751611001); 
INSERT INTO DIRECTOR VALUES (61,'HITCHCOCK', 7766138911); 
INSERT INTO DIRECTOR VALUES (62,'FARAN', 9986776531); 
INSERT INTO DIRECTOR VALUES (63,'STEVEN SPIELBERG', 8989776530); 

INSERT INTO MOVIES VALUES (1001,'BAHUBALI-2', 2017,'TELAGU', 60); 
INSERT INTO MOVIES VALUES (1002,'BAHUBALI-1', 2015, 'TELAGU', 60); 
INSERT INTO MOVIES VALUES (1003,'AKASH', 2008, 'KANNADA', 61); 
INSERT INTO MOVIES VALUES (1004,'WAR HORSE', 2011, 'ENGLISH', 63); 

INSERT INTO MOVIE_CAST VALUES (301, 1002, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (301, 1001, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (303, 1003, 'HERO'); 
INSERT INTO MOVIE_CAST VALUES (303, 1002, 'GUEST'); 
INSERT INTO MOVIE_CAST VALUES (304, 1004, 'HERO'); 

INSERT INTO RATING VALUES (1001, 4); 
INSERT INTO RATING VALUES (1002, 2);
INSERT INTO RATING VALUES (1003, 5); 
INSERT INTO RATING VALUES (1004, 4);

select * from rating;
select * from actor;
select * from director;
select * from movies;
select * from movie_cast;

select mov_title
from movies m,director d
where m.dir_id=d.dir_id and dir_name="Hitchcock";

select m.mov_title
from movies m,movie_cast c
where m.mov_id=c.mov_id and act_id in(select act_id from movie_cast group by act_id having count(act_id)>1)
group by m.mov_title
having count(*)>=1;

select act_name
from actor
where act_id =(
select c.act_id 
from movie_cast c,movies m
where c.mov_id=m.mov_id and m.mov_year not between 2000 and 2015);

select mov_title,max(rev_stars)
from movies m,rating r
where m.mov_id=r.mov_id
group by mov_title
having count(*)>=1
order by mov_title;

update rating set rev_stars=5 
where mov_id in(select mov_id 
from movies 
where dir_id in (select dir_id
from director
where dir_name="Steven Spielberg"));

select * from rating;
