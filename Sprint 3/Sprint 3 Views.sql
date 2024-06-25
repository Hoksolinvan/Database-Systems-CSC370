drop user if exists 'Bank_Sinatra'@'%';
drop user if exists 'Purple_Bank'@'%';
drop user if exists 'Less_Money'@'%';
drop user if exists 'Money_Man'@'%';
drop user if exists 'Money_Man_Three'@'%';

# Bank Sinatra has just been hired as the Branch Manager for Branch 1005151
# DB Admin grants them privileges to all with grant option
create user 'Bank_Sinatra'@'%' identified by 'Bank Sinatra';
grant all privileges on bank_database.* to 'Bank Sinatra' with grant option;

# Purple Bank is hired as the Customer Service Rep and will need select privilages on client side tables
# DB ADmin grants them without grant option
create user 'Purple_Bank'@'%' identified by 'Purple Bank';
create view `Client_Side_Tables` as select * from `Client`
left join `Account` on `Client`.`client_id` = `Account`.`client_id`
left join `Subscription` on `Client`.`client_id` = `Subscription`.`client_id`;
grant select on `Client_Side_Tables` to 'Purple Bank';

# Less Money is a Personal Banker and needs to be able to select, insert, and delete from their client's accounts
# Bank Sinatra grants them
create user 'Less_Money'@'%' identified by 'Less Money';
create view `Less_Money_Client_Accounts` as select * from `Account`
where `client_id` in (2, 4, 6, 8, 10);
grant all on `Less_Money_Client_Accounts` to 'Less Money';

# Money Man has just been hired as the Branch Manager for Branch 2117272
# Both the DB admin and Bank Sinatra grant them all privileges on the database with grant option
create user 'Money_Man'@'%' identified by 'Money Man';
grant all privileges on bank_database.* to 'Money Man' with grant option;

# Money Man Three has just been hired as the Hiring Manager for Branch 2117272
# They only need select and insert privileges on the employees of Branch 2117272
# Money Man grants them  
create user 'Money_Man_Three'@'%' identified by 'Money Man Three';
create view `Employee_2117272` as select * from `Employee`
where `branch_num` = 2117272;
grant select, insert on `Employee_2117272` to 'Money Man Three';

# Branch 2117272 is not making any Money and will thus be terminated
# Admin revokes all database privileges from Money Man (pretend it is cascade, idk why the keyword doesn't work here)
# Admin is mad that Bank Sinatra also granted Money Man those privileges and forces them to also revoke from Money Man (pretend both ran line 43)
revoke all privileges , grant option from 'Money Man';

FLUSH PRIVILEGES;