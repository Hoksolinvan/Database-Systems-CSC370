DROP TABLE IF EXISTS `Employee`;

CREATE TABLE `Employee` (
	`Employee_ID` int
	,`Name` varchar(64)
	, `Age` int
	,`Title` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
);

LOAD DATA LOCAL INFILE 'EmployeeData.csv'
INTO `Employee` FIELDS TERMINATED BY ','
FIELD ENCLOSED BY '\r\n' IGNORE 1 LINES;
