# Adam Zheng

# Create Table
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

# Update num_employee and num_client (TODO Sprint 2)
# add a time hired and fired table that is join of Bank and Employee