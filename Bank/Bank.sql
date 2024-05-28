DROP TABLE IF EXISTS `Bank`;

CREATE TABLE `Bank` (
	`Branch_Num` int
	,`Location` varchar(64)
	,`Num_Employees` int
	,`Num_Clients` int
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'Bank_Data.csv'
INTO TABLE Bank 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
