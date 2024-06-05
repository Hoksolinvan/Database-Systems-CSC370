# Adam Zheng

# Create Table
use bank_database;
drop table if exists `Bank`;
create table `Bank` (
	`branch_num` int
	,`location` varchar(64)
	,`num_employees` int
	,`num_clients` int
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

# Update num_employee with subquery 
#(will need to comment out all the create table and load data lines before uncommenting and running this)
/*
set SQL_SAFE_UPDATES = 0;
update `Bank` 
set `num_employees` = (
	select count(*)
    from `Employee`
    where `branch_num` = 1005151
    );
set SQL_SAFE_UPDATES = 1;
select * from `Bank`;
*/
