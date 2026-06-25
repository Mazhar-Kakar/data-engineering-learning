-- ===============================================================================
-- DAY 20 SQL : INNER JOIN
-- =============================================================================== 

-- CREATE NEW DATABASE
CREATE DATABASE practice_joins;
USE practice_joins;

/*
CREATE SIX TABLES:
    - customers
    - orders
    - order_items
    - products
    - category
    - departments
*/

-- ---------------------------------------------------------------------------------
-- ER DIAGRAM
-- ---------------------------------------------------------------------------------

/*
+---------------------+
|      Customers      |
+---------------------+
| CustomerID (PK)     |
| CustomerName        |
| Email               |
| Phone               |
| Address             |
+---------------------+
          |
          | 1
          |
          | M
+---------------------+
|        Orders       |
+---------------------+
| OrderID (PK)        |
| CustomerID (FK)     |
| OrderDate           |
| TotalAmount         |
| Status              |
+---------------------+
          |
          | 1
          |
          | M
+---------------------+
|     Order_Items     |
+---------------------+
| OrderItemID (PK)    |
| OrderID (FK)        |
| ProductID (FK)      |
| Quantity            |
| UnitPrice           |
+---------------------+
          |
          | M
          |
          | 1
+---------------------+
|       Products      |
+---------------------+
| ProductID (PK)      |
| ProductName         |
| CategoryID (FK)     |
| Price               |
+---------------------+
          |
          | M
          |
          | 1
+---------------------+
|      Categories     |
+---------------------+
| CategoryID (PK)     |
| CategoryName        |
| DepartmentID (FK)   |
+---------------------+
          |
          | M
          |
          | 1
+---------------------+
|     Departments     |
+---------------------+
| DepartmentID (PK)   |
| DepartmentName      |
+---------------------+
*/


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- ---------------------------------------------------------------------------------
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_department_id INT,
    category_name VARCHAR(100),
    CONSTRAINT category_department_idFK 
    FOREIGN KEY (category_department_id) 
    REFERENCES departments(department_id)
);

-- ---------------------------------------------------------------------------------
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_category_id INT,
    product_name VARCHAR(150),
    product_description TEXT,
    product_price DECIMAL(10,2),
    product_image VARCHAR(255),
    CONSTRAINT product_category_idFK 
    FOREIGN KEY (product_category_id) 
    REFERENCES category(category_id)
);

-- ---------------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_fname VARCHAR(50),
    customer_lname VARCHAR(50),
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20),
    customer_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    pincode INT
);

-- ---------------------------------------------------------------------------------
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    order_status VARCHAR(50),
    CONSTRAINT customer_idFK 
    FOREIGN KEY (customer_id) 
    REFERENCES customers(customer_id)
);

-- ---------------------------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    price DECIMAL(10,2),
    CONSTRAINT order_idFK 
    FOREIGN KEY (order_id) 
    REFERENCES orders(order_id),
    CONSTRAINT product_idFK 
    FOREIGN KEY (product_id) 
    REFERENCES products(product_id)
);

-- ---------------------------------------------------------------------------------
SELECT * FROM departments;
SELECT * FROM category;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;

-- ===============================================================================
-- WHAT IS INNER JOIN
-- ===============================================================================
-- INNER JOIN combines data from multiple tables using a common column
-- It returns only matching records from both tables

-- Example:
-- If T1 has 100 rows and T2 has 120 rows
-- and 65 rows match based on join condition
-- INNER JOIN will return only those 65 matching rows

-- Important:
-- If duplicate values exist, output rows increase based on matching combinations

-- Example:
-- orders.customer_id:
-- 2,5,5,5,7
-- customers.customer_id:
-- 1,2,3,4,5,5,2
-- Output depends on number of matching combinations (many-to-many effect)
-- 2+2+2+2=8 records

-- ===============================================================================
-- Find the name of the customer who placed order_id = 1
-- ===============================================================================

-- Method 1: Two-step approach (manual)

-- Step 1: Get customer_id
SELECT customer_id 
FROM orders
WHERE order_id = 1;

-- Step 2: Get customer name
SELECT customer_id, CONCAT(customer_fname, " ", customer_lname) AS customer_name
FROM customers
WHERE customer_id = 11599;

-- ===============================================================================
-- Method 2: Using Subquery
-- ===============================================================================
SELECT customer_id, CONCAT(customer_fname, " ", customer_lname) AS customer_name
FROM customers
WHERE customer_id = (SELECT customer_id FROM orders WHERE order_id = 1);

-- ===============================================================================
-- Method 3: Using JOIN (Best & Recommended)
-- ===============================================================================
SELECT o.order_id, c.customer_id, CONCAT(c.customer_fname, " ", c.customer_lname) AS customer_name
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.order_id = 1;

-- SAME (JOIN = INNER JOIN by default)
SELECT o.order_id, c.customer_id, CONCAT(c.customer_fname, " ", c.customer_lname) AS customer_name
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- count of matching records
SELECT COUNT(*)
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- ===============================================================================
-- IMPORTANT NOTES
-- ===============================================================================
-- 1. JOIN = INNER JOIN by default, but always mention INNER JOIN for clarity
-- 2. JOIN is preferred for large datasets (more efficient than subqueries)
-- 3. Always write correct ON condition:
--    ON o.customer_id = c.customer_id
--    Otherwise it creates CROSS JOIN (Cartesian product → wrong results, extra records)
-- 4. Always use table aliases (o, c) to avoid ambiguity and improve readability

-- WRONG (ambiguous column)
-- SELECT order_id, customer_id FROM orders JOIN customers ON customer_id = customer_id;

-- ERROR: Column 'customer_id' is ambiguous

-- 5. Avoid SELECT * in real-world projects → select only required columns

-- ===============================================================================
-- HOW MANY CUSTOMERS PLACED AT LEAST ONE ORDER
-- ===============================================================================
SELECT COUNT(DISTINCT c.customer_id)
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- Using SET operation
SELECT COUNT(*) 
FROM (SELECT customer_id FROM customers
INTERSECT 
SELECT customer_id FROM orders) c;

-- -------------------------------------------------------
-- TOTAL CUSTOMERS
SELECT COUNT(DISTINCT customer_id) FROM customers;

-- CUSTOMERS WHO NEVER PLACED ANY ORDER
SELECT COUNT(*) 
FROM (SELECT customer_id FROM customers
EXCEPT 
SELECT customer_id FROM orders) c;

-- OR (manual calculation)
-- total customers - customers who ordered
-- 12435 - 12405 = 30
-- -------------------------------------------------------

-- ============================================================
-- WHAT WE COVERED
-- ============================================================
show databases;
/*
✔ INNER JOIN
✔ How to retrieve related data using JOIN
✔ Customer who placed at least one order using INNER JOIN / INTERSECT
✔ Customer who never placed any order using EXCEPT
✔ Understanding ER model, relationships, and mapping between tables
*/


show create table customers;