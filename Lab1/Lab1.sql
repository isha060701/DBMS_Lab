CREATE DATABASE insurancedb;
USE insurancedb;

create table Person(
driver_id varchar(3),
name varchar(12),
address varchar(30),
PRIMARY KEY (driver_id)
);
create table Car(
reg_num varchar(8),
model varchar(15),
year int,
PRIMARY KEY(reg_num)
);
create table Accident(
report_num int,
accindent_date date,
location varchar(30),
PRIMARY KEY(report_num)
);

create table Owns(
driver_id varchar(3),
reg_num varchar(8),
PRIMARY KEY (driver_id,reg_num),
FOREIGN KEY (driver_id) references Person(driver_id),
FOREIGN KEY (reg_num) references Car(reg_num)
);

create table Participated(
driver_id varchar(3),
reg_num varchar(8),
report_num int,
damage_amount int,
PRIMARY KEY (driver_id,reg_num,report_num),
FOREIGN KEY (driver_id) references Person(driver_id),
FOREIGN KEY (reg_num) references Car(reg_num),
FOREIGN KEY (report_num) references Accident(report_num)
);

insert into Person
values ("A01","Richard","Srinivas nagar"),("A02","Pradeep","Rajaji nagar"),("A03","Smith","Ashhok nagar"),("A04","Venu","N R Colony"),("A05","Jhon","Hanumanth nagar");
select * from Person;

insert into Car
values ("KA052250","Indica",1990),("KA031181","Lancer",1957),("KA095477","Toyota",1998),("KA053408","Honda",2008),("KA041702","Audi",2005);
select * from Car;

insert into Owns
values ("A01","KA052250"),("A02","KA053408"),("A03","KA031181"),("A04","KA095477"),("A05","KA041702");
select * from Owns;

insert into Accident
values (11,"01-01-03","Mysore Road"),(12,"02-02-03","South and Circle"),(13,"21-01-03","Bull temple Road"),(14,"17-02-08","Mysore Road"),(15,"04-03-05","Kanakpura Road");
select * from Accident;

insert into Participated
values ("A01","KA052250",11,10000),("A02","KA053408",12,50000),("A03","KA095477",13,25000),("A04","KA031181",14,3000),("A05","KA041702",15,5000);
select * from Participated;
update Participated set report_num=13 where driver_id="A03";
update Participated set report_num=14 where driver_id="A04";
update Participated set report_num=15 where driver_id="A05";

update Participated set damage_amount=25000 where report_num=12 and reg_num="KA053408";
select * from Participated;

insert into Accident(report_num,accindent_date,location)
values(16,'2008-03-15','Domlur');
select * from Accident;


select count(accindent_date) as accidents2008 from Accident
where year(accindent_date)=2008;

select count(model) as cars_in_accident from Car
where model="Lancer";
