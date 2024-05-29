# Adam Zheng

# Create Table
DROP TABLE IF EXISTS `Bank`;
CREATE TABLE `Bank` (
	`Branch_Num` int
	,`Location` varchar(64)
	,`Num_Employees` int
	,`Num_Clients` int
);
ALTER TABLE `Bank`
ADD PRIMARY KEY (`Branch_Num`);

# Load Data Into Table (Might need to change path)
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:\\Users\\adamz\\OneDrive\\Documents\\UVic\\CSC 370\\Database Project\\Bank\\Bank_Data.csv'
INTO TABLE Bank 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# Queries
SELECT * FROM `Bank`;