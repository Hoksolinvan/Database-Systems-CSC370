USE bank_database;

DROP TABLE IF EXISTS `Employee`;

CREATE TABLE `Employee` (
	 `Employee_ID` int
     ,`Age` int
     ,`Name` varchar(64)
     ,`Position` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'Employee_Data.csv'
INTO TABLE Employee 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;