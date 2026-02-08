-- ============================================================
-- Day08 SQL : UNIQUE, DEFAULT & AUTO_INCREMENT Constraints
-- ============================================================

/*
Constraints are rules applied on columns
to keep data correct, clean, and reliable.
*/

-- ============================================================
-- UNIQUE Constraint
-- ============================================================

/*
UNIQUE constraint means:
- Values must be unique
- Duplicate values are NOT allowed
- NULL values are allowed (in MySQL)
*/

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_fname VARCHAR(30) NOT NULL,
    customer_lname VARCHAR(30) NOT NULL,
    customer_email VARCHAR(30) UNIQUE,
    customer_phone VARCHAR(30) UNIQUE,
    customer_street VARCHAR(255),
    customer_city VARCHAR(30) NOT NULL,
    customer_state VARCHAR(30) NOT NULL,
    customer_zipcode VARCHAR(30)
);

-- Worked
INSERT INTO customers VALUES
(1,'Richard','Harnandez','richard123@gmail.com',
 '+919960488612','bharat nagar','pachora','maharashtra','424207');

-- Failed: duplicate email and phone (UNIQUE constraint)
INSERT INTO customers
(customer_id, customer_fname, customer_lname, customer_email, customer_phone,
 customer_city, customer_state, customer_zipcode)
VALUES
(2,'Maaz','Kakar','richard123@gmail.com',
 '+919960488612','pachora','maharashtra','424207');

-- Worked: UNIQUE columns allow NULL
INSERT INTO customers
(customer_id, customer_fname, customer_lname, customer_email, customer_phone,
 customer_city, customer_state, customer_zipcode)
VALUES
(3,'Maaz','Kakar',NULL,NULL,'pachora','maharashtra','424207');

-- ============================================================
-- PRIMARY KEY vs UNIQUE (Interview Notes)
-- ============================================================

/*
-- ex. employee 
-- employee_id PRIMARY KEY
-- fname NOT NULL 
-- lname NOT NULL
-- hire_date

-- USERS
-- user_id PRIMARY KEY
-- user_name UNQIUE
-- email UNIQUE
-- password CHECK

INTERVIEW QUESTIONS -
PRIMARY KEY:
- Only one per table
- Cannot be NULL
- Cannot be duplicate
- PRIMARY KEY = UNIQUE + NOT NULL

UNIQUE:
- Can be multiple in one table
- Allows NULL values
*/

-- ============================================================
-- DEFAULT Constraint
-- ============================================================

/*
DEFAULT constraint:
- Inserts a default value if no value is provided
- Helps maintain data consistency
*/

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_fname VARCHAR(50),
    employee_lname VARCHAR(50),
    hire_date DATE,
    status VARCHAR(10) DEFAULT 'active'
);

-- Failed: column count mismatch
INSERT INTO employees
(employee_id, employee_fname, employee_lname, hire_date, status)
VALUES (1,'Raj','Gujarati','2025-10-12');

-- Worked: DEFAULT value applied
INSERT INTO employees
(employee_id, employee_fname, employee_lname, hire_date)
VALUES (1,'Raj','Gujarati','2025-10-12');

-- Worked: manual value overrides default
INSERT INTO employees
(employee_id, employee_fname, employee_lname, hire_date, status)
VALUES (2,'Raj','Gujarati','2025-10-12','inactive');

-- Worked: DEFAULT keyword
INSERT INTO employees
(employee_id, employee_fname, employee_lname, hire_date, status)
VALUES (3,'Raj','Gujarati','2025-10-12',DEFAULT);

-- NULL also allowed (if NOT NULL not applied)
INSERT INTO employees
(employee_id, employee_fname, employee_lname, hire_date, status)
VALUES (4,'Raj','Gujarati','2025-10-12',NULL);

SELECT * FROM employees;

-- ============================================================
-- DEFAULT with CURRENT_DATE
-- ============================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- Default current date inserted
INSERT INTO orders (order_id, customer_id, product_id, quantity)
VALUES (1,101,1201,5);

-- Using DEFAULT keyword
INSERT INTO orders
(order_id, customer_id, product_id, quantity, order_date)
VALUES (2,101,1201,5,DEFAULT);

-- Manual date
INSERT INTO orders
(order_id, customer_id, product_id, quantity, order_date)
VALUES (3,101,1201,5,'2025-12-10');

-- ============================================================
-- DEFAULT Example (Country)
-- ============================================================

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_fname VARCHAR(50),
    user_lname VARCHAR(50),
    country VARCHAR(50) DEFAULT 'USA'
);

-- DEFAULT value applied
INSERT INTO users (user_id, user_fname, user_lname)
VALUES (1,'Sumit','Mittal');

-- ============================================================
-- AUTO_INCREMENT
-- ============================================================

/*
AUTO_INCREMENT:
- Automatically generates numbers
- Mostly used with PRIMARY KEY
- Saves manual work
*/

CREATE TABLE employees_auto (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_fname VARCHAR(50),
    employee_lname VARCHAR(50),
    hire_date DATE,
    status VARCHAR(10) DEFAULT 'active'
);

-- Manual ID
INSERT INTO employees_auto
(employee_id, employee_fname, employee_lname, hire_date)
VALUES (1,'Raj','Gujarati','2025-10-12');

-- Auto generated ID (2)
INSERT INTO employees_auto
(employee_fname, employee_lname, hire_date)
VALUES ('Raj','Gujarati','2025-10-12');

-- Failed: wrong column order
INSERT INTO employees_auto
(employee_id, employee_fname, employee_lname)
VALUES ('Raj','Gujarati','2025-10-12');

-- Manual ID (allowed but risky)
INSERT INTO employees_auto
(employee_id, employee_fname, employee_lname, hire_date)
VALUES (7,'Raj','Gujarati','2025-10-12');

-- Next auto value will be 8
INSERT INTO employees_auto
(employee_fname, employee_lname, hire_date)
VALUES ('Raj','Gujarati','2025-10-12');

-- ============================================================
-- Change AUTO_INCREMENT Starting Value
-- ============================================================

ALTER TABLE employees_auto AUTO_INCREMENT = 1000;

-- Increase auto increment by 2 (1000,1002,1004...)
SET @@auto_increment_increment = 2;

-- NOTE:
-- Only ONE AUTO_INCREMENT column allowed per table

-- ============================================================
-- What We covered 
-- ============================================================

/*
✔ UNIQUE constraint
✔ Difference between PRIMARY KEY and UNIQUE
✔ DEFAULT constraint
✔ CURRENT_DATE default
✔ AUTO_INCREMENT
✔ How AUTO_INCREMENT works internally
*/