# Adam Zheng

# Create Table
use bank_database;
drop table if exists `Position`;
create table `Position` (
	`title` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
	,`clearance_level` int
    ,primary key (`title`)
);

# Load Data Into Table (Might need to change path)
set global local_infile = 1;
load data local infile 'C:\\Users\\adamz\\OneDrive\\Documents\\UVic\\CSC 370\\Database Project\\Employee\\Position_Data.csv'
into table Position 
fields terminated by ',' 
optionally enclosed by '"' 
lines terminated by '\r\n'
ignore 1 lines;

# Queries
# Select entire table
select * from `Position`;