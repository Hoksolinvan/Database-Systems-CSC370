
#Table Creation
create table `customers`(`CustomerID` int primary key, `AccountNumber` int, `CustomerName` varchar(40), `CheckingBalance` varchar(40) default '$0', `SavingBalance` varchar(40) default '$0', `CreditCardType` enum('None','Unleaded','Premium'), `CreditScore` int default 0);

#Loading file
load data local infile '/Users/iamvan/Desktop/CSC370/Customer/customer.csv' into table `customers` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;


#displaying table
select * from `customers`;

#The manager wants to see the table sorted in descending according to the customer ID and he wants us to change "CustomerID" attribute name to "ID" instead
select * from `customers` order by `CustomerID` desc;

#The manager is looking for a customer with the highest amount of savings to give them a special offer
select * from `customers` order by `SavingBalance` desc LIMIT 1;


#Query for Customer1. They only want to see their Account Number, checking balance and saving balance
select `AccountNumber`,`CheckingBalance`,`SavingBalance` from `customers` where `CustomerName`='Customer 1';

#Customer1 didn't liked that his name was "Customer1" therefore he threatened to speak to our manager if we didn't change his name to his real name
update `customers`
set CustomerName='poopy'
where CustomerID='1';

select * from `customers` where `CustomerID`=1;




