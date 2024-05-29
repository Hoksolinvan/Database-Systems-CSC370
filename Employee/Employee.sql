# Adam Zheng

# Create Table
USE bank_database;
DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
	`Employee_ID` int
	,`Age` int
	,`Name` varchar(64)
	,`Title` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
	,`Is_Admin` bool
);
ALTER TABLE `Employee`
ADD PRIMARY KEY (`Employee_ID`);

# Load Data Into Table (Might need to change path)
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:\\Users\\adamz\\OneDrive\\Documents\\UVic\\CSC 370\\Database Project\\Employee\\Employee_Data.csv'
INTO TABLE Employee 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# Queries
SELECT * FROM `Employee`;