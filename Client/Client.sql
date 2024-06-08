#Table Creation
USE bank_database;
DROP TABLE IF EXISTS `Client`;
DROP TABLE IF EXISTS `Clientcreditscore`;
DROP TABLE IF EXISTS `client_details`;
create table `Client`(`client_id` int primary key, `account_number` int, `client_name` varchar(40), `balance` varchar(40) default '$0', `account_type` enum('None','Unleaded','Premium'), `credit_score` int default 0);

#Loading file
SET GLOBAL local_infile = 1;
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `Client` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

#We changed our minds and decided to include details on attributes for `account_number`,`account_type`, and `balance` in another table.
alter table `Client` drop column `account_number`, drop column `account_type`, drop column `balance`;

#displaying table
select * from `Client`;

#The manager wants to see the table sorted in descending according to the customer ID and he wants us to change "CustomerID" attribute name to "ID" instead
select * from `Client` order by `client_id` desc;

#The manager is looking for the customer with the highest credit score
select * from `Client` order by `credit_score` desc LIMIT 1;


#Customer1 didn't liked that his name was "Customer1" therefore he threatened to speak to our manager if we didn't change his name to his real name
update `Client`
set client_name='poopy'
where client_id='1';

#displaying "Customer1's" details
select * from `Client` where `client_id`=1;


#Clients want to see their credit scores and their client id juxtaposed side-by-side, thus reducing their cognitive load on trying to remember details
create table `Clientcreditscore`(`client_name` varchar(40), `credit_score` int default 0);
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `Clientcreditscore` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines (@dummy1, @dummy2, client_name,@dummy4, @dummy5, credit_score);
select * from `Clientcreditscore`;

create table `client_details`( `client_id` int primary key, `client_name` varchar(40));
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `client_details` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines (client_id, @dummy1, client_name,@dummy2, @dumm3, @dummy4);
select * from `client_details`;

select *
from `client_details` natural join `Clientcreditscore`;

#There are suspicions that there might be some data anomalies due to an update anomaly caused by our intern. Our supervisor wants to check the data integrity of both tables 
select *
from `client_details` join `Clientcreditscore`on `Clientcreditscore`.`client_name` = `client_details`.`client_name`;




