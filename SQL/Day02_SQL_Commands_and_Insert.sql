-- Day01 SQL
-- ===========================================================================================================
-- Types of SQL commands?
/*
1.DDL (Data Definition Language) – Defines the structure of the database.
CREATE, ALTER, DROP, TRUNCATE
2.DML (Data Manipulation Language) – Manages data stored in the database.
INSERT, UPDATE, DELETE
3.DCL (Data Control Language) – Controls access to the data.
GRANT, REVOKE
4.TCL (Transaction Control Language) – Manages transactions in the
database.
COMMIT, ROLLBACK, SAVEPOINT
5.DQL (Data Query Language) – Retrieves data from the database.
SELECT
*/
-- ===============================================================================================================================
-- INSERT COMMAND – With Various Scenarios

-- CREATE NEW TABLE
CREATE TABLE orders(
order_id int,
order_date datetime,
customer_id int,
order_status varchar(30)
);

-- "customer_id = '11599'" SQL automatically converts numeric strings to integers if the column data type is INT
INSERT INTO orders VALUES (1, '2013-07-25 00:00:00.0', '11599', 'COMPLETED'); -- -- Valid 


-- "customer_id = '1159-A9'" Error: non-numeric string cannot be converted to INT
INSERT INTO orders VALUES (2, '2013-07-25 00:00:00.0', '1159-A9', 'COMPLETED'); -- incorrect - DataType Error

-- order_status column is VARCHAR(30)
-- Even if we pass a number (8), SQL stores it as a string in VARCHAR column
INSERT INTO orders VALUES (3, '2013-07-25 00:00:00.0', 11599, 8); -- Valid 

-- order_date column is DATETIME
-- If only a DATE is provided, SQL automatically appends time as 00:00:00
INSERT INTO orders VALUES (9,'2013-07-25',11599,'COMPLETED'); -- Valid

-- ==============================================================================

DROP TABLE orders;

# RECREATE TABLE orders
CREATE TABLE orders(
order_id int,
order_date datetime,
customer_id int,
order_status varchar(5) -- It can store up to 5 characters only
);

-- failed (data too long for column orders_status)
INSERT INTO orders VALUES (9,'2013-07-25',116,'PENDING_PAYEMENT');

-- ======================================================================================

DROP TABLE orders;

-- CREATE NEW TABLE
CREATE TABLE orders_items(
    order_item_id INT,
    order_item_order_id INT,
    order_item_product_id INT,
    order_item_quantity INT,
    order_item_subtotal FLOAT,      -- Better to use DECIMAL(20,8)
    order_item_product_price FLOAT  -- Better to use DECIMAL(20,8)
);

-- Insert data into orders_items table
INSERT INTO orders_items VALUES (1, 134, 11599, 2, 800, 400);

-- FLOAT may round decimal values and lose precision
-- Use DECIMAL(20,8) for accurate financial data
INSERT INTO orders_items VALUES (3, 134, 11523, 1, 229.9851, 229.9856);


-- =====================================================================================

DROP TABLE orders_items;

-- Recreate orders_items table using DECIMAL data type for precise values
CREATE TABLE orders_items(
order_item_id int,
order_item_order_id int,
orders_item_product_id int,
order_item_quantity int,
order_item_subtotal decimal(20,5),
order_item_product_price decimal(20,8)
);

-- DECIMAL stores values exactly as provided
-- If fewer decimal places are given, remaining places are filled with zeros
INSERT INTO orders_items VALUES (1, 134, 11523, 1, 229.9851, 229.9856);


/* worked but data truncated (data is too long for column order_item_subtotal 229.985112 its will stores data but only 5 values
but its logically rounding data rather than truncated) but there is some data loss thats why we call  it data truncation */
-- order_item_subtotal column is defined as DECIMAL(20,5)
-- If more than 5 decimal places are provided, extra digits are truncated or rounded
INSERT INTO orders_items VALUES
(3, 134, 11523, 1, 229.985112, 229.9856);

-- ==================================================================================================================================

DROP TABLE orders_items;

# More Examples on Insert
CREATE TABLE orders(
order_id int,
order_date datetime,
customer_id int,
order_status varchar(30)
);

INSERT INTO orders VALUES (1,'2013-07-25 00:00:00.0',11599,'COMPLETED'); -- valid

-- valid even Time is not provided -- default time 00:00:00.0 will append
INSERT INTO orders VALUES (2,'2013-07-25',11599,'COMPLETED'); 

-- Error: Invalid date format (DATE/DATETIME must be in 'YYYY-MM-DD' format)
INSERT INTO orders VALUES (2, '12th july 2025', 11599, 'COMPLETED');


-- Error: DATE/DATETIME values must be enclosed in quotes
INSERT INTO orders VALUES(2, 2013-07-25, 11599, 'COMPLETED');

/*
If a string contains a single quote ('),
we must escape it or use double quotes.
*/

-- Using backslash (\) to escape single quote
INSERT INTO orders VALUES
(2, '2013-07-25', 11599, 'COMPL\'ETED');

-- Using double quotes around the string
INSERT INTO orders VALUES
(2, '2013-07-25', 11599, "COMPL'ETED");

-- If string contains double quote, use single quotes
INSERT INTO orders VALUES
(2, '2013-07-25', 11599, 'COMPL"ETED');


-- ==================================================================================================================
-- show existing tables in the connected database 
show tables;

/*suppose we have orders table and we want to insert some data into orders table so without knowing 
structure/definition of table how we can store a data ? so how do i know the struc/definition of table*/

describe orders;
-- or
desc orders;

-- =======================================================================================
-- Connect to information_schema database
USE information_schema;

/*
If we are connected to a different database
and want to access a table from another database,
we must use fully qualified table name.
*/

-- This will fail because orders table is not in information_schema
SELECT * FROM orders;

-- Use full notation: database_name.table_name
SELECT * FROM retail_db.orders;
-- ==============================================================================================
-- Connect to information_schema
USE information_schema;

/*
Even if we are connected to a different database,
we can create a table in another database
using fully qualified notation: database_name.table_name
*/

-- Creating Table in Another Database Using Full Notation
CREATE TABLE retail_db.customers (
    customer_id INT,
    customer_fname VARCHAR(30),
    customer_lname VARCHAR(30),
    customer_email VARCHAR(30),
    customer_phone VARCHAR(30),
    customer_street VARCHAR(255),
    customer_city VARCHAR(30),
    customer_state VARCHAR(30),
    customer_zipcode VARCHAR(30)
);

-- Connect to Our Database
USE retail_db;

-- Insert Data into All Columns
INSERT INTO customers VALUES
(1, 'Richard', 'Harnandez', 'richard123@gmail.com', '+919960488612', 'bharat nagar pachora', 'pachora', 'maharashtra', '424207');

-- Insert Data into Selected Columns (Optional Fields)
INSERT INTO customers (customer_id, customer_fname, customer_lname, customer_email, customer_phone, customer_city, customer_state, customer_zipcode)
VALUES (2, 'John', 'Doe', 'john@gmail.com', '+911234567890', 'pune', 'maharashtra', '411001');
-- ==================================================================================================================================================

-- Basic DQL Queries (SELECT)
-- View few columns
SELECT customer_id, customer_fname, customer_lname, customer_city
FROM customers;

-- Rename column using alias
SELECT customer_fname AS firstname, customer_id, customer_lname, customer_city
FROM customers;

-- ================================================================================================================================================
 /*
 let say we have excel file of customers csv file so how to insert its data into database , by creating new table 
 */
-- Create Table for Importing CSV / Excel Data
 CREATE TABLE customers(
customer_id int,
customer_fname varchar(30),
customer_lname varchar(30),
customer_email varchar(30),
customer_phone varchar(30),
customer_street varchar(255),
customer_city varchar(30),
customer_state varchar(30),
customer_zipcode varchar(30)
);

-- table data import wizard

select * from customers;

# view number of records are in this table 
select count(*) from customers;

# view limited records
select * from customers limit 5;

# sorting VIEW RECORDS IN DICTIONARY ORDER BY CUSTOMER FNAME
select * from customers order by customer_fname;

# order by in desc/ order
select * from customers order by customer_fname desc;

-- =====================================================================================================================================

# creating new table
CREATE TABLE employees(
employee_id INT,
employee_name VARCHAR(100),
employee_email VARCHAR(100),
employee_phone VARCHAR(15),
city VARCHAR(50),
salary DECIMAL(10,2)
);


INSERT INTO employees (employee_id, employee_name, emplpoyee_email, employee_phone, city, salary) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '555-123-4567', 'New York', 55000.00),
(2, 'Bob Smith', 'bob.smith@example.com', '555-234-5678', 'Los Angeles', 62000.50),
(3, 'Carol White', 'carol.white@example.com', '555-345-6789', 'Chicago', 58000.75),
(4, 'David Brown', 'david.brown@example.com', '555-456-7890', 'Houston', 60000.00),
(5, 'Eva Green', 'eva.green@example.com', '555-567-8901', 'Phoenix', 53000.25),
(6, 'Frank Miller', 'frank.miller@example.com', '555-678-9012', 'Philadelphia', 65000.00),
(7, 'Grace Lee', 'grace.lee@example.com', '555-789-0123', 'San Antonio', 59000.00),
(8, 'Henry Wilson', 'henry.wilson@example.com', '555-890-1234', 'San Diego', 61000.00),
(9, 'Isabel Moore', 'isabel.moore@example.com', '555-901-2345', 'Dallas', 57000.00),
(10, 'Jack Taylor', 'jack.taylor@example.com', '555-012-3456', 'San Jose', 64000.00),
(11, 'Kathy Anderson', 'kathy.anderson@example.com', '555-111-2222', 'Austin', 58000.00),
(12, 'Larry Thomas', 'larry.thomas@example.com', '555-222-3333', 'Jacksonville', 62000.00),
(13, 'Monica Martin', 'monica.martin@example.com', '555-333-4444', 'Fort Worth', 59000.00),
(14, 'Nathan Garcia', 'nathan.garcia@example.com', '555-444-5555', 'Columbus', 61000.00),
(15, 'Olivia Martinez', 'olivia.martinez@example.com', '555-555-6666', 'Charlotte', 63000.00),
(16, 'Paul Robinson', 'paul.robinson@example.com', '555-666-7777', 'San Francisco', 65000.00),
(17, 'Quincy Clark', 'quincy.clark@example.com', '555-777-8888', 'Indianapolis', 58000.00),
(18, 'Rachel Rodriguez', 'rachel.rodriguez@example.com', '555-888-9999', 'Seattle', 62000.00),
(19, 'Steven Lewis', 'steven.lewis@example.com', '555-999-0000', 'Denver', 60000.00),
(20, 'Tina Walker', 'tina.walker@example.com', '555-000-1111', 'Washington', 59000.00),
(21, 'Uma Hall', 'uma.hall@example.com', '555-123-7890', 'Boston', 61000.00),
(22, 'Victor Allen', 'victor.allen@example.com', '555-234-8901', 'El Paso', 62000.00),
(23, 'Wendy Young', 'wendy.young@example.com', '555-345-9012', 'Nashville', 58000.00),
(24, 'Xavier Hernandez', 'xavier.hernandez@example.com', '555-456-0123', 'Detroit', 59000.00),
(25, 'Yvonne King', 'yvonne.king@example.com', '555-567-1234', 'Memphis', 60000.00),
(26, 'Zachary Wright', 'zachary.wright@example.com', '555-678-2345', 'Portland', 63000.00),
(27, 'Amy Scott', 'amy.scott@example.com', '555-789-3456', 'Oklahoma City', 61000.00),
(28, 'Brian Torres', 'brian.torres@example.com', '555-890-4567', 'Las Vegas', 62000.00),
(29, 'Cynthia Nguyen', 'cynthia.nguyen@example.com', '555-901-5678', 'Louisville', 59000.00),
(30, 'Derek Hill', 'derek.hill@example.com', '555-012-6789', 'Baltimore', 58000.00),
(31, 'Ella Flores', 'ella.flores@example.com', '555-111-7890', 'Milwaukee', 60000.00),
(32, 'Fred Rivera', 'fred.rivera@example.com', '555-222-8901', 'Albuquerque', 61000.00),
(33, 'Gina Cooper', 'gina.cooper@example.com', '555-333-9012', 'Tucson', 62000.00),
(34, 'Howard Richardson', 'howard.richardson@example.com', '555-444-0123', 'Fresno', 59000.00),
(35, 'Irene Cox', 'irene.cox@example.com', '555-555-1234', 'Sacramento', 58000.00),
(36, 'Jason Howard', 'jason.howard@example.com', '555-666-2345', 'Mesa', 60000.00),
(37, 'Kelly Ward', 'kelly.ward@example.com', '555-777-3456', 'Kansas City', 61000.00),
(38, 'Liam Brooks', 'liam.brooks@example.com', '555-888-4567', 'Atlanta', 62000.00),
(39, 'Megan Bell', 'megan.bell@example.com', '555-999-5678', 'Omaha', 59000.00),
(40, 'Nick Murphy', 'nick.murphy@example.com', '555-000-6789', 'Colorado Springs', 58000.00),
(41, 'Olga Reed', 'olga.reed@example.com', '555-123-7891', 'Raleigh', 60000.00),
(42, 'Peter Bailey', 'peter.bailey@example.com', '555-234-8902', 'Miami', 61000.00),
(43, 'Quinn Kelly', 'quinn.kelly@example.com', '555-345-9013', 'Long Beach', 62000.00),
(44, 'Rose Morgan', 'rose.morgan@example.com', '555-456-0124', 'Virginia Beach', 59000.00),
(45, 'Sam Patterson', 'sam.patterson@example.com', '555-567-1235', 'Oakland', 58000.00),
(46, 'Tara Jenkins', 'tara.jenkins@example.com', '555-678-2346', 'Minneapolis', 60000.00),
(47, 'Umar Perry', 'umar.perry@example.com', '555-789-3457', 'Tulsa', 61000.00),
(48, 'Vera Powell', 'vera.powell@example.com', '555-890-4568', 'Arlington', 62000.00),
(49, 'Will Foster', 'will.foster@example.com', '555-901-5679', 'New Orleans', 59000.00),
(50, 'Xena Bryant', 'xena.bryant@example.com', '555-012-6780', 'Wichita', 58000.00),
(51, 'Yusuf Simmons', 'yusuf.simmons@example.com', '555-111-7891', 'Cleveland', 60000.00),
(52, 'Zara Jenkins', 'zara.jenkins@example.com', '555-222-8902', 'Tampa', 61000.00),
(53, 'Adam Cole', 'adam.cole@example.com', '555-333-9013', 'Aurora', 62000.00),
(54, 'Beth Evans', 'beth.evans@example.com', '555-444-0124', 'Anaheim', 59000.00),
(55, 'Carl Edwards', 'carl.edwards@example.com', '555-555-1235', 'Santa Ana', 58000.00),
(56, 'Dana Foster', 'dana.foster@example.com', '555-666-2346', 'Riverside', 60000.00),
(57, 'Evan Gray', 'evan.gray@example.com', '555-777-3457', 'Corpus Christi', 61000.00),
(58, 'Fiona Hayes', 'fiona.hayes@example.com', '555-888-4568', 'Lexington', 62000.00),
(59, 'George James', 'george.james@example.com', '555-999-5679', 'Stockton', 59000.00),
(60, 'Holly Kim', 'holly.kim@example.com', '555-000-6780', 'Henderson', 58000.00),
(61, 'Ian Lewis', 'ian.lewis@example.com', '555-123-7892', 'Saint Paul', 60000.00),
(62, 'Jane Martinez', 'jane.martinez@example.com', '555-234-8903', 'St. Louis', 61000.00),
(63, 'Kyle Nelson', 'kyle.nelson@example.com', '555-345-9014', 'Cincinnati', 62000.00),
(64, 'Laura Ortiz', 'laura.ortiz@example.com', '555-456-0125', 'Pittsburgh', 59000.00),
(65, 'Mark Perez', 'mark.perez@example.com', '555-567-1236', 'Greensboro', 58000.00),
(66, 'Nina Quinn', 'nina.quinn@example.com', '555-678-2347', 'Anchorage', 60000.00),
(67, 'Omar Russell', 'omar.russell@example.com', '555-789-3458', 'Plano', 61000.00),
(68, 'Paula Sanchez', 'paula.sanchez@example.com', '555-890-4569', 'Lincoln', 62000.00),
(69, 'Quentin Turner', 'quentin.turner@example.com', '555-901-5670', 'Orlando', 59000.00),
(70, 'Rita Vasquez', 'rita.vasquez@example.com', '555-012-6781', 'Irvine', 58000.00),
(71, 'Sean Walker', 'sean.walker@example.com', '555-111-7892', 'Newark', 60000.00),
(72, 'Tara Young', 'tara.young@example.com', '555-222-8903', 'Toledo', 61000.00),
(73, 'Ulysses Zane', 'ulysses.zane@example.com', '555-333-9014', 'Durham', 62000.00),
(74, 'Vicky Allen', 'vicky.allen@example.com', '555-444-0125', 'Chula Vista', 59000.00),
(75, 'Will Baker', 'will.baker@example.com', '555-555-1236', 'Fort Wayne', 58000.00),
(76, 'Xander Clark', 'xander.clark@example.com', '555-666-2347', 'Jersey City', 60000.00),
(77, 'Yara Davis', 'yara.davis@example.com', '555-777-3458', 'St. Petersburg', 61000.00),
(78, 'Zane Edwards', 'zane.edwards@example.com', '555-888-4569', 'Laredo', 62000.00),
(79, 'Amy Foster', 'amy.foster@example.com', '555-999-5670', 'Madison', 59000.00),
(80, 'Ben Gray', 'ben.gray@example.com', '555-000-6781', 'Chandler', 58000.00),
(81, 'Cara Harris', 'cara.harris@example.com', '555-123-7893', 'Buffalo', 60000.00),
(82, 'Danielle Jones', 'danielle.jones@example.com', '555-234-8904', 'Lubbock', 61000.00),
(83, 'Eli King', 'eli.king@example.com', '555-345-9015', 'Scottsdale', 62000.00),
(84, 'Faye Lewis', 'faye.lewis@example.com', '555-456-0126', 'Glendale', 59000.00),
(85, 'Gavin Martin', 'gavin.martin@example.com', '555-567-1237', 'Reno', 58000.00),
(86, 'Hanna Nelson', 'hanna.nelson@example.com', '555-678-2348', 'Norfolk', 60000.00),
(87, 'Ian Olson', 'ian.olson@example.com', '555-789-3459', 'Winston–Salem', 61000.00),
(88, 'Jade Parker', 'jade.parker@example.com', '555-890-4570', 'North Las Vegas', 62000.00),
(89, 'Kara Quinn', 'kara.quinn@example.com', '555-901-5671', 'Irving', 59000.00),
(90, 'Liam Reed', 'liam.reed@example.com', '555-012-6782', 'Chesapeake', 58000.00),
(91, 'Maya Stewart', 'maya.stewart@example.com', '555-111-7893', 'Gilbert', 60000.00),
(92, 'Nate Turner', 'nate.turner@example.com', '555-222-8904', 'Hialeah', 61000.00),
(93, 'Olivia Vega', 'olivia.vega@example.com', '555-333-9015', 'Garland', 62000.00),
(94, 'Paul Walker', 'paul.walker@example.com', '555-444-0126', 'Fremont', 59000.00),
(95, 'Quinn Young', 'quinn.young@example.com', '555-555-1237', 'Richmond', 58000.00),
(96, 'Rachel Zimmerman', 'rachel.zimmerman@example.com', '555-666-2348', 'Boise', 60000.00),
(97, 'Steve Adams', 'steve.adams@example.com', '555-777-3459', 'San Bernardino', 61000.00),
(98, 'Tina Brooks', 'tina.brooks@example.com', '555-888-4570', 'Spokane', 62000.00),
(99, 'Umar Carter', 'umar.carter@example.com', '555-999-5671', 'Des Moines', 59000.00),
(100, 'Vera Diaz', 'vera.diaz@example.com', '555-000-6782', 'Modesto', 58000.00);

-- Get top 5 employees with highest salary
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;
-- =================================================================================================================
-- TRUNCATE TABLE - DELETE ALL RECORDS FROM TABLE AND RECREATE FRESH TABLE
TRUNCATE TABLE employees;

# DELETE ALL DATA FROM employees TABLE 
DELETE FROM employees WHERE salary > 10000; -- first disable safe mode from setting

-- what covered:
-- DDL (CREATE, TRUNCATE, DROP)
-- DML (INSERT, DELETE)
-- full notation: database_name.table_name
-- HOW TO INSERT DATA FROM EXCEL FILE
-- DESCRIBE, DESC - VIEW TABLE STRUCTURE
-- BASIC SELECT QUERY
-- LIMIT 









