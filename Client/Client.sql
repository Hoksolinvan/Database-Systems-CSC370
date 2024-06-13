#Table Creation
USE bank_database;
DROP TABLE IF EXISTS `Client`;
DROP TABLE IF EXISTS `Clientcreditscore`;
DROP TABLE IF EXISTS `client_details`;
DROP TABLE IF EXISTS `client_information_table`;
DROP TABLE IF EXISTS `Subscription`;
DROP TABLE IF EXISTS `Account`;
create table `Client`(`client_id` int primary key, `account_number` int, `client_name` varchar(40), `balance` varchar(40) default '$0', `account_type` enum('None','Unleaded','Premium'), `credit_score` int default 0);

select * from `Client`;
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
















#########################
#Sprint 2
#########################
DROP TABLE IF EXISTS `Subscription`,`Account`,`client_information_table`,`account_information_table`,`subscription_information_table`,`client_to_subscription_link`;
#BCNF
#Preparing relevant relations and data for BCNF Normalization
CREATE TABLE `Subscription`(
    `subscription_id` INT PRIMARY KEY,
    `service_name` VARCHAR(150),
    `subscription_init_date` DATE,
    `subscription_end_date` DATE,
    `subscription_status` enum('active', 'inactive', 'cancelled', 'pending'),
    `monthly_fee` DECIMAL(15, 2) DEFAULT 0.00,
    `client_id` INT,
    FOREIGN KEY (client_id) REFERENCES Client(client_ID)
);

INSERT INTO `Subscription` (`subscription_id`, `service_name`, `subscription_init_date`, `subscription_end_date`, `subscription_status`, `monthly_fee`, `client_id`)
VALUES
(1, 'Streaming Service', '2023-01-01', '2024-12-31', 'active', 9.99, 1),
(2, 'Gym Membership', '2023-02-01', '2024-11-30', 'active', 29.99, 2),
(3, 'Newsletter Subscription', '2023-03-01', '2024-06-01', 'pending', 5.00, 3),
(4, 'Premium Support', '2023-04-01', '2023-05-31', 'cancelled', 49.99, 4),
(5, 'Online Courses', '2023-05-01', '2024-10-31', 'inactive', 19.99, 5),
(6, 'Magazine Subscription', '2023-06-01', '2023-12-31', 'cancelled', 10.00, 1),
(7, 'Fitness App', '2023-07-01', '2024-06-30', 'active', 15.00, 2),
(8, 'Music Service', '2023-08-01', '2023-12-31', 'cancelled', 8.99, 3),
(9, 'Cloud Storage', '2023-09-01', '2024-09-01', 'active', 12.50, 4),
(10, 'E-book Subscription', '2023-10-01', '2023-11-30', 'cancelled', 6.99, 5),
(11, 'Language Learning', '2023-11-01', '2024-10-31', 'active', 25.00, 1),
(12, 'Online Gaming', '2023-12-01', '2024-11-30', 'active', 50.00, 2),
(13, 'Video Streaming', '2023-01-15', '2024-01-14', 'inactive', 20.00, 3),
(14, 'Online Courses', '2023-02-15', '2024-02-14', 'cancelled', 30.00, 4),
(15, 'Gym Membership', '2023-03-15', '2024-03-14', 'active', 40.00, 5),
(16, 'Magazine Subscription', '2023-04-15', '2023-09-14', 'cancelled', 15.00, 1),
(17, 'Fitness App', '2023-05-15', '2024-05-14', 'inactive', 20.00, 2),
(18, 'Music Service', '2023-06-15', '2023-12-15', 'cancelled', 10.00, 3),
(19, 'Cloud Storage', '2023-07-15', '2024-07-14', 'active', 5.00, 4),
(20, 'E-book Subscription', '2023-08-15', '2024-08-14', 'pending', 12.00, 5);


CREATE TABLE `Account` (
	`client_id` INT,
    `account_num` int,
    `balance` VARCHAR(30),
    `account_type` VARCHAR(30),
    primary key(client_id,account_type)
);

#SET GLOBAL local_infile = 1;
#load data local infile 'Account.csv' into table `Account` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

INSERT INTO `Account` VALUES(1,1000000000, '$5000.00', 'None');
INSERT INTO `Account` VALUES(2,1000000001, '$5000.00', 'None');
INSERT INTO `Account` VALUES(3,1000000002, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(4,1000000003, '$1000.00', 'None');
INSERT INTO `Account` VALUES(5,1000000004, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(6,1000000005, '$50000.00', 'None');
INSERT INTO `Account` VALUES(7, 1000000006, '$3000.00', 'Premium');
INSERT INTO `Account` VALUES(8,1000000007, '$60000.00', 'None');
INSERT INTO `Account` VALUES(9,1000000008, '$4000.00', 'None');
INSERT INTO `Account` VALUES(10,1000000009, '$2000.00', 'None');


#####################################################BCNF Normalization
drop table if exists `temporary_relation`;
drop table if exists `account_information_table`;
drop table if exists `subscription_information_table`;
drop table if exists `client_information_table`;


#Relation creation
create table `client_information_table`(`client_id` int primary key,
`client_name` varchar(40), 
`credit_score` int default 0
);

insert into `client_information_table`(`client_id`,`client_name`,`credit_score`)
select `client_id`, `client_name`,`credit_score`
from `Client`
where `credit_score` between 0 and 900
;


create table `account_information_table`(
`account_num` int,
`client_id` int,
`balance` varchar(30),
`account_type` enum('None','Unleaded','Premium'),
primary key(account_num),
foreign key(`client_id`) references `client_information_table`(`client_id`)
);

create table `subscription_information_table`(
`subscription_id` int,
`client_id` int,
`service_name` varchar(150),
`subscription_init_date` date,
`subscription_end_date` date,
`subscription_status` enum('active', 'inactive', 'cancelled', 'pending'),
`monthly_fee` DECIMAL(15, 2) DEFAULT 0.00,
primary key(`subscription_id`),
foreign key(`client_id`) references `client_information_table`(`client_id`)
);

#Relation initialization
insert into `account_information_table`(`account_num`,`client_id`,`balance`,`account_type`)
select `account_number`,`client_id`,`balance`,`account_type`
from `Client`;

insert into `subscription_information_table`(`subscription_id`,`client_id`,`service_name`,`subscription_init_date`,`subscription_end_date`,`subscription_status`,`monthly_fee`)
select `subscription_id`,`client_id`,`service_name`,`subscription_init_date`,`subscription_end_date`,`subscription_status`,`monthly_fee`
from `Subscription`;


alter table `subscription_information_table`add column `payment_method` varchar(30), add column `discount_applied` boolean;

create table temporary_relation(`subscription_id` int primary key, `payment_method` varchar(30),`discount_applied` boolean);

insert into `temporary_relation`
values (1, 'Credit card',true),
(2, 'Debit card',false),
(3, 'Debit card',true),
(4, 'Credit card',false),
(5, 'Cash',true),
(6, 'Credit card',false),
(7, 'Others',false),
(8, 'Cash',true),
(9, 'Credit card',true),
(10, 'Cash',true),
(11, 'Credit card',true),
(12, 'Debit card',false),
(13, 'Debit card',false),
(14, 'Credit card',false),
(15, 'Cash',true),
(16, 'Credit card',false),
(17, 'Others',false),
(18, 'Cash',true),
(19, 'Credit card',true),
(20, 'Cash',true);

SET SQL_SAFE_UPDATES = 0;

update `subscription_information_table` join `temporary_relation` on `subscription_information_table`.`subscription_id` = `temporary_relation`.`subscription_id`
set `subscription_information_table`.`payment_method`=`temporary_relation`.`payment_method`;

update `subscription_information_table` join `temporary_relation` on `subscription_information_table`.`subscription_id` = `temporary_relation`.`subscription_id`
set `subscription_information_table`.`discount_applied` = `temporary_relation`.`discount_applied`;

SET SQL_SAFE_UPDATES = 1;

#We want to segregate the clients by the payment_methods

select `payment_method` as `payment_method`, COUNT(*)
from `subscription_information_table`
group by `payment_method` having `payment_method`='Credit card';


#We want to find the client_id which has the most amount of subscription

select `client_id`, min(`monthly_fee`)
from `subscription_information_table`
group by `client_id`;

select `client_id`, `monthly_fee`
from `subscription_information_table`
order by `monthly_fee` desc
limit 1;

select `client_id`,`monthly_fee`
from `subscription_information_table`
group by `client_id`,`monthly_fee` having `monthly_fee`>=20;


select `subscription_status`,sum(`monthly_fee`) as 'sum_of_monthly_fee'
from `subscription_information_table`
group by `subscription_status` having `subscription_status`='active'; 

select `service_name`,avg(`monthly_fee`) as 'average_monthly_fee'
from `subscription_information_table`
group by `service_name`;

select `client_id`, count(*) as '# of active subscriptions'
from `subscription_information_table`
where `subscription_status`='active'
group by `client_id`;

select `client_id`,max(`monthly_fee`) as 'Greatest monthly_fee', min(`monthly_fee`) as 'Smallest monthly_fee'
from `subscription_information_table`
group by `client_id`;

select `client_id` as 'Clients with more than 5 subscriptions'
from `subscription_information_table`
group by `client_id` having count(*)>5;

select `client_id`, sum(`monthly_fee`) as 'Total Monthly Fee'
from `subscription_information_table`
group by `client_id` having count(`monthly_fee`)>1;

select `client_id`, min(`subscription_init_date`) as 'earliest subscription date', max(`subscription_init_date`) as 'latest subscription date'
from `subscription_information_table`
group by `client_id`;

select `service_name`,sum(`monthly_fee`) as 'total fees'
from `subscription_information_table`
group by `service_name`
order by 'total fees' desc
limit 10;

# Problem: Find the highest monthly fee for each client using a subquery.
select `client_id`,`highest subscription cost`
from (select `client_id`,max(`monthly_fee`) as 'highest subscription cost' from `subscription_information_table` group by `client_id`) as `temp1`;

#Problem: Identify clients whose total monthly fees are greater than the average total monthly fees of all clients.
select `client_id` as 'client whose total monthly fees > average'
from (select `client_id` from `subscription_information_table` group by `client_id` having sum(`monthly_fee`)>avg(`monthly_fee`)) as `temp1`;

#Problem: List services subscribed by clients who have total monthly fees greater than $100.

select `service_name`
from `subscription_information_table`
where `client_id` in (
    select `client_id`
    from `subscription_information_table`
    group by `client_id`
    having sum(monthly_fee) > 100
);

#Problem: Calculate the average monthly fee of active subscriptions for each client.
select `client_id`, avg(monthly_fee) as avg_active_fee
from `subscription_information_table`
where `subscription_status` = 'active'
group by`client_id`;


#Bonus: Top 10 Clients with the Highest Balance Who Have Transactions in the Last Month
select c.`client_name` as 'Client Name', a.`balance` as 'Balance'
from `client_information_table` c
join `account_information_table` a ON c.`client_id` = a.`client_id`
where c.`client_id` in (
    select distinct t.`client_id`
    from `transactions` t
    WHERE t.`transaction_date` BETWEEN CURDATE() - INTERVAL 1 MONTH AND CURDATE()
)
ORDER BY a.`balance` DESC
LIMIT 10;



#Bonus: average balance of clients who have more than one account
select avg(`total_balance`) as 'Average Balance'
from (
    select `client_id`, sum(cast(replace(`balance`, '$', '') as decimal(10, 2))) as `total_balance`
    from `account_information_table`
    group by `client_id`
    having count(account_num) > 1
) as `subquery`;



