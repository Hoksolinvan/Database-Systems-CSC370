USE bank_database;
DROP TABLE IF EXISTS `Account`;

CREATE TABLE `Account` (
    `account_num` INT,
    `balance` VARCHAR(30),
    `account_type` VARCHAR(30),
    primary key(account_num)
);

#SET GLOBAL local_infile = 1;
#load data local infile 'Account.csv' into table `Account` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

INSERT INTO `Account` VALUES(1000000000, '$5000.00', 'None');
INSERT INTO `Account` VALUES(1000000001, '$5000.00', 'None');
INSERT INTO `Account` VALUES(1000000002, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(1000000003, '$1000.00', 'None');
INSERT INTO `Account` VALUES(1000000004, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(1000000005, '$50000.00', 'None');
INSERT INTO `Account` VALUES(1000000006, '$3000.00', 'Premium');
INSERT INTO `Account` VALUES(1000000007, '$60000.00', 'None');
INSERT INTO `Account` VALUES(1000000008, '$4000.00', 'None');
INSERT INTO `Account` VALUES(1000000009, '$2000.00', 'None');

SELECT * from Account;
SELECT ' ';

SELECT * from Account where account_num = 1000000000;
SELECT ' ';

SELECT * from Account where account_num > 1000000000;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by account_num;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by balance;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by balance;
SELECT ' ';

update  `Account` set balance = "$1000.00" where account_num >= 1000000005;
SELECT * from Account;
SELECT ' ';

update  `Account` set balance = "$2000.00" where account_num = 1000000000;
SELECT * from Account;
SELECT ' ';

update  `Account` set balance = "$5000.00" where account_type = 'Premium';
SELECT * from Account;
SELECT ' ';
Collapse
Account.sql
2 KB
Attachment file type: spreadsheet
Account.xlsx
10.17 KB
Here's my code. Please tell me when when you've got it in submitted or if I need to change anything.
Adam Zheng — Today at 5:40 PM
@Shabab Ali (combined, v4)  can you add the account files, I don't wanna mess up the repo either lol
Shabab Ali (combined, v4) — Today at 5:43 PM
yup, will do, just give me a sec
﻿
DROP TABLE IF EXISTS `Account`;

CREATE TABLE `Account` (
    `account_num` INT,
    `balance` VARCHAR(30),
    `account_type` VARCHAR(30),
    primary key(account_num)
);

#SET GLOBAL local_infile = 1;
#load data local infile 'Account.csv' into table `Account` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

INSERT INTO `Account` VALUES(1000000000, '$5000.00', 'None');
INSERT INTO `Account` VALUES(1000000001, '$5000.00', 'None');
INSERT INTO `Account` VALUES(1000000002, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(1000000003, '$1000.00', 'None');
INSERT INTO `Account` VALUES(1000000004, '$2000.00', 'Unleaded');
INSERT INTO `Account` VALUES(1000000005, '$50000.00', 'None');
INSERT INTO `Account` VALUES(1000000006, '$3000.00', 'Premium');
INSERT INTO `Account` VALUES(1000000007, '$60000.00', 'None');
INSERT INTO `Account` VALUES(1000000008, '$4000.00', 'None');
INSERT INTO `Account` VALUES(1000000009, '$2000.00', 'None');

SELECT * from Account;
SELECT ' ';

SELECT * from Account where account_num = 1000000000;
SELECT ' ';

SELECT * from Account where account_num > 1000000000;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by account_num;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by balance;
SELECT ' ';

SELECT * from Account where account_num >= 1000000005 order by balance;
SELECT ' ';

update  `Account` set balance = "$1000.00" where account_num >= 1000000005;
SELECT * from Account;
SELECT ' ';

update  `Account` set balance = "$2000.00" where account_num = 1000000000;
SELECT * from Account;
SELECT ' ';

update  `Account` set balance = "$5000.00" where account_type = 'Premium';
SELECT * from Account;
