USE bank_database;
DROP TABLE IF EXISTS `Account`;

CREATE TABLE `Account` (
    `account_num` INT,
    `balance` VARCHAR(30),
    `account_type` VARCHAR(30),
    `client_id` int,    
    # Make sure you run the code in Client.sql to create that table first so you don't get f-key integrity error
    foreign key(`client_id`) references `Client`(`client_id`),
    primary key(account_num)
);

#SET GLOBAL local_infile = 1;
#load data local infile 'Account.csv' into table `Account` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

INSERT INTO `Account` VALUES(1000000000, '$5000.00', 'None', 1);
INSERT INTO `Account` VALUES(1000000001, '$5000.00', 'None', 3);
INSERT INTO `Account` VALUES(1000000002, '$2000.00', 'Unleaded', 3);
INSERT INTO `Account` VALUES(1000000003, '$1000.00', 'None', 32);
INSERT INTO `Account` VALUES(1000000004, '$2000.00', 'Unleaded', 21);
INSERT INTO `Account` VALUES(1000000005, '$50000.00', 'None', 15);
INSERT INTO `Account` VALUES(1000000006, '$3000.00', 'Premium', 10);
INSERT INTO `Account` VALUES(1000000007, '$60000.00', 'None', 5);
INSERT INTO `Account` VALUES(1000000008, '$4000.00', 'None', 6);
INSERT INTO `Account` VALUES(1000000009, '$2000.00', 'None', 8);
INSERT INTO `Account` VALUES(1000000010,'$3000.00','None',3);
INSERT INTO `Account` VALUES(1000000011,'$4000.00','None',1);
INSERT INTO `Account` VALUES(1000000012, '$5000.00','None',8);
INSERT INTO `Account` VALUES(1000000013, '$25000.00','None',15);
INSERT INTO `Account` VALUES(1000000014, '$14000.00','None',6);
INSERT INTO `Account` VALUES(1000000015, '$5000.00','None',2);
INSERT INTO `Account` VALUES(1000000016, '$25000.00','None',4);
INSERT INTO `Account` VALUES(1000000017, '$14000.00','None',5);
INSERT INTO `Account` VALUES(1000000018, '$10000.00','None',4);

select * from `Account`;
SELECT ' ';

select distinct `account_type` from `Account`;
SELECT ' ';

select `account_num` from `Account` group by `account_type`;
SELECT ' ';

select `account_num`, `account_type` from `Account`;
SELECT ' ';

select * from `Account` group by `account_type`;
SELECT ' ';

select min(`balance`) from `Account`;
SELECT ' ';

select count(*) from `Account`;
SELECT ' ';

select count(`balance`) from `Account` group by `account_type`;
SELECT ' ';

select count(*) from `Account` where account_num >= 1000000005;
SELECT ' ';

select * from `Account` where account_num >= 1000000005 order by `balance` asc limit 3;
SELECT ' ';

select count(*) from `Account` where `balance` = '$5000.00';
SELECT ' ';

select `account_num`, max(`balance`), `account_type` from `Accounts`;
SELECT ' ';

select * from `Account` where `account_num` in 
(
    select `account_num` from `Account` 
    where `balance` >= "$5000.00"
);
SELECT ' ';

select * from `Account` where `account_num` not in 
(
    select `account_num` from `Account` 
    where `balance` >= "$5000.00"
);
SELECT ' ';

select max(`balance`) from `Account` where `account_num` in
(
    select `account_num` from `Account`
    where `account_num` <= 1000000006
);
SELECT ' ';

select count(*) from `Account` where `balance` >= '$5000.00' and `account_num` in
(
    select `account_num` from `Account`
    where `account_num` >= 1000000005
);
SELECT ' ';
