-- This section creates the database and tables

-- Creates the All Stone Care Database

CREATE DATABASE IF NOT EXISTS all_stone_care;

-- Creates the Client table

create table if not exists client(
	clientId int AUTO_INCREMENT, fname varchar(15), lname varchar(20), 
	houseNo smallint unsigned, street varchar(20), 
    town varchar(20), state varchar(20), zipCode smallint unsigned,
    contactNo char(15), emailAddress varchar(30),
primary key(clientId)) engine=InnoDB;

-- Creates the Viewing table

create table if not exists viewing(
	viewingId int AUTO_INCREMENT, viewingDate date, viewingTime time, clientId int,
    primary key(viewingId), 
    CONSTRAINT FK_clientId FOREIGN KEY(clientId) 
    references client(clientId) on update cascade
    on delete no action)
    engine=InnoDB;
     
-- Creates the Job table
    
create table if not exists job(
	jobNo int, jobDate date, jobTime time, jobDescription varchar(45), clientId int,
    primary key(jobNo), 
    foreign key(clientId) references client(clientId) 
    on update cascade 
    on delete no action)
    engine=InnoDB;
    
-- Creates the Supplier table    
    
create table if not exists supplier(
	supplierId varChar(30), supplierName varchar(25), unitNo smallint unsigned, street varchar(20), 
    town varchar(20), state varchar(20), zipCode smallint unsigned,
    contactNo char(15), faxNo char(15), emailAddress varchar(30),
    primary key(supplierId))
    engine=InnoDB;    
    
-- Creates the Supply Item table     
    
create table if not exists supplyItem(
	itemId int, itemDescription varchar(25), stockQuantity int unsigned, itemCost decimal(5,2), supplierId varchar(30),
    primary key(itemId),
     constraint fk_supplier foreign key(supplierId) references supplier(supplierId) 
    on update cascade 
    on delete no action)
    engine=InnoDB;
    
-- Creates the Staff table     

create table if not exists staff(
	staffId int, fname varchar(15), lname varchar(20), hourlyRate decimal(4,2), contactNo char(15), 
    primary key(staffId))
    engine=InnoDB;        
    
-- Creates the Manager table whcih is a sub-class of the Staff table   
    
create table if not exists manager(
	staffId int, bonus decimal(6,2),
    primary key(staffId),
    constraint fk_staff foreign key(staffId) references staff(staffId)
	on update cascade 
    on delete no action)
    engine=InnoDB;      
 
-- Creates the Technician table whcih is a sub-class of the Staff table      

create table if not exists technician(
	staffId int, experienceLevel char(25),
    primary key(staffId),
    foreign key(staffId) references staff(staffId)
   on update cascade 
    on delete no action)
    engine=InnoDB;   
    
-- Creates the Contrator table whcih is a sub-class of the Staff table      

create table if not exists contractor(
	staffId int, contractorStartDate date, contractorEndDate date, 
    primary key(staffId),
    foreign key(staffId) references staff(staffId)
    on update cascade 
    on delete no action)
    engine=InnoDB; 
    
-- Creates the Admin Staff table whcih is a sub-class of the Staff table      

create table if not exists adminStaff(
	staffId int,  jobGrade char(25),
    primary key(staffId),
    foreign key(staffId) references staff(staffId)
   on update cascade 
    on delete no action)
    engine=InnoDB;   

-- populates the tables with records

-- Inserts values into the Client table

INSERT INTO client (fname, lname, houseNo, street, town, state, zipCode, contactNo, emailaddress)
VALUES 
('Mary', 'Kelly', '100','Greenleaf Drive', 'Greenwich', 'CT', '06830', '914-032-5678', 'marykelly@gmail.com'),
('Mary', 'Stuart', '59', 'Zaccheus Mead', 'Greenwich', 'CT', '06831','203-832-7703', 'mstuart@home.com'),
('Paul', 'Mundinger', '4 ', 'Birdlane', 'Rye', 'NY', '10580', '914-967-3867', 'paul@icloud.com'),
('Lynne', 'Florian', '129', 'Five Mile River Road', 'Darien', 'CT', '06820','847-542-4056', 'lflorian@opton.net'),		
('Laura', 'Erickson', '67', 'Club Road', 'Riverside', 'CT', '06878','203-912-9858', 'le10@gmail.com'),				
('Jeff', 'Brandt', '52', 'Nursery Road', 'New  Canaan', 'CT', '06840','314-503-2678', 'jbrandt18@gmail.com'),										 			
('Liz', 'Levy', '8', 'Sterling South', 'Armonk', 'NY', '10504','917-697-5403', 'lizadlerlevy@gmail.com'),
('Alison', 'Mark', '32', 'Carriage Road', 'Wilton', 'CT', '06897','203-451-9114', 'amc0m@online.net'),
('Rhonda', 'Goldenberg', '1', 'Jofran Ln', 'Greenwich', 'CT', '06830','203-984-9463', 'evan@archart.com'),				
('Bonnie', 'Dudley', '1', 'Harbor Watch Rowayton Ave', 'Norwalk', 'CT', '06853','203-515-3409', 'bondud@online.net'),	
('Lauren', 'Milo', 'Apt 5F', '133 West 22nd Street', 'New York', 'NY', '10011','914-261-2580', 'milo@gmail.com'),					  		
('Kitellen', 'Milo', '247', 'Pelhamdale Ave', 'Pelham', 'NY', '10803','914-738-0997', 'kmilo@gmail.com'),						
('Ana', 'Collins', '20', 'Prospect Ave', 'Larchmont', 'NY', '10638','646-234-8817', 'anac@aol.com'),
('Robin C', 'Leach', '729', 'Oenoke Ridge', 'New Canaan', 'CT', '06850','203-554-2517', 'lpl4@aol.com'),								
('Cynthia', 'Vanneck', '99', 'Round Hill Road', 'Greenwich', 'CT', '06831','203 209-1231', 'cvanneck@aol.com'),		
('Ellen', 'Keats', '42', 'Perkins Road', 'Greenwich', 'CT', '06830','203 249-0331', 'ellenkeats@aol.com'),
('Lewin', 'Colby', '5', 'Glen Court', 'Greenwich', 'CT', '06830','914-321-6547', 'lcoby@hotmail.com'),					
('Arlene', 'Wagner', 'Uint 2', 'Sound View Dr', 'Greenwich', 'CT', '06830','914-434-1756', 'arlenew@gmail.com'),
('Peter', 'O\'Brien', '118', 'Meadow Road', 'Riverside', 'CT', '06878','203-536-4777', 'obrien.gpeter@gmail.com'),						
('Kathy', 'Morsey', '6', 'Memory Lane', 'Rowayton', 'CT', '06853', '203-866-1896', 'km@optonline.net'),			 
('Julie-Bob', 'Brenton', '6', 'Northern Ave', 'Bronxville', 'NY', '10708', '917-208-045', 'rdgalbraith@gmail.com'),						
('Tracy', 'Wendell', '113', 'Round Hill Road', 'Greenwich', 'CT', '06831','917-501-7000', 'tracywendell@verizon.net'),	 							
('Kristen', 'Staikos', '235', 'Lalley Blvd', 'Fairfield', 'CT', '06824', '203-981-9643', 'kstaikos@gmail.com'),						 		 	
('Julie', 'VanDenBerg', '25 ', 'Sterlng Road', 'Armonk', 'NY', '10504','914-261-7776', 'mlwv58@gmail.com'), 									
('Janice', 'Degaetano', '8', 'Maple Street', 'New Canaan', 'CT', '06840','203-273-4270', 'janicedegaetano@gmail.com'),						 			
('Andrea', 'Tighe', '147', 'Florence Avenue', 'Rye', 'NY', '10580','203-858-9614', 'andrea.tighe@yahoo.com'),
('Emilie', 'Murphy', '35', 'Drake Smith', 'Rye', 'NY', '10580','914-282-2555', 'emilieinrye@gmail.com'),
('Molly', 'Sillcocks', '11', 'Doeview Ln', 'Pound Ridge', 'NY', '10576','914-588-8681', 'mollysillcocks@gmail.com'),									
('Helen', 'Neuburger', '620', 'West Lyon Farm Dr', 'Greenwich', 'CT', '06831','203-507-6263', 'hneub1@gmail.com'),							 			
('Tom', 'Wright', '84', 'Station Road', 'Irvington', 'NY', '10533','212-203-3961', 'wright@gynpath.us'),					 			
('Karen', 'Zelicof', '71', 'Mamaroneck Road', 'Scarsdale', 'NY', '10583','914-772-8374', 'carenzelicof@gmail.com'),			 			
('Wayne', 'Tucker', '567', 'Indian Field Rd', 'Greenwich', 'CT', '06830','917-603-2526', 'wtuckerllc@gmail.com'),
('Jack', 'Coelho', '92', 'Cherry Valley Rd', 'Greenwich', 'CT', '06831','917-359-0605', 'jack.coelho2@gmail.com');

-- Inserts values into the Viewing table

INSERT INTO viewing (viewingDate, viewingTime, clientId) values
('2020-11-23', '9:00:00', '2'),
('2020-11-23', '10:30:00', '3'),
('2020-11-23', '11:00:00', '1'),
('2020-11-23', '12:00:00', '6'),
('2020-11-23', '14:00:00', '11'),
('2020-11-23', '15:30:00', '22'),
('2020-11-24', '9:00:00', '10'),
('2020-11-24', '11:30:00', '6'),
('2020-11-24', '16:30:00', '5'),
('2020-11-24', '17:00:00', '8'),
('2020-11-24', '9:30:00', '4'),
('2020-11-25', '11:15:00', '7'),
('2020-11-25', '14:30:00', '15');

-- Inserts values into the Job table

insert into job  (jobDate, jobDescription, jobTime, clientId) values
('2020-11-25', 'Polish Kitchen Countertops','9:00:00', '2'),
('2020-11-25', 'Polish and seal kitchen floors', '13:30:00', '3'),
('2020-11-27', 'Regrout master bathroom','09:00:00', '1'),
('2020-11-27', 'Replace backsplash in ensuite', '14:00:00', '6'),
('2020-11-28', 'Polish Kitchen Countertops', '09:00:00', '11'),
('2020-11-28', 'Replace shower tiles', '13:30:00', '22'),
('2020-11-29', 'Fix conutertop chips and polish', '9:00:00', '10'),
('2020-11-29', 'Polish and seal floors', '12:30:00', '6'),
('2020-11-30', 'Regrout master and ensuite bathroom', '16:00:00', '5'),
('2020-12-01', 'Polish and seal kitchen floors', '09:00:00', '8'),
('2020-12-01', 'Replace broken tile in shower', '12:45:00', '4'),
('2020-12-01', 'Fit backsplash in ensuite', '16:15:00', '7'),
('2020-12-02', 'Polish and seal kitchen floors', '09:30:00', '2');

-- Inserts values into the Staff table

insert into staff values 
('1', 'Peter', 'Luca', '35.00', '914-132-0298'),
('2', 'Joseph', 'Piro', '30.00', '914-231-0809'),
('3', 'Wilson', 'Gomez', '25.00', '914-015-2209'),
('4', 'Mark', 'McGraw', '20.00', '914-256-9872'),
('5', 'Adelle', 'McAteer', '15.00', '914-206-1918'),
('6', 'Valerie', 'Lucia', '20.00', '914-068-1823');

-- Inserts values into the Contractor table

insert into contractor (staffId, contractorStartDate, contractorEndDate) values
('2', '2020-11-16', '2020-12-24');

-- Inserts values into the Manager table

insert into manager (staffId, bonus) values
('1', '6000.00');

-- Inserts values into the Technician table

insert into technician (staffId, experienceLevel) values
('3', 'Intermediate'),
('4', 'Beginner');

-- Inserts values into the Admin Staff table

insert into adminStaff (staffId, jobGrade) values
('5', 'Assistant'),
('6', 'Head Admin');

-- Inserts values into the Supplier table

insert into supplier values 
('SC1', 'Rye Ridge Tile', '520', 'North Main Street', 'Port Chester', 'NY', '10573', '914-939-1100', '914-939-1102', 'ryeridge@tile.com' ),
('SC2', 'Greenwich Tile & Marble', '402', 'West Putnam Ave', 'Greenwich', 'CT', '06830', '203-869-1709', '203-869-1710', 'greenwich@tile.com' ),
('SC3', 'Millenium Stone', '1', 'Mill Street', 'Port Chester', 'NY', '10573', '855-235-6479', '855-235-6480', 'milleniumstone@tile.com' ),
('SC4', 'G K Building Suppliers', '115', 'Oak Street', 'Port Chester', 'NY', '10573', '914-939-4155', '914-939-4156', 'gksupplies@building.com' ),
('SC5', 'New Engalnd Tile', '149', 'Westchester Ave', 'Port Chester', 'NY', '10573', '914-481-4488', '914-481-4489', 'newengland@tile.com' ),
('SC6', 'Eastern Stone NY', '52', 'Cottage St', 'Port Chester', 'NY', '10573', '914-937-2100', '914-937-2101', 'easternstone@tile.com' );

-- Inserts values into the Supply Item table

insert into supplyItem values 
('100', 'Grout - White 500g', '10', '10.00', 'SC1'),
('101', 'Grout - Gray 500g', '10', '10.00', 'SC1'),
('102', 'Silicone Caulk - White 500ml', '15', '5.00', 'SC2'),
('103', 'Silicone Caulk - Gray 500ml', '5', '5.00', 'SC2'),
('104', 'Silicone Grout Sealer - White', '10','11.99', 'SC3'),
('105', 'Silicone Grout Sealer - Gray', '5', '11.99', 'SC3'),
('106', 'Tile Adhesive', '10', '5.99', 'SC4'),
('107', 'Cleaning cloths', '150', '21.99', 'SC5'),
('108', 'Marble Sealant', '25', '21.99', 'SC6'),
('109', 'Marble tile 12x12 - White Carrara', '100', '6.95', 'SC1'),
('110', 'Granite slab 10x6', '5', '110.95', 'SC3'),
('111', 'Marble slab - White Carrara 10x6', '6', '119.95', 'SC3');

-- This section looks at triggers and indexes

 show triggers;
  drop table job_backup;

-- creates triggers
create table if not exists client_backup (clientId int AUTO_INCREMENT, 
      fname varchar(15), lname varchar(20), 
      houseNo smallint unsigned, street varchar(20), 
      town varchar(20), state varchar(20), zipCode smallint unsigned,
	  contactNo char(15), emailAddress varchar(30),
      primary key(clientId)); 
 
DELIMITER $$
CREATE TRIGGER client_backup before delete ON client 
FOR EACH ROW
BEGIN
INSERT INTO client_backup 
values(
OLD.clientId, OLD.fname, 
OLD.lname, OLD.houseNO, OLD.street, OLD.town, OLD.state, 
OLD.zipcode, OLD.contactNo, OLD.emailaddress);
END $$ DELIMITER ;
   		
create table if not exists viewing_backup (
	viewingId int AUTO_INCREMENT, viewingDate date, 
    viewingTime time, clientId int,
    primary key(viewingId)); 
    
DELIMITER $$
CREATE TRIGGER viewing_backup before delete ON viewing 
FOR EACH ROW
BEGIN
INSERT INTO viewing_backup 
values(
OLD.viewingId, OLD.viewingDate, 
        OLD.viewingTime, OLD.clientId);
END $$ DELIMITER ;
   		
create table if not exists job_backup(
	jobNo int, jobDate date, jobTime time, jobDescription varchar(45),
    clientId int,
    primary key(jobNo), 
    foreign key(clientId) references client(clientId)); 
    
DELIMITER $$
CREATE TRIGGER job_backup before delete ON job 
FOR EACH ROW
BEGIN
INSERT INTO job_backup
values(
OLD.jobNo, OLD.jobDate, 
        OLD.jobTime, OLD.jobDescription, OLD.clientId);
END $$ DELIMITER ;

-- creates views
-- This view returns the date of bookings

CREATE OR REPLACE VIEW viewings_by_date AS
    Select distinct concat(fname,' ',lname) Name
    FROM client 
    join viewing 
   on client.clientId = viewing.viewingId;          

CREATE OR REPLACE VIEW viewings_by_date_time AS
    Select distinct concat(fname,' ',lname) Name
    FROM client 
    join viewing 
   on client.clientId = viewing.viewingId   
where viewingDate='2020-11-23'  
and
viewingTime= '09:00:00'; 
    