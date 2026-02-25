-- ===============================================================================
-- DAY 16 SQL : AGGREGATION, GROUP BY, HAVING
-- =============================================================================== 

/*
IMPORTANT RULES:
    - WHERE CALUSE ONLY INSURES NO-NULL VALUES 
    - WHERE filters rows before grouping
    - HAVING filters groups after aggregation
    - Aggregate functions ignore NULL values

GROUP BY:
    - Groups rows based on specific column(s)
    - Example: total sales GROUP BY category → data is broken into multiple category groups

HAVING: 
    - clause filters grouped data by comparing aggregated values 
    - (e.g., SUM, AVG, COUNT) against specified conditions, 
    - functioning as a post-aggregation WHERE filter.
*/

SELECT DISTINCT category FROM sales;
-- =================================================================================
-- Total sales by category (data broken into multiple groups)
-- =================================================================================
SELECT category, SUM(amount) AS value 
FROM sales 
GROUP BY category;

-- ================================================================================================
-- This works but output meaning is unclear because category column is missing in select statement
-- ================================================================================================
SELECT SUM(amount) AS total_amount 
FROM sales 
GROUP BY category;

-- =================================================================================
-- Not valid logically (sale_date is not aggregated or grouped)
-- =================================================================================
SELECT category, sale_date, SUM(amount) AS total_amount 
FROM sales 
GROUP BY category;

-- =================================================================================
-- Correct: use aggregate function on date also
-- =================================================================================
SELECT category, 
MAX(sale_date) AS latest_date_of_order, 
SUM(amount) AS total_amount 
FROM sales 
GROUP BY category;

-- =================================================================================
-- GROUP BY without aggregation behaves like DISTINCT
-- =================================================================================
SELECT category FROM sales GROUP BY category;
SELECT DISTINCT category FROM sales;

-- =================================================================================
-- group by category and product
-- =================================================================================
SELECT category, product, SUM(amount) 
FROM sales 
GROUP BY category, product;

-- =================================================================================
-- count of products in each category
-- =================================================================================
SELECT category, COUNT(DISTINCT product) AS total_number_of_product 
FROM sales 
GROUP BY category;

-- =================================================================================
-- total quantity sold for each product
-- =================================================================================
SELECT category, product, SUM(quantity) AS total_quantity
FROM sales 
GROUP BY category, product;

-- =================================================================================
-- total quantity sold for each product with total order count
-- =================================================================================
SELECT category, product, 
COUNT(*) AS total_order_for_this_product, 
SUM(quantity) AS total_quantity
FROM sales 
GROUP BY category, product;

-- =================================================================================
-- 3 products with maximum sales volume
-- =================================================================================
SELECT product, SUM(quantity) AS total_quantity
FROM sales 
GROUP BY product 
ORDER BY total_quantity DESC 
LIMIT 3;

/*
EXECUTION FLOW:
FROM sales → GROUP BY product → SELECT → ORDER BY → LIMIT
*/

-- =================================================================================
-- total sales and number of transactions per store
-- =================================================================================
SELECT store_location, 
SUM(amount) AS total_sales, 
COUNT(*) AS number_of_transaction
FROM sales 
GROUP BY store_location;

-- =================================================================================
-- average sale amount for each customer
-- =================================================================================
SELECT customer_id, AVG(amount) AS average_sale
FROM sales 
GROUP BY customer_id;

-- =================================================================================
-- multiple aggregation together
-- =================================================================================
SELECT customer_id, 
AVG(amount) AS average_sale, 
SUM(amount) AS total_amount, 
COUNT(*) AS total_transaction, 
(SUM(amount)/COUNT(*)) AS AvgSale
FROM sales 
GROUP BY customer_id;

-- =================================================================================
-- count of distinct categories
-- =================================================================================
SELECT COUNT(DISTINCT category) AS value 
FROM sales;

-- ===============================================================================
-- Total sales by month and category
-- ===============================================================================

-- DATE_FORMAT() explanation:
-- %Y = full year (2024)
-- %y = short year (24)
-- %m = numeric month
-- %M = month name
-- %d = day number
-- %D = day in ordinal numbers - 1st 2nd 3rd ....n order\

SELECT DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
category, 
SUM(quantity)
FROM sales
GROUP BY category, sale_month;

-- alternative syntax
SELECT DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
category, 
SUM(quantity)
FROM sales
GROUP BY category, DATE_FORMAT(sale_date,'%Y-%m');

-- ===============================================================================
-- HAVING: clause filters grouped data by comparing aggregated values 
-- (e.g., SUM, AVG, COUNT) against specified conditions, functioning as a post-aggregation WHERE filter.
-- ===============================================================================

-- ===============================================================================
-- WRONG: WHERE cannot filter aggregated column alias becouse select execute after where
-- ===============================================================================
SELECT store_location, SUM(amount) AS total_amount
FROM sales 
WHERE total_amount >= 200000
GROUP BY store_location;

-- ===============================================================================
-- Correct: use HAVING for aggregation filter
-- ===============================================================================
SELECT store_location, SUM(amount) AS total_amount
FROM sales
GROUP BY store_location 
HAVING total_amount >= 200000;

-- ===============================================================================
-- highest order amount per category
-- ===============================================================================
SELECT category, MAX(amount)
FROM sales 
GROUP BY category;

-- ===============================================================================
-- execution example
-- ===============================================================================
SELECT store_location, SUM(amount) AS total_amount
FROM sales
WHERE store_location IN ('Mumbai', 'Delhi')
GROUP BY store_location 
HAVING total_amount >= 200000
LIMIT 3;

/*
Execution Order:
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. DISTINCT
7. ORDER BY
8. LIMIT
*/

-- ===============================================================================
-- total sales and average quantity sold per product in Mumbai
-- ===============================================================================
SELECT product, 
SUM(amount) AS sale_amount, 
AVG(quantity) AS avg_quantity, 
store_location
FROM sales 
WHERE store_location = 'Mumbai'
GROUP BY product, store_location;

-- ===============================================================================
-- optimized filter
-- ===============================================================================
SELECT product, 
SUM(amount) AS sale_amount, 
SUM(quantity) AS total_quantity, 
store_location
FROM sales 
WHERE store_location = 'Mumbai' 
AND product = 'Laptop'
GROUP BY product, store_location;

-- ===============================================================================
-- total sales and total quantity sold each month
-- ===============================================================================
SELECT DATE_FORMAT(sale_date,'%Y-%m') AS month,
SUM(amount) AS total_sales, 
SUM(quantity) AS total_quantity
FROM sales 
GROUP BY month;

-- ===============================================================================
-- unique customers per store
-- ===============================================================================
SELECT store_location, 
COUNT(DISTINCT customer_id) AS customer_count
FROM sales
GROUP BY store_location;

-- ===============================================================================
-- with total orders also
-- ===============================================================================
SELECT store_location, 
COUNT(DISTINCT customer_id) AS customer_count,
COUNT(*) AS total_orders
FROM sales
GROUP BY store_location;

-- ===============================================================================
-- monthly sales by each customer
-- ===============================================================================
SELECT customer_id, 
DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
SUM(amount) AS total_sale
FROM sales
GROUP BY customer_id, sale_month;

-- ===============================================================================
-- customers who placed at least 2 orders per month
-- ===============================================================================
SELECT customer_id, 
DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
SUM(amount) AS total_sale
FROM sales
GROUP BY customer_id, sale_month
HAVING COUNT(*) > 2;

-- ===============================================================================
-- premium customers monthly sale > 600
-- ===============================================================================
SELECT customer_id, 
DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
SUM(amount) AS total_sale
FROM sales
GROUP BY customer_id, sale_month
HAVING SUM(amount) > 600;

/*
Logical Flow:
FROM → GROUP BY → HAVING → SELECT
*/

-- ===============================================================================
-- total sales amount by category in Jan 2024
-- ===============================================================================
SELECT category, SUM(amount) AS total_sale_amount
FROM sales 
WHERE sale_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY category;

-- ===============================================================================
-- alternative using MONTH function
-- ===============================================================================
SELECT category, SUM(amount) AS total_sales
FROM sales 
WHERE MONTH(sale_date)=1 AND YEAR(sale_date)=2024
GROUP BY category;

-- ===============================================================================
-- premium weekday sales (>7000)
-- ===============================================================================
SELECT customer_id, SUM(amount) AS total_premium_sales
FROM sales 
WHERE DAYOFWEEK(sale_date) BETWEEN 2 AND 6
GROUP BY customer_id
HAVING SUM(amount) > 7000;

/*
DAYOFWEEK(date)
1 = Sunday
2 = Monday
3 = Tuesday
4 = Wednesday
5 = Thursday
6 = Friday
7 = Saturday
*/

-- ===============================================================================
-- monthly sales summary per store
-- ===============================================================================
SELECT COUNT(*) AS num_transaction, 
SUM(amount) AS total_sales, 
store_location
FROM sales 
WHERE sale_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY store_location 
ORDER BY num_transaction DESC;

-- ===============================================================================
/*
WHAT WE COVERED SO FAR:
AGGREGATION & GROUP BY:
    - SUM(), COUNT(), AVG(), MIN(), MAX()
    - GROUP BY for data segmentation
    - COUNT(DISTINCT column)
    - GROUP BY vs DISTINCT concept
    - DATE_FORMAT for monthly aggregation
    - HAVING vs WHERE (aggregation filtering)
    - Execution order of SQL query
    - Derived calculations inside aggregation
    - Real-world business queries using grouping
*/
