-- ============================================================
-- Day07 SQL : NOT NULL & PRIMARY KEY/COMPOSITE PRIMARY KEY Constraints
-- ============================================================

/*
Constraints are rules applied on table columns
to keep data correct and clean.
*/

-- ============================================================
-- NOT NULL Constraint
-- ============================================================

/*
NOT NULL constraint means:
- Column cannot store NULL value
- Value is mandatory
*/

CREATE TABLE orders (
    order_id INT NOT NULL,
    order_item_id INT NOT NULL,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    product_price FLOAT NOT NULL,
    total_price FLOAT NOT NULL
);

-- Failed: other NOT NULL columns are missing
INSERT INTO orders (order_id) VALUES (1);

-- Worked: all NOT NULL columns provided
INSERT INTO orders VALUES
(1,101,'2025-01-01',10,'CLOSED',501,2,19.99,39.98);

-- ============================================================
-- PRIMARY KEY Constraint
-- ============================================================

/*
PRIMARY KEY:
- Uniquely identifies each row
- Cannot be NULL
- Cannot have duplicate values

PRIMARY KEY = NOT NULL + UNIQUE
*/

CREATE TABLE customers (
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

INSERT INTO customers VALUES
(1,'Richard','Harnandez','richard123@gmail.com',
 '+919960488612','bharat nagar','pachora','maharashtra','424207');

-- Add PRIMARY KEY using ALTER
ALTER TABLE customers ADD PRIMARY KEY (customer_id);

-- Drop PRIMARY KEY
ALTER TABLE customers DROP PRIMARY KEY;

-- ============================================================
-- PRIMARY KEY Rules Examples
-- ============================================================

-- Failed: customer_id cannot be NULL
INSERT INTO customers
(customer_fname, customer_lname, customer_email)
VALUES ('John','Doe','john@gmail.com');

-- Failed: duplicate primary key value
INSERT INTO customers VALUES
(1,'John','Doe','john@gmail.com',
 '+911234567890','street','city','state','123456');

-- Worked: unique customer_id
INSERT INTO customers VALUES
(2,'John','Doe','john@gmail.com',
 '+911234567890','street','city','state','123456');

DELETE FROM customers WHERE customer_id = 2;

-- ============================================================
-- Check PRIMARY KEY using INFORMATION_SCHEMA
-- ============================================================

SELECT *
FROM information_schema.TABLE_CONSTRAINTS
WHERE table_name = 'customers';  -- Check PRIMARY KEY using INFORMATION_SCHEMA

-- ============================================================
-- PRIMARY KEY While Creating Table
-- ============================================================

DROP TABLE customers;

-- Column-level primary key
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_fname VARCHAR(30),
    customer_lname VARCHAR(30),
    customer_email VARCHAR(30),
    customer_phone VARCHAR(30)
);

DROP TABLE customers;

-- Table-level primary key
CREATE TABLE customers (
    customer_id INT,
    customer_fname VARCHAR(30),
    customer_lname VARCHAR(30),
    customer_email VARCHAR(30),
    customer_phone VARCHAR(30),
    PRIMARY KEY (customer_id)
);

-- ============================================================
-- COMPOSITE PRIMARY KEY
-- ============================================================

/*
Composite Key:
- Primary key made using more than one column
- Combination must be unique
*/

-- Invalid: multiple PRIMARY KEY not allowed
CREATE TABLE order_items (
    order_id INT PRIMARY KEY,
    product_id INT PRIMARY KEY,
    quantity INT
);

-- Correct way: composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

-- Failed: duplicate combination (1,102)
INSERT INTO order_items VALUES
(1,102,2),
(1,102,3);

-- Worked: unique combination
INSERT INTO order_items VALUES
(1,102,2),
(1,103,3),
(2,102,5),
(2,104,8);

-- ============================================================
-- Why Composite Key is Useful
-- ============================================================

/*
✔ Prevent duplicate product in same order
✔ Avoid double billing
✔ Keep order data clean
✔ Allow same product in different orders
*/

-- ============================================================
-- What We covered 
-- ============================================================

/*
✔ NOT NULL constraint
✔ PRIMARY KEY constraint
✔ PRIMARY KEY using ALTER
✔ Column-level vs table-level PRIMARY KEY
✔ Composite PRIMARY KEY
✔ How PRIMARY KEY prevents duplicate data
*/
