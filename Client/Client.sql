#Table Creation
USE bank_database;
DROP TABLE IF EXISTS `Client`;
create table `Client`(`client_id` int primary key, `account_number` int, `client_name` varchar(40), `balance` varchar(40) default '$0', `account_type` enum('None','Unleaded','Premium'), `credit_score` int default 0);

#Loading file
SET GLOBAL local_infile = 1;
load data local infile 'Client_Data.csv' into table `Client` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;


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




