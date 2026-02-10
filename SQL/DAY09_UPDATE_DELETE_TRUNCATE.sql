-- ====================================================
-- DAY 09 SQL : UPDATE, DELETE, TRUNCATE
-- ====================================================

-- UPDATE, DELETE are DML commands
-- UPDATE: Used to modify existing data (rows) in a table
-- DELETE: Used to delete data from a table (we can use a WHERE clause)

USE retail_db;

-- Create new table customers (data imported from CSV)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_fname VARCHAR(30),
    customer_lname VARCHAR(30),
    customer_email VARCHAR(30),
    cusotmer_phone VARCHAR(30),
    customer_street VARCHAR(255),
    customer_city VARCHAR(30),
    customer_state VARCHAR(30),
    customer_zipcode VARCHAR(30)
);
-- Data inserted manually / successfully

SELECT * FROM customers;

-- Count total records in the table
SELECT COUNT(*) AS total_records FROM customers;
-- COUNT() is an aggregate function

-- ===================================================================
-- Change address of customer where customer_id = 2
-- ===================================================================
/*
customer_street = '7869 Crystal View Villas'
customer_city   = 'Brooklyn'
customer_state  = 'NY'
*/

UPDATE customers
SET customer_street = '7869 Crystal View Villas',
    customer_city   = 'Brooklyn',
    customer_state  = 'NY'
WHERE customer_id = 2;

SELECT * FROM customers;

-- Always use a WHERE condition with UPDATE
-- Without a WHERE clause, ALL records in the table will be UPDATED (not deleted)
-- Best practice: keep safe update/delete mode ON

UPDATE customers
SET customer_street = '7869 Crystal View Villas',
    customer_city   = 'Brooklyn',
    customer_state  = 'NY';
-- This can be rolled back (if AUTOCOMMIT is OFF), but it is risky

/*
ERROR: UPDATE customers SET customer_street = '7869 Crystal View Villas', customer_city = 'Brooklyn', customer_state = 'NY'	
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.00069 sec
*/

-- Undo last UPDATE (only works if AUTOCOMMIT is OFF)
ROLLBACK;

-- ===================================================================
-- DELETE customer from table where customer_id = 7
-- ===================================================================

-- DELETE command removes data (rows) based on a condition
DELETE FROM customers
WHERE customer_id = 7;

-- Save changes permanently
COMMIT;

-- This command will DELETE ALL data from customers table
DELETE FROM customers;

-- Rollback possible (if AUTOCOMMIT is OFF)
ROLLBACK;

-- ==============================================================================================
-- TRUNCATE customers TABLE - ROLLBACK WILL NOT WORK
-- ==============================================================================================

-- TRUNCATE is a table-level DDL command
-- It deletes ALL data from the table
-- ROLLBACK does NOT work because DDL commands have implicit COMMIT
-- Always be careful before running TRUNCATE

TRUNCATE TABLE customers;

-- ========================================================
-- DIFFERENCE BETWEEN UPDATE AND ALTER
-- ========================================================
-- UPDATE: DML Command                      | ALTER: DDL Command
-- Modify existing data inside the table   | Modify table definition / structure
-- Row-level operation                    | Table-level operation
-- Rollback possible                      | Rollback NOT possible
-- ---------------------------------------------------------------------------------

-- ===========================================================================================
-- DELETE vs TRUNCATE
-- ===========================================================================================
-- BOTH are used to remove data, but:

-- DELETE:
--  - DML command
--  - WHERE condition can be used
--  - Rollback possible (if AUTOCOMMIT is OFF)
--  - Slower (deletes rows one by one)

-- TRUNCATE:
--  - DDL command
--  - WHERE condition not allowed
--  - Rollback NOT possible
--  - Very fast
--  - Works like DROP + CREATE internally
--  - Uses implicit COMMIT

DELETE FROM customers;     -- Can be rolled back
ROLLBACK;

TRUNCATE TABLE customers; -- Cannot be rolled back
SELECT * FROM customers;

-- ===================================================================
/*
WHAT WE HAVE COVERED SO FAR:
- UPDATE command
- UPDATE vs ALTER
- DELETE command
- TRUNCATE command
- DELETE vs TRUNCATE
*/
