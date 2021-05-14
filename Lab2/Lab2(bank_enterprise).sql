create database bank;
use bank;

CREATE TABLE branch
     ( branch_name VARCHAR(15),
       branch_city VARCHAR(15),
       assets real,
       PRIMARY KEY(branch_name)
     );
alter table branch modify branch_name varchar(30);

CREATE TABLE BankAccount
     ( accno INTEGER,
       branch_name VARCHAR(15),
       balance real,
       PRIMARY KEY(accno),
       FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
     );
alter table BankAccount modify branch_name varchar(30);
CREATE TABLE customer
    ( customer_name VARCHAR(15),
      customer_street VARCHAR(15),
      customer_city VARCHAR(15),
      PRIMARY KEY(customer_name)
    );
alter table customer modify customer_street varchar(30);
CREATE TABLE loan
    ( loan_number integer,
      branch_name VARCHAR(15),
      amount real,
      PRIMARY KEY(loan_number),
      FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
    );
alter table loan modify branch_name varchar(30);
CREATE TABLE depositor
    ( customer_name VARCHAR(15),
      accno INTEGER,
      PRIMARY KEY(customer_name, accno),
      FOREIGN KEY(customer_name) REFERENCES customer(customer_name),
      FOREIGN KEY(accno) REFERENCES BankAccount(accno)
    );

insert into branch (branch_name,branch_city,assets) values
('SBI_Chamrajpet', 'Bangalore',50000),
('SBI_ResidencyRoad', 'Bangalore',10000),
('SBI_ShivajiRoad', 'Bombay',20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);
select * from Branch;

INSERT INTO loan (loan_number,branch_name,amount) VALUES
(2, "SBI_ResidencyRoad", 2000),
 (1, 'SBI_Chamrajpet', 1000),
  (3, 'SBI_shivajiRoad', 3000),
(4, 'SBI_ParlimentRoad' ,4000),
  (5, 'SBI_Jantarmantar',5000);
select * from loan;

INSERT INTO BankAccount(accno,branch_name,balance) VALUES 
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParlimentRoad',9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),
(9,'SBI_ParlimentRoad',3000),
(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);
select * from BankAccount;

INSERT INTO customer(customer_name,customer_street,customer_city) VALUES 
('Avinash','Bull_Temple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');
select * from customer;

INSERT INTO depositor(customer_name,accno) VALUES ('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);
select * from depositor;


SELECT customer_name
            FROM depositor d,BankAccount a
            WHERE d.accno=a.accno
            AND a.branch_name='SBI_ResidencyRoad'
            GROUP BY d.customer_name
            HAVING COUNT(d.customer_name)>=2;

SELECT d.customer_name FROM BankAccount a, depositor d,branch b 
WHERE d.accno=a.accno AND b.branch_name=a.branch_name AND b.branch_city="Delhi" 
GROUP BY d.customer_name having count(distinct b.branch_name)=
(SELECT COUNT(branch_name) FROM branch  WHERE branch_city="Delhi"); 

DELETE FROM BankAccount WHERE branch_name IN(SELECT branch_name FROM BRANCH WHERE branch_city='Bombay'); 
select * from BankAccount;
