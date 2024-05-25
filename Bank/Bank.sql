DROP TABLE IF EXISTS `Bank`;

CREATE TABLE `Bank` (
	`Branch_Num` int
	,`Location` varchar(64)
	,`Num_Employees` int
	,`Num_Clients` int
);

LOAD DATA LOCAL INFILE 'BankData.csv'
INTO `Bank` FIELDS TERMINATED BY ','
FIELD ENCLOSED BY '\r\n' IGNORE 1 LINES;
