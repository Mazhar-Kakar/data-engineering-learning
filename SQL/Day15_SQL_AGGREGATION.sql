-- ===============================================================================
-- DAY 15 SQL : AGGREGATION, GROUP BY 
-- =============================================================================== 
/*
We have talked about:
-- Order of execution
-- DISTINCT and ORDER BY sometimes do not work together.
   Logically the query may look correct, but SQL execution rules matter.
   If it throws an error, it is actually good because it prevents wrong results.

AGGREGATION: 
    - Used to aggregate rows into a single summary value
    - Mostly used with numeric columns
    - Inbuilt functions: COUNT(), SUM(), AVG(), MAX(), MIN()

GROUP BY:
    - Helps to group rows before applying aggregate functions
    - Works after WHERE filtering step
*/

USE retail_db;

-- ===============================================================================
-- CREATE SAMPLE TABLE IF NOT EXISTS TO UNDERSTAND AGGREGATE FUNCTIONS AND GROUP BY
-- ===============================================================================

CREATE TABLE IF NOT EXISTS sales (
id INT AUTO_INCREMENT PRIMARY KEY,
product VARCHAR(50),
category VARCHAR(50),
amount DECIMAL(10,2),
sale_date DATE,
quantity INT,
customer_id INT,
store_location VARCHAR(50)
);

INSERT INTO sales
(id, product, category, amount, sale_date, quantity, customer_id, store_location)
VALUES
(1,'Laptop','Electronics',55000,'2024-01-01',1,101,'Mumbai'),
(2,'Mouse','Electronics',700,'2024-01-01',2,102,'Delhi'),
(3,'Keyboard','Electronics',1200,'2024-01-02',1,103,'Pune'),
(4,'Monitor','Electronics',15000,'2024-01-02',1,104,'Mumbai'),
(5,'Mobile','Electronics',22000,'2024-01-03',1,105,'Delhi'),
(6,'Charger','Accessories',800,'2024-01-03',2,101,'Pune'),
(7,'Headphones','Accessories',2500,'2024-01-04',1,102,'Mumbai'),
(8,'Shoes','Fashion',3200,'2024-01-04',1,103,'Delhi'),
(9,'T-Shirt','Fashion',900,'2024-01-05',3,104,'Pune'),
(10,'Jeans','Fashion',2800,'2024-01-05',1,105,'Mumbai'),

(11,'Rice','Grocery',1800,'2024-01-06',5,106,'Delhi'),
(12,'Wheat','Grocery',1600,'2024-01-06',4,107,'Pune'),
(13,'Oil','Grocery',1400,'2024-01-07',2,108,'Mumbai'),
(14,'Sugar','Grocery',900,'2024-01-07',3,109,'Delhi'),
(15,'Milk','Grocery',500,'2024-01-08',5,110,'Pune'),

(16,'Laptop','Electronics',56000,'2024-01-08',1,111,'Mumbai'),
(17,'Mobile','Electronics',24000,'2024-01-09',1,112,'Delhi'),
(18,'Tablet','Electronics',18000,'2024-01-09',1,113,'Pune'),
(19,'Smartwatch','Electronics',9000,'2024-01-10',1,114,'Mumbai'),
(20,'Earbuds','Accessories',3500,'2024-01-10',1,115,'Delhi'),

-- repeating pattern for learning purposes
(21,'Laptop','Electronics',54000,'2024-01-11',1,101,'Pune'),
(22,'Mouse','Electronics',750,'2024-01-11',2,102,'Mumbai'),
(23,'Keyboard','Electronics',1100,'2024-01-12',1,103,'Delhi'),
(24,'Monitor','Electronics',15500,'2024-01-12',1,104,'Pune'),
(25,'Mobile','Electronics',21000,'2024-01-13',1,105,'Mumbai'),

(26,'Shoes','Fashion',3500,'2024-01-13',1,106,'Delhi'),
(27,'T-Shirt','Fashion',950,'2024-01-14',2,107,'Pune'),
(28,'Jeans','Fashion',3000,'2024-01-14',1,108,'Mumbai'),
(29,'Jacket','Fashion',4500,'2024-01-15',1,109,'Delhi'),
(30,'Cap','Fashion',600,'2024-01-15',3,110,'Pune'),

(31,'Rice','Grocery',2000,'2024-01-16',5,111,'Mumbai'),
(32,'Wheat','Grocery',1700,'2024-01-16',4,112,'Delhi'),
(33,'Oil','Grocery',1500,'2024-01-17',2,113,'Pune'),
(34,'Sugar','Grocery',950,'2024-01-17',3,114,'Mumbai'),
(35,'Milk','Grocery',550,'2024-01-18',5,115,'Delhi'),

(NULL,'Laptop','Electronics',58000,'2024-02-01',1,116,'Mumbai'),
(NULL,'Mobile','Electronics',26000,'2024-02-01',1,117,'Delhi'),
(NULL,'Tablet','Electronics',19000,'2024-02-02',1,118,'Pune'),
(NULL,'Smartwatch','Electronics',9500,'2024-02-02',1,119,'Mumbai'),
(NULL,'Earbuds','Accessories',3800,'2024-02-03',1,120,'Delhi'),

(NULL,'Shoes','Fashion',3300,'2024-02-03',1,121,'Pune'),
(NULL,'T-Shirt','Fashion',850,'2024-02-04',2,122,'Mumbai'),
(NULL,'Jeans','Fashion',2900,'2024-02-04',1,123,'Delhi'),
(NULL,'Jacket','Fashion',4700,'2024-02-05',1,124,'Pune'),
(NULL,'Cap','Fashion',650,'2024-02-05',3,125,'Mumbai'),

(NULL,'Rice','Grocery',2100,'2024-02-06',5,126,'Delhi'),
(NULL,'Wheat','Grocery',1750,'2024-02-06',4,127,'Pune'),
(NULL,'Oil','Grocery',1550,'2024-02-07',2,128,'Mumbai'),
(NULL,'Sugar','Grocery',1000,'2024-02-07',3,129,'Delhi'),
(NULL,'Milk','Grocery',600,'2024-02-08',5,130,'Pune');

SELECT * FROM sales;

-- =================================================================================
-- TOTAL SALES SUMMARY USING AGGREGATE FUNCTIONS
-- =================================================================================
-- This returns only ONE ROW because aggregation reduces multiple rows into one result.

SELECT COUNT(*) AS total_sales,
SUM(amount) AS total_amount,
MAX(amount) AS max_amount,
MIN(amount) AS min_amount,
AVG(amount) AS average_amount
FROM sales;

-- =================================================================================
-- BASICS OF SET OPERATION - UNION
-- UNION - Combines results from multiple SELECT queries
-- Removes duplicate rows
-- =================================================================================

SELECT 'total_sales' AS aggregation, COUNT(*) AS value FROM sales
UNION
SELECT 'total_amount', SUM(amount) FROM sales
UNION
SELECT 'max_amount', MAX(amount) FROM sales
UNION
SELECT 'min_amount', MIN(amount) FROM sales
UNION
SELECT 'average_amount', AVG(amount) FROM sales;

-- =================================================================================
-- UNION ALL 
-- UNION ALL keeps duplicates
-- =================================================================================

SELECT 'total_sales' AS aggregation, COUNT(*) AS value FROM sales
UNION ALL
SELECT 'total_amount', SUM(amount) FROM sales
UNION ALL
SELECT 'total_amount', SUM(amount) FROM sales
UNION ALL
SELECT 'max_amount', MAX(amount) FROM sales
UNION ALL
SELECT 'min_amount', MIN(amount) FROM sales
UNION ALL
SELECT 'average_amount', AVG(amount) FROM sales;

/*
IMPORTANT RULES:
    - SUM(), AVG() → work only on numeric values
    - COUNT() → works with all data types
    - MIN(), MAX() → work with numbers, strings, and dates
    - Aggregate functions ignore NULL values
*/

-- =================================================================================
-- EXAMPLES WITH DATE
-- =================================================================================

SELECT MIN(sale_date) FROM sales;
SELECT MAX(sale_date) FROM sales;

-- ===============================================================================
/*
What we covered so far:
AGGREGATION:
    - Used to summarize rows into single values
    - COUNT(), SUM(), AVG(), MIN(), MAX()
    - SUM(), AVG() work only on numeric columns
    - MIN(), MAX() also work with dates and strings
    - Aggregate functions ignore NULL values
*/