-- ===============================================================================
-- DAY 19 SQL : SET OPERATIONS 
-- =============================================================================== 

/*
SET OPERATIONS:
  - Set operations are used to retrieve and combine data from two or more queries/tables.

RULES:
  - All SELECT statements must return the same number of columns
  - The order of columns must match
  - The datatype of columns should be compatible

TYPES:
  - UNION:
        Combine records from two or more queries
        Removes duplicate records (DISTINCT behavior)

  - UNION ALL:
        Combine records from two or more queries
        Keeps duplicate records
        Faster than UNION because it does not check duplicates

  - INTERSECT:
        Returns only the common records from both queries
        Duplicate rows are removed

  - EXCEPT (A - B):
        Returns records present in A but not in B
*/

 /*
ASSUME:
You manage an Ecommerce platform

TABLES:
    - purchases
    - newsletter_subscriptions
    - returns
*/

USE retail_db;
DROP TABLE IF EXISTS purchases, newsletter_subscriptions, returns;

-- =============================================================================== 
-- CREATE purchases TABLE
-- =============================================================================== 
CREATE TABLE purchases (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
purchase_date DATE
);

INSERT INTO purchases VALUES
(101,'Aarav','Sharma','aarav.sharma@example.com','2026-01-05'),
(102,'Vihaan','Singh','vihaan.singh@example.com','2026-01-25'),
(103,'Aditi','Mehta','aditi.mehta@example.com','2026-02-15'),
(104,'Rohan','Kumar','rohan.kumar@example.com','2026-02-12'),
(105,'Isha','Patel','isha.patel@example.com','2026-02-18'),
(106,'Kavya','Verma','kavya.verma@example.com','2026-01-28'),
(107,'Arjun','Reddy','arjun.reddy@example.com','2026-02-09'),
(108,'Anaya','Nair','anaya.nair@example.com','2026-03-02'),
(109,'Saanvi','Gupta','saanvi.gupta@example.com','2026-03-10'),
(110,'Kabir','Agarwal','kabir.agarwal@example.com','2026-03-05'),
(111,'Neha','Saxena','neha.saxena@example.com','2026-01-24'),
(112,'Tanishq','Rana','tanishq.rana@example.com','2026-02-10'),
(113,'Mira','Bhatt','mira.bhatt@example.com','2026-03-01'),
(114,'Dev','Kapoor','dev.kapoor@example.com','2026-02-25'),
(115,'Riya','Joshi','riya.joshi@example.com','2026-03-03');

-- =============================================================================== 
-- CREATE newsletter_subscriptions TABLE
-- =============================================================================== 
CREATE TABLE newsletter_subscriptions (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
subscription_date DATE
);

INSERT INTO newsletter_subscriptions VALUES
(101,'Aarav','Sharma','aarav.sharma@example.com','2026-01-01'),
(109,'Saanvi','Gupta','saanvi.gupta@example.com','2026-01-05'),
(116,'Lakshay','Malhotra','lakshay.malhotra@example.com','2026-01-10'),
(112,'Tanishq','Rana','tanishq.rana@example.com','2026-02-03'),
(117,'Sneha','Chawla','sneha.chawla@example.com','2026-02-15'),
(113,'Mira','Bhatt','mira.bhatt@example.com','2026-01-30'),
(118,'Rahul','Pillai','rahul.pillai@example.com','2026-02-06'),
(105,'Isha','Patel','isha.patel@example.com','2026-02-18'),
(106,'Kavya','Verma','kavya.verma@example.com','2026-02-20'),
(115,'Riya','Joshi','riya.joshi@example.com','2026-03-01'),
(119,'Nikhil','Chandra','nikhil.chandra@example.com','2026-02-08'),
(107,'Arjun','Reddy','arjun.reddy@example.com','2026-03-10'),
(108,'Anaya','Nair','anaya.nair@example.com','2026-03-13'),
(114,'Dev','Kapoor','dev.kapoor@example.com','2026-03-14'),
(104,'Rohan','Kumar','rohan.kumar@example.com','2026-02-11');

-- =============================================================================== 
-- CREATE returns TABLE
-- =============================================================================== 
CREATE TABLE returns (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
return_date DATE
); 

INSERT INTO returns VALUES
(103,'Aditi','Mehta','aditi.mehta@example.com','2026-02-17'),
(102,'Vihaan','Singh','vihaan.singh@example.com','2026-02-14'),
(104,'Rohan','Kumar','rohan.kumar@example.com','2026-02-19'),
(110,'Kabir','Agarwal','kabir.agarwal@example.com','2026-01-08'),
(105,'Isha','Patel','isha.patel@example.com','2026-03-01'),
(107,'Arjun','Reddy','arjun.reddy@example.com','2026-02-10'),
(111,'Neha','Saxena','neha.saxena@example.com','2026-01-16'),
(116,'Lakshay','Malhotra','lakshay.malhotra@example.com','2026-01-12'),
(117,'Sneha','Chawla','sneha.chawla@example.com','2026-03-02'),
(112,'Tanishq','Rana','tanishq.rana@example.com','2026-02-07'),
(108,'Anaya','Nair','anaya.nair@example.com','2026-01-09'),
(114,'Dev','Kapoor','dev.kapoor@example.com','2026-02-11'),
(109,'Saanvi','Gupta','saanvi.gupta@example.com','2026-02-12'),
(113,'Mira','Bhatt','mira.bhatt@example.com','2026-03-05'),
(101,'Aarav','Sharma','aarav.sharma@example.com','2026-03-08');

-- ===============================================================================
SELECT * FROM purchases;
SELECT * FROM newsletter_subscriptions;
SELECT * FROM returns;

-- ===============================================================================
-- UNION
-- combine records from multiple tables
-- duplicates are removed automatically
-- ===============================================================================
SELECT * FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

UNION

SELECT * FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

UNION

SELECT * FROM returns
WHERE return_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- ===============================================================================
-- UNION ALL
-- same as UNION but keeps duplicates
-- ===============================================================================
SELECT * FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

UNION ALL

SELECT * FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

UNION ALL

SELECT * FROM returns
WHERE return_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- ===============================================================================
-- UNION
-- ==========
-- 30 RECORDS
-- UNION
-- 20 RECORDS

-- ATLEAST 30
-- MAX 50 

-- UNION ALL
-- ==========
-- 30 RECORDS
-- UNION
-- 20 RECORDS

-- TOTAL 50 RECORDS BECOUSE INCLUDE DUPLICATE
-- ===============================================================================

-- ===============================================================================
-- INTERSECT
-- return only common records between queries
-- ===============================================================================
SELECT * FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

INTERSECT

SELECT * FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- NOTE:
-- INTERSECT and EXCEPT are supported in MySQL 8.0.31+.
-- Older MySQL versions do not support them.

SELECT VERSION();

-- ===============================================================================
-- EXCEPT (A - B)
-- return records present in A but not in B
-- ===============================================================================
SELECT * FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)

EXCEPT

SELECT * FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- ===============================================================================
-- SCANRIO:
-- 3 TABLES - INDIA_EMPLOYEES, US-EMPLOYEES, CANADA_EMPLOYEE
-- YOU WANT TO ANALYZE THIS DATA TOGETHER
-- WHAT YOU WILL USE UNION OR UNION ALL?

-- UNION REMOVE DUPLICATES MEANS MORE HARDWORK
-- SO IF YOU ARE SURE THAT IN THOSE TABLE WE CAN NOT HAVE DUPLICATE SO USE UNION ALL
/*
SELECT INDIA_EMPLOYEES
UNION ALL
SELECT EMPLOYEES
UNION ALL
CANADA_EMPLOYEE; */ -- THIS WILL BE OPTIMIZED THAN UNION NO DUPLICATE CHECK
-- ===============================================================================

-- ===============================================================================
-- THIS WILL NOT WORK BECOUSE NUMBER OF COLUMNS ARE NOT SAME 
-- ===============================================================================
SELECT 101,'MAZHAR',2006-09-28
UNION ALL
SELECT 101,2006-09-28;

-- IT DID INTERNALLY TYPECASTING 
SELECT 101,'MAZHAR',100000
UNION ALL
SELECT 101,'MAZHAR',1000.0;

-- BOTH RECORDS ARE DIFFERENT 
SELECT 101,'IT', 'MAZHAR'
UNION 
SELECT 101,'MAZHAR', 'CSE';

-- ===============================================================================
CREATE TABLE orders (
order_id INT,
order_date DATETIME,
customer_id INT,
order_status VARCHAR(30),
CONSTRAINT order_idPK PRIMARY KEY (order_id) 
);


SHOW CREATE TABLE customers;
CREATE TABLE `customers` (
  `customer_id` int DEFAULT NULL,
  `customer_fname` varchar(30) DEFAULT NULL,
  `customer_lname` varchar(30) DEFAULT NULL,
  `customer_email` varchar(30) DEFAULT NULL,
  `customer_phone` varchar(30) DEFAULT NULL,
  `customer_street` varchar(255) DEFAULT NULL,
  `customer_city` varchar(30) DEFAULT NULL,
  `customer_state` varchar(30) DEFAULT NULL,
  `customer_zipcode` varchar(30) DEFAULT NULL
);


SELECT * FROM orders;
SELECT COUNT(*) FROM orders;
SELECT * FROM customers;
	
-- ===============================================================================
-- DATA QUALITY CHECK EXAMPLE
-- find customers who are in customers table but never placed an order
-- ===============================================================================
SELECT * FROM customers
EXCEPT
SELECT * FROM orders;
-- this query will not work:
-- 09:40:47	SELECT * FROM customers EXCEPT SELECT * FROM orders	Error Code: 1222. 
-- The used SELECT statements have a different number of columns	

-- USE THIS
SELECT customer_id FROM customers
EXCEPT
SELECT customer_id FROM orders;

-- ===============================================================================
-- DATA QUALITY CHECK
-- find orders that exist but customer does not exist
-- ===============================================================================
SELECT customer_id FROM orders
EXCEPT
SELECT customer_id FROM customers;

-- ===============================================================================
-- SCENARIO
-- find people who purchased AND subscribed to newsletter BUT did NOT return product
-- (A ∩ B - C)
-- ===============================================================================
SELECT customer_id FROM purchases
INTERSECT
SELECT customer_id FROM newsletter_subscriptions

EXCEPT

SELECT customer_id FROM returns;

-- ===============================================================================
-- find people who purchased OR subscribed but NOT both
-- ===============================================================================
(SELECT customer_id FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))

EXCEPT

SELECT customer_id FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)

UNION ALL

(SELECT customer_id FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))

EXCEPT

SELECT customer_id FROM purchases
WHERE purchase_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);

-- ============================================================
-- WHAT WE COVERED
-- ============================================================

/*
✔ UNION
✔ UNION ALL
✔ INTERSECT
✔ EXCEPT
✔ Older MySQL versions do not support INTERSECT and EXCEPT
✔ Multiple set operations can be combined to create complex queries
✔ Used DATE_SUB() to retrieve last one month data
✔ Always select compatible columns in set operations
✔ If duplicates are impossible, prefer UNION ALL for better performance
*/