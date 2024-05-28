DROP USER IF EXISTS 'Hoksolinvan_Chhun'@'%';
DROP USER IF EXISTS 'Shabab_Ali'@'%';
DROP USER IF EXISTS 'Samuel_Cheng'@'%';

CREATE USER 'Hoksolinvan_Chhun'@'%' IDENTIFIED BY 'Hoksolinvan_Chhun';
CREATE USER 'Shabab_Ali'@'%' IDENTIFIED BY 'Shabab_Ali';
CREATE USER 'Samuel_Cheng'@'%' IDENTIFIED BY 'Samuel_Cheng';

GRANT ALL PRIVILEGES ON bank_database.* TO 'Hoksolinvan_Chhun'@'%';
GRANT ALL PRIVILEGES ON bank_database.* TO 'Shabab_Ali'@'%';
GRANT ALL PRIVILEGES ON bank_database.* TO 'Samuel_Cheng'@'%';

FLUSH PRIVILEGES;