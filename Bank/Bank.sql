# Adam Zheng

# Create Table
use bank_database;
drop table if exists `Bank`;
create table `Bank` (
	`branch_num` int
	,`location` varchar(64)
);
alter table `Bank`
add primary key (`branch_num`);


# Load Data Into Table (Might need to change path)
set global local_infile = 1;
load data local INFILE 'C:\\Users\\adamz\\OneDrive\\Documents\\UVic\\CSC 370\\Database Project\\Bank\\Bank_Data.csv'
into table `Bank` 
fields terminated by ',' 
optionally enclosed by '"' 
lines terminated by '\r\n'
ignore 1 lines;


# Queries
select * from `Bank`;

# Get Num Employees for each brach 
select count(*) as `num_employee`
from `employee`;
