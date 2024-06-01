
#Table Initialization
DROP TABLE IF EXISTS `Subscription`;
CREATE TABLE `Subscription`(
    `subscription_id` INT PRIMARY KEY,
    `service_name` VARCHAR(150),
    `subscription_init_date` DATE,
    `subscription_end_date` DATE,
    `subscription_status` enum('active', 'inactive', 'cancelled', 'pending'),
    `monthly_fee` DECIMAL(15, 2) DEFAULT 0.00,
    `client_id` INT,
    FOREIGN KEY (client_id) REFERENCES Client(Client_ID)
);



-- Inserting mock values into the Clients table
# INSERT INTO `Clients` (`Client_ID`, `AccountNumber`, `ClientName`, `Balance`, `AccountType`, `CreditScore`)
# VALUES
# (1, 123456, 'John Doe', '$1000', 'Unleaded', 750),
# (2, 234567, 'Jane Smith', '$500', 'Premium', 680),
# (3, 345678, 'Alice Johnson', '$0', 'None', 600),
# (4, 456789, 'Bob Brown', '$250', 'Unleaded', 700),
# (5, 567890, 'Charlie Davis', '$1500', 'Premium', 800);


INSERT INTO `Subscription` (`subscription_id`, `service_name`, `subscription_init_date`, `subscription_end_date`, `subscription_status`, `monthly_fee`, `client_id`)
VALUES
(1, 'Streaming Service', '2023-01-01', '2024-12-31', 'active', 9.99, 1),
(2, 'Gym Membership', '2023-02-01', '2024-11-30', 'active', 29.99, 2),
(3, 'Newsletter Subscription', '2023-03-01', '2024-06-01', 'pending', 5.00, 3),
(4, 'Premium Support', '2023-04-01', '2023-05-31', 'cancelled', 49.99, 4),
(5, 'Online Courses', '2023-05-01', '2024-10-31', 'inactive', 19.99, 5),
(6, 'Magazine Subscription', '2023-06-01', '2023-12-31', 'cancelled', 10.00, 1),
(7, 'Fitness App', '2023-07-01', '2024-06-30', 'active', 15.00, 2),
(8, 'Music Service', '2023-08-01', '2023-12-31', 'cancelled', 8.99, 3),
(9, 'Cloud Storage', '2023-09-01', '2024-09-01', 'active', 12.50, 4),
(10, 'E-book Subscription', '2023-10-01', '2023-11-30', 'cancelled', 6.99, 5),
(11, 'Language Learning', '2023-11-01', '2024-10-31', 'active', 25.00, 1),
(12, 'Online Gaming', '2023-12-01', '2024-11-30', 'active', 50.00, 2),
(13, 'Video Streaming', '2023-01-15', '2024-01-14', 'inactive', 20.00, 3),
(14, 'Online Courses', '2023-02-15', '2024-02-14', 'cancelled', 30.00, 4),
(15, 'Gym Membership', '2023-03-15', '2024-03-14', 'active', 40.00, 5),
(16, 'Magazine Subscription', '2023-04-15', '2023-09-14', 'cancelled', 15.00, 1),
(17, 'Fitness App', '2023-05-15', '2024-05-14', 'inactive', 20.00, 2),
(18, 'Music Service', '2023-06-15', '2023-12-15', 'cancelled', 10.00, 3),
(19, 'Cloud Storage', '2023-07-15', '2024-07-14', 'active', 5.00, 4),
(20, 'E-book Subscription', '2023-08-15', '2024-08-14', 'pending', 12.00, 5);


# TODO: correct this when we sort out a data load and store mechanism
# load data local infile '../Subscription/client_subscription.csv' into table `Subscriptions` fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines;

# fetch first 5 table rows
SELECT * FROM `Subscription` LIMIT 5;

# display all Subscription Status that are only 'Active'
SELECT * FROM `Subscription` WHERE subscription_status='active';

# display the 5 most expensive subscriptions
SELECT * FROM `Subscription`
ORDER BY monthly_fee DESC
LIMIT 5;

# display all active subscriptions with a price > than 10 dollars
SELECT * FROM `Subscription`
WHERE subscription_status='active' AND monthly_fee > 10.00;

# display any pending subscriptions, initiated before the current date
SELECT * FROM `Subscription`
WHERE subscription_status='active' AND subscription_init_date < CURDATE();

# display any subscriptions, which have been cancelled within the last year year
SELECT * FROM `Subscription`
WHERE subscription_status = 'cancelled' AND subscription_end_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
