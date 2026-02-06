-- ============================================================
-- Day04 SQL : ALTER Command (Modify Table Structure)
-- ============================================================

/*
ALTER is a DDL command used to change the structure of an existing table.

We can use ALTER to:
- Add new column
- Drop column
- Modify data type
- Rename column
- Rename table
*/

-- ============================================================
-- Create Database and Use It
-- ============================================================

CREATE DATABASE retail_db;
USE retail_db;

-- ============================================================
-- Create Orders Table
-- ============================================================

CREATE TABLE orders (
    order_id INT,
    order_item_id INT,
    order_date DATE,
    customer_id INT,
    product_id INT,
    quantity INT,
    product_price FLOAT,
    total_price FLOAT
);

-- View table structure
DESC orders;

-- ============================================================
-- Insert Sample Data
-- ============================================================

INSERT INTO orders 
(order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, total_price)
VALUES
(1,101,'2025-01-01',10,501,2,19.99,39.98),
(2,102,'2025-01-02',11,502,1,15.50,15.50),
(3,103,'2025-01-03',12,503,3,12.00,36.00),
(4,104,'2025-01-04',13,504,4,8.75,35.00),
(5,105,'2025-01-05',14,505,2,22.40,44.80);

SELECT * FROM orders;

-- ============================================================
-- Add New Column Using ALTER
-- ============================================================

ALTER TABLE orders 
ADD COLUMN order_status VARCHAR(20);

-- This will fail because column count does not match
INSERT INTO orders VALUES (6,106,'2025-01-06',15,506,1,18.99,18.99);

-- Good Practice: Always specify column names
INSERT INTO orders
(order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, total_price, order_status)
VALUES
(6,106,'2025-01-06',15,506,1,18.99,18.99,'COMPLETED');

-- ============================================================
-- NULL Value Example
-- NULL means absence of data
-- ============================================================

INSERT INTO orders
(order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, total_price, order_status)
VALUES
(7,107,'2025-01-07',16,507,2,6.50,13.00,NULL);

-- ============================================================
-- Drop Column
-- ============================================================

ALTER TABLE orders 
DROP COLUMN total_price;

DESC orders;

-- ============================================================
-- Modify Column Data Type
-- ============================================================

-- Change DATE to DATETIME
ALTER TABLE orders 
MODIFY order_date DATETIME;

-- Change DATETIME back to DATE
ALTER TABLE orders 
MODIFY order_date DATE;

-- If DATETIME is inserted, time part will be lost when converted to DATE
INSERT INTO orders
(order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, order_status)
VALUES
(8,108,'2025-01-08 11:30:31',17,508,2,14.20,NULL);

-- ============================================================
-- Rename Column
-- ============================================================

ALTER TABLE orders 
RENAME COLUMN order_date TO order_time;

-- ============================================================
-- Modify Other Column Types
-- ============================================================

-- FLOAT to INT (compatible but decimals will be lost)
ALTER TABLE orders 
MODIFY product_price INT;

-- INT to VARCHAR
ALTER TABLE orders 
MODIFY product_id VARCHAR(5);

-- This will fail because VARCHAR(1) is too small
ALTER TABLE orders 
MODIFY customer_id VARCHAR(1);

-- NOTE: Changing datatype can cause data loss

-- ============================================================
-- Rename Table
-- ============================================================

ALTER TABLE orders 
RENAME TO orders_with_status;

SHOW TABLES;

-- ============================================================
-- Transaction Example
-- ============================================================

SELECT * FROM orders_with_status;

DELETE FROM orders_with_status;

-- Undo delete
ROLLBACK;

-- ============================================================
-- What We Learned
-- ============================================================

/*
✔ ALTER TABLE ADD COLUMN
✔ ALTER TABLE DROP COLUMN
✔ ALTER TABLE MODIFY datatype
✔ ALTER TABLE RENAME COLUMN
✔ ALTER TABLE RENAME TABLE
✔ NULL values
✔ Importance of specifying column names in INSERT
✔ Data loss risk while modifying datatypes
✔ ROLLBACK with DML operations
*/

