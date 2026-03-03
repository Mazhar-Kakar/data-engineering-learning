-- ===============================================================================
-- DAY 18 SQL : BUILT-IN DATE & NUMERIC FUNCTIONS 
-- =============================================================================== 

/*
DATE FUNCTIONS:
    - SQL provides many built-in date functions to manipulate and retrieve date/time data.
    - CURRENT_DATE()
    - CURRENT_TIME()
    - CURRENT_TIMESTAMP()
    - DATE()
    - TIME()
    - TIMESTAMP()
    - EXTRACT()
    - YEAR()
    - MONTH()
    - DAY()
    - WEEK()
    - DATE_FORMAT()
    - MONTHNAME()
    - DAYNAME()
*/

USE retail_db;
DROP TABLE IF EXISTS orders1;

-- ===============================================================================
-- CREATE NEW TABLE
-- ===============================================================================
CREATE TABLE orders1(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	quantity INT,
	order_date DATE,
	total_amount DECIMAL(10,2)
);

INSERT INTO orders1 (customer_id,product_id,quantity,order_date,total_amount)
VALUES
(1,101,2,CURRENT_DATE,199.98),
(2,102,1,CURRENT_DATE,99.99),
(3,103,5,CURRENT_DATE,499.95),
(4,104,3,CURRENT_DATE,299.97),
(5,105,4,CURRENT_DATE,399.96);

-- ===============================================================================
-- DATE(): EXTRACT ONLY DATE FROM DATETIME
-- ===============================================================================
SELECT DATE('2026-01-03 15:54:48') AS date_only;
-- O/P: '2026-01-03'

-- ===============================================================================
-- TIME(): EXTRACT ONLY TIME FROM DATETIME
-- ===============================================================================
SELECT TIME('2026-01-03 15:54:48') AS time_only;
-- O/P: '15:54:48'

-- ===============================================================================
-- TIMESTAMP(): RETURNS DATETIME VALUE
-- ===============================================================================
SELECT TIMESTAMP('2026-01-03 15:54:48') AS datetime_value;

-- ===============================================================================
-- EXTRACT(): RETRIEVE SPECIFIC PART OF DATE
-- ===============================================================================
SELECT EXTRACT(YEAR FROM '2026-01-03') AS year_only;
SELECT EXTRACT(MONTH FROM '2026-01-03') AS month_only;
SELECT EXTRACT(DAY FROM '2026-01-03') AS day_only;

-- ===============================================================================
-- USING YEAR() FUNCTION
-- ===============================================================================
SELECT order_id, customer_id, product_id, quantity, 
       YEAR(order_date) AS order_year, 
       total_amount 
FROM orders1;

-- ===============================================================================
-- DATE_FORMAT(): FORMAT DATE IN DIFFERENT STYLES
-- ===============================================================================
/*
%Y = full year (2024)
%y = short year (24)
%m = numeric month
%M = month name
%d = day number
%D = day with ordinal (1st, 2nd, 3rd)
*/

SELECT id, product, amount, 
       DATE_FORMAT(sale_date,'%Y') AS year_only,
       quantity, customer_id, store_location 
FROM sales;

SELECT id, product, amount, 
       DATE_FORMAT(sale_date,'%Y-%M-%d') AS formatted_date,
       quantity, customer_id, store_location 
FROM sales;

-- ===============================================================================
-- GROUP BY YEAR AND MONTH
-- ===============================================================================
SELECT CONCAT(YEAR(sale_date),'-',MONTH(sale_date)) AS year_month,
       SUM(amount) AS total_sales
FROM sales
GROUP BY year_month;

-- SIMPLER APPROACH
SELECT EXTRACT(YEAR_MONTH FROM sale_date) AS year_month,
       SUM(amount) AS total_sales
FROM sales
GROUP BY year_month;

-- ===============================================================================
-- WEEK FUNCTION
-- ===============================================================================
SELECT EXTRACT(WEEK FROM '2026-02-28') AS week_only;

-- OTHER DATE FUNCTIONS
SELECT MONTH('2026-01-26');
SELECT YEAR('2026-01-26');
SELECT DAY('2026-01-26');
SELECT WEEK('2026-01-26');
SELECT MONTHNAME('2026-01-26');
SELECT DAYNAME('2026-01-26');

-- ===============================================================================
-- DATE_ADD / DATE_SUB / DATEDIFF
-- ===============================================================================
SELECT DATE_ADD(CURRENT_DATE, INTERVAL 10 DAY) AS new_date;
SELECT DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY) AS new_date;

SELECT DATE_SUB(CURRENT_DATE, INTERVAL 10 MONTH);
SELECT DATE_ADD(CURRENT_DATE, INTERVAL 10 YEAR);

-- DATEDIFF: RETURNS DIFFERENCE IN DAYS
SELECT DATEDIFF(CURRENT_DATE,'2006-09-28') AS date_distance;

-- ===============================================================================
-- UNIX TIMESTAMP (EPOCH TIME)
-- NUMBER OF SECONDS SINCE 1 JAN 1970
-- ===============================================================================
SELECT UNIX_TIMESTAMP();
SELECT FROM_UNIXTIME(1767447142);
SELECT UNIX_TIMESTAMP('2006-09-28');

-- ===============================================================================
-- NUMERIC FUNCTIONS
-- ===============================================================================

-- ABS(): RETURNS ABSOLUTE VALUE
SELECT ABS(10);
SELECT ABS(-10);

-- CEIL(): RETURNS NEXT HIGHEST INTEGER
SELECT CEIL(3.2);   -- 4
SELECT CEIL(-3.2);  -- -3

-- FLOOR(): RETURNS NEXT LOWEST INTEGER
SELECT FLOOR(3.2);   -- 3
SELECT FLOOR(-3.2);  -- -4

-- ROUND(): ROUND TO SPECIFIED DECIMAL
SELECT ROUND(4.567,2);

-- TRUNCATE(): CUT WITHOUT ROUNDING
SELECT TRUNCATE(4.567,2);

-- MOD(): RETURNS REMAINDER
SELECT MOD(10,3);

-- POWER(): EXPONENT
SELECT POWER(2,3);

-- SQRT(): SQUARE ROOT
SELECT SQRT(16);

-- SIGN(): RETURNS -1, 0, OR 1
SELECT SIGN(-5);

-- RAND(): RANDOM NUMBER
SELECT RAND();

-- ===============================================================================
-- CASE STATEMENT
-- ===============================================================================
SELECT *, 
CASE
	WHEN salary < 45000 THEN 'low'
    WHEN salary BETWEEN 45000 AND 55000 THEN 'medium'
	ELSE 'high'
END AS salary_band
FROM employees;

-- ===============================================================================
-- CAST (TYPE CASTING)
-- ===============================================================================
SHOW CREATE TABLE employees;

CREATE TABLE employees101 (
  employee_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department_id INT DEFAULT NULL,
  salary VARCHAR(50) DEFAULT NULL,
  hire_date VARCHAR(50) DEFAULT NULL,
  manager_id INT DEFAULT NULL,
  email VARCHAR(100) DEFAULT NULL,
  phone_number VARCHAR(20) DEFAULT NULL,
  job_title VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (employee_id)
);

INSERT INTO employees101
SELECT * FROM employees;

-- This will NOT work because hire_date is VARCHAR
SELECT YEAR(hire_date) FROM employees101;

-- Correct way: Type casting
SELECT YEAR(CAST(hire_date AS DATE)) AS hire_year
FROM employees101;

SELECT CAST(salary AS DECIMAL(10,2)) * 1.1 AS new_salary
FROM employees101;

-- ===============================================================================
-- COALESCE
-- USED TO HANDLE NULL VALUES
-- RETURNS FIRST NON-NULL VALUE
-- ===============================================================================
CREATE TABLE products_new (
product_name VARCHAR(50),
discount_price DECIMAL(10,2),
regular_price DECIMAL(10,2)
);

INSERT INTO products_new VALUES
('LAPTOP',NULL,1200.00),
('SMARTPHONE',800.00,1000.00),
('TABLET',NULL,300.00);

SELECT COALESCE(discount_price,regular_price) AS display_price
FROM products_new;

-- ===============================================================================
-- COALESCE WITH MULTIPLE COLUMNS
-- ===============================================================================
CREATE TABLE orders_new (
	order_id INT, 
    billing_address VARCHAR(100),
    shipping_address VARCHAR(100),
    customer_address VARCHAR(100)
);

INSERT INTO orders_new VALUES
(1,'123 main st', NULL,'781 kak'),
(2,NULL,'1232 street road','22776 bharat nagar'),
(3,NULL,'34 street nk','43 had nk');

SELECT order_id, 
       COALESCE(billing_address, shipping_address, customer_address) AS preferred_address
FROM orders_new;

-- ===============================================================================
-- HANDLE NULL BEFORE ADDITION
-- ===============================================================================
CREATE TABLE sale_new (
sale_id INT,
online_sale DECIMAL(10,2),
store_sales DECIMAL(10,2)
);

INSERT INTO sale_new VALUES
(1,1500.50,NULL),
(2,NULL,2500.75),
(3,1000.25,500.00);

SELECT sale_id, 
       COALESCE(online_sale,0) + COALESCE(store_sales,0) AS total_sales 
FROM sale_new;

-- ===============================================================================
/*
WHAT WE COVERED SO FAR:
    - Date extraction using DATE(), TIME(), EXTRACT(), YEAR(), MONTH()
    - Date formatting using DATE_FORMAT()
    - Date arithmetic using DATE_ADD(), DATE_SUB(), DATEDIFF()
    - Unix timestamp (Epoch time)
    - Numeric functions (ABS, CEIL, FLOOR, ROUND, MOD, POWER)
    - Bsic CASE statement
    - Type casting using CAST()
    - Handling NULL values using COALESCE()
    - Inserting data from existing to another table
    - show full definition of table using SHOW CREATE TABLE 
*/