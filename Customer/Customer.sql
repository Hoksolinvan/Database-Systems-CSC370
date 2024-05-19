
#Table Creation
create table `customers`(`CustomerID` int primary key, `AccountNumber` int, `CustomerName` varchar(40), `CheckingBalance` varchar(40) default '$0', `SavingBalance` varchar(40) default '$0', `CreditCardType` enum('None','Unleaded','Premium'), `CreditScore` int default 0);

#Loading file
load data local infile '/Users/iamvan/Desktop/CSC370/Customer/customer.csv' into table `customers` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;


#displaying table
select * from `customers`;


#Query for Customer1. They only want to see their Account Number, checking balance and saving balance
select `AccountNumber`,`CheckingBalance`,`SavingBalance` from `customers` where `CustomerName`='Customer 1';