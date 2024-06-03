#Table Creation
USE bank_database;
DROP TABLE IF EXISTS `Client`;
DROP TABLE IF EXISTS `Clientbalance`;
DROP TABLE IF EXISTS `client_account_type`;
create table `Client`(`client_id` int primary key, `account_number` int, `client_name` varchar(40), `balance` varchar(40) default '$0', `account_type` enum('None','Unleaded','Premium'), `credit_score` int default 0);

#Loading file
SET GLOBAL local_infile = 1;
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `Client` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;


#displaying table
select * from `Client`;

#The manager wants to see the table sorted in descending according to the customer ID and he wants us to change "CustomerID" attribute name to "ID" instead
select * from `Client` order by `client_id` desc;

#The manager is looking for a customer with the highest amount of savings to give them a special offer
select * from `Client` order by `balance` desc LIMIT 1;


#Query for Customer1. They only want to see their Account Number, checking balance and saving balance
select `account_number`,`balance` from `Client` where `client_name`='Customer 1';

#Customer1 didn't liked that his name was "Customer1" therefore he threatened to speak to our manager if we didn't change his name to his real name
update `Client`
set client_name='poopy'
where client_id='1';
select * from `Client` where `client_id`=1;


#Clients want to see their balance and their account types juxtaposed but for some reason they also want two client_name columns because they have short-term memories
create table `Clientbalance`(`client_name` varchar(40), `balance` varchar(40) default '$0');
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `Clientbalance` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines (@dummy1, @dummy2, client_name,balance, @dummy3, @dummy4);
select * from `Clientbalance`;

create table `client_account_type`(`client_name` varchar(40), `account_type` enum('None','Unleaded','Premium'));
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `client_account_type` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines (@dummy1, @dummy2, client_name,@dummy3, account_type, @dummy4);
select * from `client_account_type`;

select *
from Clientbalance join client_account_type on `Clientbalance`.client_name= `client_account_type`.client_name;

select *
from `Clientbalance` left join `client_account_type` on `Clientbalance`.`client_name` = `client_account_type`.`client_name`;




