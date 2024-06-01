
#Table Initialization
drop table if exists Subscription;
create table Subscriptions(
    `subscription_id` INT PRIMARY KEY,
    `client_id` ,  VARCHAR(10) unique,
    `ServiceType` varchar(150), `SubscriptionDate` date,
    `SubScriptionStatus` enum('Active', 'Inactive', 'Cancelled', 'Pending'),
    `MonthlyFee` varchar(8) default '$0.00'
);

load data local infile '/Users/iamvan/Desktop/CSC370/Clients/Subscriptions/client_subscription.csv' into table `Subscriptions` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

select * from `Subscriptions`;

#Display all SubscriptionStatus that are only Active
select * from `Subscriptions` where SubscriptionStatus='Active';



