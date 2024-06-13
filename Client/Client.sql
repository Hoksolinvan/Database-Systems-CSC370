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
DROP TABLE IF EXISTS `Subscription`,
					`Account`,
					`Client`,
                    `temporary_relation`,
                    `temporary_relation2`;
                    

                    
                  


#####################################################BCNF Normalization

#Normalizing `Client`
create table `Client`(`client_id` int primary key,
`client_name` varchar(40), 
`credit_score` int default 0
);

#Loading data in `Client`
SET GLOBAL local_infile = 1;
load data local infile '/Users/iamvan/Desktop/CSC370/Client/Client_Data.csv' into table `Client` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

#Adding additional attributes to Subscription and Client to increase complexity of tables
alter table `Subscription`add column `payment_method` varchar(30), add column `discount_applied` boolean;
alter table `Client` add column `employment_status` enum('employed','unemployed','Other') default 'Other', add column `Married` boolean default 0;

#Creating temporary relation to aid in adding the new attributes to `Subscription`
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


create table `temporary_relation2`(`client_id` int primary key, `employment_status` enum('employed','unemployed','Other') default 'Other', `Married` boolean default 0);
insert into `temporary_relation2` (`client_id`, `employment_status`, `Married`)
values 
(3, 'unemployed', 0),
(4, 'employed', 1),
(5, 'unemployed', 1),
(6, 'Other', 0),
(7, 'employed', 0),
(8, 'employed', 1),
(9, 'unemployed', 0),
(10, 'Other', 1),
(11, 'employed', 1),
(12, 'employed', 0),
(13, 'unemployed', 1),
(14, 'Other', 0),
(15, 'employed', 1),
(16, 'unemployed', 0),
(17, 'employed', 1),
(18, 'Other', 1),
(19, 'unemployed', 0),
(20, 'employed', 1);

SET SQL_SAFE_UPDATES = 0;

update `Subscription` join `temporary_relation` on `Subscription`.`subscription_id` = `temporary_relation`.`subscription_id`
set `Subscription`.`payment_method`=`temporary_relation`.`payment_method`;

update `Subscription` join `temporary_relation` on `Subscription`.`subscription_id` = `temporary_relation`.`subscription_id`
set `Subscription`.`discount_applied` = `temporary_relation`.`discount_applied`;


update `Client` c join `temporary_relation2` temp on c.`client_id`=temp.`client_id`
set c.`employment_status`=temp.`employment_status`,
c.`Married`=temp.`Married`;

SET SQL_SAFE_UPDATES = 1;
############################







#Complex SQLs

#We want to segregate the clients by the payment_methods

select `payment_method` as `payment_method`, COUNT(*)
from `Subscription`
group by `payment_method` having `payment_method`='Credit card';


#We want to find the client_id which has the most amount of subscription

select `client_id`, min(`monthly_fee`)
from `Subscription`
group by `client_id`;

select `client_id`, `monthly_fee`
from `Subscription`
order by `monthly_fee` desc
limit 1;

select `client_id`,`monthly_fee`
from `Subscription`
group by `client_id`,`monthly_fee` having `monthly_fee`>=20;


select `subscription_status`,sum(`monthly_fee`) as 'sum_of_monthly_fee'
from `Subscription`
group by `subscription_status` having `subscription_status`='active'; 

select `service_name`,avg(`monthly_fee`) as 'average_monthly_fee'
from `Subscription`
group by `service_name`;

select `client_id`, count(*) as '# of active subscriptions'
from `Subscription`
where `subscription_status`='active'
group by `client_id`;

select `client_id`,max(`monthly_fee`) as 'Greatest monthly_fee', min(`monthly_fee`) as 'Smallest monthly_fee'
from `Subscription`
group by `client_id`;

select `client_id` as 'Clients with more than 5 subscriptions'
from `Subscription`
group by `client_id` having count(*)>5;

select `client_id`, sum(`monthly_fee`) as 'Total Monthly Fee'
from `Subscription`
group by `client_id` having count(`monthly_fee`)>1;

select `client_id`, min(`subscription_init_date`) as 'earliest subscription date', max(`subscription_init_date`) as 'latest subscription date'
from `Subscription`
group by `client_id`;

select `service_name`,sum(`monthly_fee`) as 'total fees'
from `Subscription`
group by `service_name`
order by 'total fees' desc
limit 10;

# Problem: Find the highest monthly fee for each client using a subquery.
select `client_id`,`highest subscription cost`
from (select `client_id`,max(`monthly_fee`) as 'highest subscription cost' from `Subscription` group by `client_id`) as `temp1`;

#Problem: Identify clients whose total monthly fees are greater than the average total monthly fees of all clients.
select `client_id` as 'client whose total monthly fees > average'
from (select `client_id` from `Subscription` group by `client_id` having sum(`monthly_fee`)>avg(`monthly_fee`)) as `temp1`;

#Problem: List services subscribed by clients who have total monthly fees greater than $100.

select `service_name`
from `Subscription`
where `client_id` in (
    select `client_id`
    from `Subscription`
    group by `client_id`
    having sum(monthly_fee) > 100
);

#Problem: Calculate the average monthly fee of active subscriptions for each client.
select `client_id`, avg(monthly_fee) as avg_active_fee
from `Subscription`
where `subscription_status` = 'active'
group by`client_id`;


#Bonus: Top 10 Clients with the Highest Balance Who Have Transactions in the Last Month
select c.`client_name` as 'Client Name', a.`balance` as 'Balance'
from `Client` c
join `Account` a ON c.`client_id` = a.`client_id`
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
    from `Account`
    group by `client_id`
    having count(account_num) > 1
) as `subquery`;



