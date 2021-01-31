-- Frequently used queries for the database

-- To use the All Stone Care database
use all_stone_care;

-- To commit any changes to the DB
commit;

-- To rollback any changes to the previous commit
rollback;

-- show all tables
show tables;

-- Describe a table
DESC supplier;

-- Drop a specific table
DROP TABLE viewing;
DROP TABLE supplier;

-- Describe a table e.g supplier, staff etc
DESC client;

-- Select statements --

-- Select from a table e.g client, manager, staff, viewings etc
SELECT * FROM client;
SELECT * FROM viewing;
SELECT * FROM job;
SELECT * FROM supplyItem;
SELECT * FROM client_backup;
SELECT * FROM viewing_backup;
SELECT * FROM job_backup;

-- Select using join for viewing and jobs
select * from client natural join viewing;  
select * from client natural join job;  

-- Simple select statements
SELECT concat(fname, ' ', lname) AS Name FROM Client;
SELECT DISTINCT town FROM client; 
SELECT street FROM client WHERE street LIKE '%Green%';
select concat(fName, ' ', lName) as Name, street from client where street LIKE '%Green%';

-- Select statments to order information  
SELECT * FROM client ORDER BY lname, fname;
SELECT * FROM viewing ORDER BY viewingDate;
SELECT * FROM job ORDER BY jobDate;

-- Select from supply items based on various criteria
SELECT * from supplyItem WHERE itemDescription = 'Marble Sealant';
SELECT * from supplyItem WHERE itemCost <= 10.99;
SELECT * from supplyItem WHERE itemCost >= 10.99;
SELECT * from supplyItem WHERE itemCost between 10.99 and 21.99;
SELECT * from supplyItem WHERE stockQuantity <= 10;
SELECT * from supplyItem WHERE supplierId = 'SC3';

-- Update records

-- Update  supply items based on price
UPDATE supplyItem 
SET itemCost = 9.99
WHERE itemCost = 10.00;

-- Update  client telephone number
UPDATE client 
SET contactNo = '914-031-5678'
WHERE contactNo = '914-032-5678';

-- Update  client telephone number
UPDATE client 
SET emailAddress = 'new email'
WHERE contactNo = 'old email';


-- Aggregate Functions - These may be used for market resarch or to gather statistics on stock/supplies

-- Count the number of customers in the database
SELECT COUNT(clientId) 
FROM client;

SELECT COUNT(clientId) as 'Number of CLients in Connecticut' 
FROM CLIENT 
WHERE STATE = 'CT';

SELECT COUNT(clientId) as 'Number of CLients in Rye' 
FROM CLIENT 
WHERE town = 'Rye';

SELECT round(avg(itemCost),2) as 'Average Supply Item cost' 
FROM supplyItem 
WHERE itemDescription like '%Grout%';

select max(itemCost) as 'Most expensive Supply Item' from supplyItem;
select min(itemCost) as 'Least expensive Supply Item' from supplyItem;
select round(avg(itemCost),2) as 'Average Supply Item price' from supplyItem;

-- Select statement using joins

select fname, lname                      
from client join viewing                                                   
on client.clientId = viewing.viewingId                                                             
where viewingDate between '2020-11-24' and '2020-11-30'; 

select concat(fName, ' ', lName) as Name, viewingDate as 'Viewing Date'
from client join viewing 
on client.clientid = viewing.viewingid 
group by Name
order by lName, fName;

-- Delete all records from a table
DELETE FROM viewing;

-- Delete bases on specific criteria. I have used fname name here 
DELETE FROM supplyItem
WHERE itemDescription = 'Sealant';

-- Delete from viewing where the client Id is 1
DELETE FROM viewing
WHERE clientId = '1';

-- reset auto-increment on required tables  

-- Here it is zero but if you delete client number 100 the auto-increment number should be changed
ALTER TABLE client AUTO_INCREMENT = 34;
ALTER TABLE viewing AUTO_INCREMENT = 0;

-- Alter the properties of the table
ALTER TABLE client
    MODIFY COLUMN clientId varchar(30);
    
-- Select the created views such as viewings next week
SELECT * FROM viewings_by_time;
SELECT * FROM viewings_by_date;
SELECT * FROM viewings_by_date_time;

DROP VIEW viewings_by_time;
    
-- View all users
SELECT user, host FROM mysql.user;    

-- creates users for the database

create user Manager identified by 'manager';

create user HeadAdmin identified by 'head';

create user AssistantAdmin identified by 'admin';

create user TechnicianEmployee identified by 'staff';

-- grants appropriate privileges to staff members

grant all on all_stone_care.* to Manager with grant option;

-- HeadAdmin has insert, update, delete, & select privileges on Client, Viewing & job
grant insert, update, delete, select on client to HeadAdmin;
grant insert, update, delete, select on job to HeadAdmin;
grant insert, update, delete, select on viewing to HeadAdmin;

-- AssistantAdmin has insert, update & select privileges only on Client, Viewing & job
grant insert, update, select on client to AssistantAdmin;
grant insert, update, select on job to AssistantAdmin;
grant insert, update, select on viewing to AssistantAdmin;

-- TechnicianEmployee has insert & select only privileges only on Client, Viewing & job
-- All updates should be confirmed with Mgmt or Admin staff
grant select on client to TechnicianEmployee;
grant insert, select on job to TechnicianEmployee;
grant insert, select on viewing to TechnicianEmployee;

show grants for TechnicianEmployee;
revoke insert, select, update on viewing from TechnicianEmployee;
drop user TechnicianEmployee;

-- Test queries for triggers & Indexes

INSERT INTO client (fname, lname, houseNo, street, town, state, zipCode, contactNo, emailaddress)
VALUES 
('Test', 'Client', '1','Test Drive', 'Greenwich', 'CT', '06830', '914-032-5678', 'marykelly@gmail.com');

DELETE FROM client
WHERE fname = 'Test';

INSERT INTO viewing (viewingDate, viewingTime, clientId)
VALUES 
('2020-12-12', '20:00:00', '36');

DELETE FROM viewing
WHERE clientId = '36';

INSERT INTO job (jobDate, jobTime, jobDescription, clientId)
VALUES 
('2020-12-12', '20:00:00', 'test', '35');

DELETE FROM job
WHERE clientId = '35';

SHOW INDEX FROM client;
 
create index client_email on client(emailAddress ASC);
show index from client;
ALTER TABLE CLIENT DROP INDEX client_email;


