-- ============================================================
-- Day06 SQL : Constraints (CHECK CONSTRAINT AND ALTER TABLE)
-- ============================================================

/*
SQL Constraints are rules applied to table columns
to ensure accuracy, validity of data.

Constraints help prevent invalid or inconsistent data
from being inserted into the database.
*/

-- ============================================================
-- When can we define constraints?
-- ============================================================

/*
1) While creating a table
2) Later using ALTER TABLE
*/

-- ============================================================
-- Types of Constraints (focus: CHECK)
-- ============================================================

/*
CHECK constraint limits the values that can be stored
in a column based on a condition.
*/

-- ============================================================
-- Create Orders Table (No Constraints Initially)
-- ============================================================

CREATE TABLE orders (
    order_id INT,
    order_item_id INT,
    order_date DATE,
    customer_id INT,
    order_status VARCHAR(20),
    product_id INT,
    quantity INT,
    product_price FLOAT,
    total_price FLOAT
);

-- ============================================================
-- Problem: Invalid order_status values are allowed
-- ============================================================

/*
Allowed status values should be ONLY:
CLOSED
PENDING_PAYMENT
COMPLETE
PROCESSING
ON_HOLD
SUSPECTED_FRAUD
PENDING
*/

-- Invalid value gets inserted because no constraint exists
INSERT INTO orders VALUES
(1,101,'2025-01-01',10,'CLOSE',501,2,19.99,39.98);
select * from orders;
-- ============================================================
-- Add CHECK Constraint using ALTER TABLE
-- ============================================================

ALTER TABLE orders
ADD CHECK (
    order_status IN (
        'CLOSED',
        'PENDING_PAYMENT',
        'COMPLETE',
        'PROCESSING',
        'ON_HOLD',
        'SUSPECTED_FRAUD',
        'PENDING'
    )
);

/*
20:55:41	ALTER TABLE orders ADD CHECK (order_status IN ('CLOSED'PENDING_PAYMENT'COMPLETE'PROCESSING'ON_HOLD',         'SUSPECTED_FRAUD',         'PENDING'     ) )	
Error Code: 3819. Check constraint 'orders_chk_1' is violated.	0.013 sec
*/

-- Before adding a CHECK constraint,
-- make sure existing data does NOT contain invalid values.
-- If mismatched values exist, the ALTER TABLE command will fail.
-- So first UPDATE or DELETE incorrect records, then add the constraint.

-- This will fail becouse of check constraint
INSERT INTO orders VALUES
(2,102,'2025-01-02',11,'CLOSE',502,1,15.50,15.50);

-- This will work
INSERT INTO orders VALUES
(3,103,'2025-01-03',12,'CLOSED',503,2,12.00,24.00);

-- ============================================================
-- View Constraint Name and Table Definition
-- ============================================================

SHOW CREATE TABLE orders;

-- ============================================================
-- Drop CHECK Constraint (using system-generated name)
-- ============================================================

ALTER TABLE orders DROP CHECK orders_chk_1;

-- ============================================================
-- Add Named CHECK Constraint
-- ============================================================

ALTER TABLE orders
ADD CONSTRAINT chk_order_status
CHECK (
    order_status IN (
        'CLOSED',
        'PENDING_PAYMENT',
        'COMPLETE',
        'PROCESSING',
        'ON_HOLD',
        'SUSPECTED_FRAUD',
        'PENDING'
    )
);

-- Drop named constraint
ALTER TABLE orders DROP CHECK chk_order_status;

-- ============================================================
-- View CHECK Constraints using information_schema
-- ============================================================

USE information_schema;

SELECT *
FROM CHECK_CONSTRAINTS;

-- ============================================================
-- Define Constraints During Table Creation
-- ============================================================

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT,
    order_item_id INT,
    order_date DATE,
    customer_id INT,
    order_status VARCHAR(20)
        CONSTRAINT chk_order_status
        CHECK (
            order_status IN (
                'CLOSED',
                'PENDING_PAYMENT',
                'COMPLETE',
                'PROCESSING',
                'ON_HOLD',
                'SUSPECTED_FRAUD',
                'PENDING'
            )
        ),
    product_id INT,
    quantity INT,
    product_price FLOAT,
    total_price FLOAT
);

-- ============================================================
-- CHECK Constraint on Quantity (<= 50)
-- ============================================================

DROP TABLE orders;

CREATE TABLE orders (
    order_id INT,
    order_item_id INT,
    order_date DATE,
    customer_id INT,
    order_status VARCHAR(20)
        CHECK (
            order_status IN (
                'CLOSED',
                'PENDING_PAYMENT',
                'COMPLETE',
                'PROCESSING',
                'ON_HOLD',
                'SUSPECTED_FRAUD',
                'PENDING'
            )
        ),
    product_id INT,
    quantity INT
        CONSTRAINT chk_quantity_limit
        CHECK (quantity <= 50),
    product_price FLOAT,
    total_price FLOAT
);

-- Quantity greater than 50 → fails
INSERT INTO orders VALUES
(1,101,'2025-01-01',10,'CLOSED',501,52,19.99,39.98);

-- Valid quantity
INSERT INTO orders VALUES
(2,102,'2025-01-02',11,'CLOSED',502,50,15.50,775.00);

-- ============================================================
-- CHECK Constraint Example: Age > 0
-- ============================================================

CREATE TABLE persons (
    person_id INT,
    fname VARCHAR(50),
    lname VARCHAR(50),
    age INT CHECK (age > 0)
);

-- Invalid age
INSERT INTO persons VALUES (1,'Mazhar','Kakar',-15);

-- Valid age
INSERT INTO persons VALUES (2,'Mazhar','Kakar',19);

-- ============================================================
-- CHECK Constraint on Email Pattern
-- ============================================================

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    CHECK (email LIKE '%@%.%') -- Pattern matching using the LIKE operator
);

-- Invalid email
INSERT INTO users VALUES (1,'mazhar','mazharkakar.gmail.com');

-- Valid email
INSERT INTO users VALUES (2,'mazhar','mazharkakar@gmail.com');

-- ============================================================
-- CHECK Constraint with Date Comparison
-- ============================================================

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    CHECK (end_date >= start_date)
);

-- End date before start date
INSERT INTO projects VALUES
(1,'Data Science Project','2025-09-12','2025-09-11');

-- Valid dates
INSERT INTO projects VALUES
(2,'Data Science Project','2025-09-12','2025-09-12');

-- ============================================================
-- What We covered
-- ============================================================

/*
✔ What SQL constraints are
✔ Why constraints are important
✔ CHECK constraint with multiple scenarios
✔ Adding constraints using ALTER
✔ Naming constraints
✔ Viewing constraints using information_schema
✔ Constraints during table creation
✔ Data validation using CHECK
*/
