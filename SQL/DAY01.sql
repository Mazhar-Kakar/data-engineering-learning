-- Day01 SQL
-- =====================================================

/*
=> Database:
   A database is a collection of tables.
   It is an organized form of data stored electronically.

=> Table:
   An entity that stores data in the form of rows and columns.

=> Types of Databases:

-- Relational Databases (RDBMS)
   MySQL
   SQL Server
   PostgreSQL
   SQLite
   MariaDB

-- NoSQL Databases
   MongoDB
   HBase
   DynamoDB
*/

-- =======================================================================================================

-- Show all databases
SHOW DATABASES;

-- Create a new database
CREATE DATABASE retail_db;

-- Check which database is currently selected
SELECT DATABASE();

-- Connect to the database
USE retail_db;

-- =====================================================

-- Create a new table
CREATE TABLE orders (
    order_id INT,
    order_date DATETIME,
    customer_id INT,
    order_status VARCHAR(30)
);

-- Show tables inside current database
SHOW TABLES;

-- Retrieve all data from orders table
SELECT * FROM orders;

-- Insert records into orders table
INSERT INTO orders VALUES
(1, '2013-07-25 00:00:00', 11599, 'COMPLETED'),
(2, '2013-07-25', 256, 'PENDING_PAYMENT');

-- Drop table from connected database
DROP TABLE orders;

-- Switch to another database before dropping retail_db
USE mysql;

DROP DATABASE retail_db;

-- =====================================================
/*
ASSIGNMENT:
1) Create table customers and insert 5 records
2) Create table order_items and insert 5 records
*/

-- =====================================================

CREATE TABLE customers (
    customer_id INT,
    customer_fname VARCHAR(30),
    customer_lname VARCHAR(30),
    customer_email VARCHAR(30),
    customer_phone VARCHAR(30),
    customer_address VARCHAR(60),
    city VARCHAR(30),
    state VARCHAR(30),
    pincode VARCHAR(30)
);

-- Insert data into customers table
INSERT INTO customers VALUES
(6,'Amit','Sharma','amit.sharma@gmail.com','+919812345678','nehru nagar','mumbai','maharashtra','400001'),
(7,'Neha','Patel','neha.patel@gmail.com','+919834567890','sector 15','ahmedabad','gujarat','380015'),
(8,'Rahul','Verma','rahul.verma@gmail.com','+919845612345','rajiv chowk','delhi','delhi','110001'),
(9,'Priya','Singh','priya.singh@gmail.com','+919856789012','civil lines','jaipur','rajasthan','302006'),
(10,'Karan','Mehta','karan.mehta@gmail.com','+919867890123','mg road','indore','madhya pradesh','452001');

-- ================================================================================================================

CREATE TABLE order_items (
    order_item_id INT,
    order_item_order_id INT,
    product_id INT,
    quantity INT,
    total_amount INT,
    price INT
);

-- Insert data into order_items table
INSERT INTO order_items VALUES
(1,134,11599,5,2000,400),
(2,125,1176,5,1000,200),
(3,178,1152,5,500,100),
(4,134,1123,5,2000,400),
(5,1112,1187,5,2000,400);

-- =====================================================

/*
WHAT COVERED:

- Creating a database
- Creating tables
- SQL comments (#, --, /* *\/)
- Inserting data into tables
- Data types: INT, VARCHAR, DATETIME, DATE, FLOAT

Schema Concept:
Database -> Schema -> Tables

Example:
retail_db -> dev / test / prod -> orders

In MySQL:
Database -> Tables
retail_db -> orders
*/

