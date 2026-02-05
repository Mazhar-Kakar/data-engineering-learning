-- DAY03 SQL : DCL (Data Control Language) & TCL (Transaction Control Language)
-- ============================================================================

/*
SQL Command Categories:

DDL - CREATE, ALTER, DROP, TRUNCATE
DML - INSERT, UPDATE, DELETE
DQL - SELECT
DCL - GRANT, REVOKE
TCL - COMMIT, ROLLBACK, SAVEPOINT
*/

-- ============================================================================

-- DCL (Data Control Language)
-- Used to control access and permissions on database objects

/*
VIEW:

A view is a virtual table based on the result of a SQL query.
It does not store data physically.
It always shows data from underlying tables.
Used for:
- Security (limit columns/rows)
- Simplicity
- Hiding complexity
- presenting data in a specific format
*/

-- Create a view to expose limited customer data
CREATE VIEW customers_v AS
SELECT customer_id, customer_fname, customer_lname, customer_city, customer_state, customer_zipcode
FROM customers;

-- ============================================================================

-- Create a new user
CREATE USER 'z2infotech'@'localhost' IDENTIFIED BY 'z2infotech123';

-- Grant read access only on view
GRANT SELECT ON retail_db.customers_v TO 'z2infotech'@'localhost';

-- Revoke SELECT permission
REVOKE SELECT ON retail_db.customers_v FROM 'z2infotech'@'localhost';

-- Grant more permissions on customers table
GRANT SELECT, DELETE, DROP ON retail_db.customers TO 'z2infotech'@'localhost';

-- After granting, user can run:
DELETE FROM customers WHERE customer_id = 1;
DROP TABLE customers;

-- Revoke DROP permission
REVOKE DROP ON retail_db.customers FROM 'z2infotech'@'localhost';

-- Drop user
DROP USER 'z2infotech'@'localhost';

-- ============================================================================

-- Using information_schema to view metadata
USE information_schema;

SHOW TABLES;

-- View all tables of retail_db
SELECT *
FROM TABLES
WHERE table_schema = 'retail_db';

-- ============================================================================

-- TCL (Transaction Control Language)
-- Used to manage transactions

SELECT * FROM employees;

-- Delete record (transaction starts)
DELETE FROM employees WHERE employee_id = 100;

-- COMMIT saves the changes
COMMIT;

-- ROLLBACK cancels changes since last commit
ROLLBACK;

-- Example
DELETE FROM employees WHERE employee_id = 2;
ROLLBACK;   -- record restored

-- Only DML commands can be rolled back
-- INSERT, UPDATE, DELETE

-- ============================================================================

/*
Transaction OPEN State:

When DML commands are executed and COMMIT or ROLLBACK
is not yet issued, the transaction is in OPEN state.

In OPEN state:
- Changes are not permanent
- Only visible to current session
- Can still be rolled back
*/

-- ============================================================================

