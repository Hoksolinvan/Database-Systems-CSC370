# Adam Zheng

# Create Table
use bank_database;
drop table if exists `Employee`;
create table `Employee` (
	`employee_id` int
	,`age` int
	,`name` varchar(64)
	,`title` enum('Branch Manager', 'Assistant Branch Manager', 'Teller', 'Personal Banker', 'Loan Officer', 'Customer Service Representative', 'Financial Advisor')
    ,`branch_num` int
    ,`hire_date` date
    ,primary key (`employee_id`)
    ,foreign key (`branch_num`) references `Bank`(`branch_num`)
    ,foreign key (`title`) references `Position`(`title`)
);

# Load Data Into Table (Might need to change path)
set global local_infile = 1;
load data local infile 'C:\\Users\\adamz\\OneDrive\\Documents\\UVic\\CSC 370\\Database Project\\Employee\\Employee_Data.csv'
into table Employee 
fields terminated by ',' 
optionally enclosed by '"' 
lines terminated by '\r\n'
ignore 1 lines;

# Queries
# Select entire table
select * from `Employee`;

# Hire new employee
insert into `Employee` (`employee_id`, `age`, `name`, `title`, `branch_num`, `hire_date`)
values (16, 38, 'Sam Bankman-fried', 'Teller', 1005151, current_date);
select * from `Employee`;

# Change employee's title
update `Employee` 
set `title` = 'Financial Advisor'
where `employee_id` = 16;
select * from `Employee` where `employee_id` = 16;

# Display name, employee_id, by hire order (earliest first)
select `name`, `employee_id`, `hire_date`
from `Employee`
order by `hire_date`;

# Display name and branch location using join
select `name`, `location`
from `Employee` join `Bank` on `Employee`.`branch_num` = `Bank`.`branch_num`;

# Display possible titles, is_admin, and how many currently hold that title
select `Employee`.`title`, `clearance_level`, count(*) as `num_employees_holding_title`
from `Employee` join `Position` on `Employee`.`title` = `Position`.`title`
group by `Employee`.`title`, `clearance_level`;

