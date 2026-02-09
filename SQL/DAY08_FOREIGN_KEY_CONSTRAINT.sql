-- ====================================================
-- DAY 08 SQL : FOREIGN KEY CONSTRAINT
-- ====================================================

/*
FOREIGN KEY:
- A FOREIGN KEY is used to connect two tables.
- It creates a relationship between tables.
- It helps keep data correct and valid.

Example:
- customers.customer_id → PRIMARY KEY (parent table)
- orders.customer_id    → FOREIGN KEY (child table)

This is called ONE TO MANY relationship:
- One customer can have many orders
- But each order belongs to only one customer
*/

-- ====================================================
-- CREATE CUSTOMER TABLE (PARENT TABLE)
-- ====================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,      -- unique + not null customer id
    customer_fname VARCHAR(50),
    customer_lname VARCHAR(50)
);

-- ====================================================
-- CREATE ORDERS TABLE (CHILD TABLE)
-- ====================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,          -- unique + not null order id
    order_date DATE,
    customer_id INT,
    CONSTRAINT FK_customer_id
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- ====================================================
-- FOREIGN KEY USING ALTER COMMAND
-- ====================================================

-- Add FOREIGN KEY later USI
ALTER TABLE orders
ADD CONSTRAINT FK_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- Drop FOREIGN KEY
ALTER TABLE orders DROP CONSTRAINT FK_customer_id;

-- ====================================================
-- INVALID INSERT (NO CUSTOMER EXISTS)
-- ====================================================

-- Fails because customer table is empty
INSERT INTO orders (order_id, order_date, customer_id)
VALUES (101, '2023-07-10', 1);

/*
ERROR:
22:22:19INSERT INTO orders (order_id, order_date, customer_id) VALUES (101,'2023-07-10',1)	Error Code: 1452. 
Cannot add or update a child row: a foreign key constraint fails 
(`retail_db`.`orders`, CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))	0.0019 sec

Reason:
- customer_id = 1 does not exist in customers table
- Order cannot exist without customer

Rule:
Parent row must exist before child row
*/

-- ====================================================
-- VALID INSERT ORDER
-- ====================================================

-- Insert customer first
INSERT INTO customers (customer_id, customer_fname, customer_lname)
VALUES (1, 'Raaj', 'Dev');

-- Then insert order
INSERT INTO orders (order_id, order_date, customer_id)
VALUES (101, '2023-07-10', 1);

-- ====================================================
-- ON DELETE CASCADE / ON UPDATE CASCADE
-- ====================================================

/*
Problem:
- IF I DELETED customer record from customers table. so order record related to that customer will become irrelevent in orders table.
- and in other scanrio if i try to delet customer record from customer table FOREIGN KEY CONSTRAINT violate it.
- To solve this problem we use CASCADE. means when we DELETE, UPDATE somthing in customers table (Parent) it will also reflect to orders table (Child).

Solution:
Use CASCADE
- ON DELETE CASCADE → delete child records automatically
- ON UPDATE CASCADE → update child records automatically
*/

-- TO Add ON DELETE CASCADE ON UPDATE CASCADE:
-- Drop existing foreign key
ALTER TABLE orders DROP CONSTRAINT FK_customer_id;

-- Add foreign key with CASCADE
ALTER TABLE orders
ADD CONSTRAINT FK_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ====================================================
-- TEST CASCADE
-- ====================================================

-- Delete customer
DELETE FROM customers WHERE customer_id = 1;

-- Orders related to this customer are also deleted
SELECT * FROM customers;
SELECT * FROM orders;

-- ====================================================
-- ONE TO MANY RELATION SUMMARY
-- ====================================================
-- customers → orders
-- one customer → many orders

-- ====================================================
-- MANY TO MANY RELATION EXAMPLE
-- ====================================================

/*
-- customers and orders table have One to Many Relation
-- Lets Take Another Example:
-- Many to Many Relation:
-- eg. CREATE students table where store student detail
-- CREATE courses table where course detail
-- CREATE enrollement table and show Relation in enrollment table
-- means one student can purchase many courses and one course can be purchased by many students
*/
-- CREATE new table students
CREATE TABLE students (
student_id INT PRIMARY KEY,
student_fname VARCHAR(50),
student_lname VARCHAR(50)
);

-- insert student record into student table
INSERT INTO students (student_id, student_fname, student_lname) 
VALUES (1,'raaj','wagle');

CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(100)
);

-- insert course record into courses table
INSERT INTO courses (course_id, course_name)
VALUES (101,'datascience');

-- CREATE new table enrollements and use two FOREIGN KEYs, show relation
-- Use Composit primary key, so student id and course id will be unique no duplicate records
CREATE TABLE enrollements (
student_id INT,
course_id INT,
enrollement_date DATE,
PRIMARY KEY (student_id, course_id),
CONSTRAINT FOREIGN_KEY_STUDENTID FOREIGN KEY (student_id) REFERENCES students (student_id),
CONSTRAINT FOREIGN_KEY_COURSEID FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

-- To add ON CASCADE first DROP existing FOREIGN KEYs
ALTER TABLE enrollements DROP CONSTRAINT FOREIGN_KEY_STUDENTID, DROP CONSTRAINT FOREIGN_KEY_COURSEID;

-- ADD ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE enrollements ADD CONSTRAINT FOREIGN_KEY_STUDENTID FOREIGN KEY (student_id) REFERENCES students (student_id), 
ADD CONSTRAINT FOREIGN_KEY_COURSEID FOREIGN KEY (course_id) REFERENCES courses (course_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- worked: student_id 1 and course_id 101 exists in students and courses table 
INSERT INTO enrollements (student_id, course_id, enrollement_date)
VALUES (1,101,'2025-07-07');

-- failed: duplicate records composit key violate
INSERT INTO enrollements (student_id, course_id, enrollement_date)
VALUES (1,101,'2025-07-07');

-- failed: student_id = 2 does'not exist in student table 
INSERT INTO enrollements (student_id, course_id, enrollement_date)
VALUES (2,101,'2025-07-07');  

-- ====================================================
-- SELF REFERENCING FOREIGN KEY
-- ====================================================

/*
Self-referencing foreign key:
- A table refers to itself
- example: employee and manager

manager_id stores employee_id of manager
*/

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_fname VARCHAR(50),
    employee_lname VARCHAR(50),
    manager_id INT,
    CONSTRAINT FK_self_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert manager first
INSERT INTO employees VALUES (101, 'Sumit', 'Jain', NULL);

-- Insert employee under manager
INSERT INTO employees VALUES (1, 'Raaj', 'Jain', 101);

-- failed: Manager does not exist
INSERT INTO employees VALUES (2, 'Amit', 'Sharma', 102);

-- Employee without manager
INSERT INTO employees VALUES (5, 'Neha', 'Patel', NULL);

-- employee_id cannot be NULL
INSERT INTO employees VALUES (NULL, 'Test', 'User', 101);

-- ====================================================
-- WHAT WE HAVE LEARNED SO FAR
-- ====================================================
/*
✔ FOREIGN KEY
✔ ONE TO MANY
✔ MANY TO MANY
✔ SELF REFERENCING FOREIGN KEY
*/
