DROP TABLE IF EXISTS `Employees`;

CREATE TABLE `Employees` (
	 `Employee_ID` int
    ,`Name` varchar(64)
    ,`Position` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
);

LOAD DATA LOCAL INFILE 'Employee_Data.csv'
INTO `Employees` FIELDS TERMINATED BY ','
FIELD ENCLOSED BY '\r\n' IGNORE 1 LINES;