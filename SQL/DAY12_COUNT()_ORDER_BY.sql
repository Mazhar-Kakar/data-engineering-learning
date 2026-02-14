-- ===============================================================================
-- DAY 12 SQL : COUNT(), ORDER BY
-- ===============================================================================

/*
COUNT():
	- This is an aggregate function
    - Used to count number of records (rows)
    - Can count all rows or rows based on a condition or column

ORDER BY CLAUSE: 
	- Used to sort the result of a query
    - ASC  = ascending order (small to large)  [default]
    - DESC = descending order (large to small)
    - Can sort using one or more columns
*/

-- =================================================================================
-- COUNT TOTAL RECORDS IN A TABLE
-- =================================================================================
SELECT COUNT(*) FROM customers;

-- =================================================================================
-- Find COUNT of customers from customer_state = 'CA' (California)
-- =================================================================================
SELECT COUNT(*) AS total_customers 
FROM customers
WHERE customer_state = 'CA';

-- This query gives same result as above
SELECT COUNT(1) AS total_customers 
FROM customers
WHERE customer_state = 'CA';

-- =================================================================================
-- Find COUNT of employees WHERE salary > 15000
-- =================================================================================
SELECT COUNT(salary) AS total_employees
FROM employees 
WHERE salary > 15000;

-- NOTE:
-- COUNT(column_name) counts only NON-NULL values

-- =================================================================================
-- Find COUNT of employees who have a manager
-- =================================================================================
SELECT COUNT(manager_id) AS total_with_manager
FROM employees;

-- manager_id NULL means employee has no manager
-- so COUNT(manager_id) counts only employees having manager_id

-- =================================================================================
-- COUNT employees whose salary is greater than 50K
-- =================================================================================
SELECT COUNT(employee_id) 
FROM employees 
WHERE salary > 50000;

-- Different COUNT types:
-- COUNT(*)           → counts all rows
-- COUNT(1)           → same as COUNT(*)
-- COUNT(column_name) → counts non-NULL values only

-- ===============================================================================
-- ORDER BY
-- ===============================================================================

-- ===============================================================================
-- Sort employees based on salary (default ASC)
-- ===============================================================================
SELECT * 
FROM employees 
ORDER BY salary;

-- ===============================================================================
-- Descending order
-- ===============================================================================
SELECT * 
FROM employees 
ORDER BY salary DESC;

-- ===============================================================================
-- Top 5 employees with highest salary
-- ===============================================================================
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;

-- ===============================================================================
-- Sort using two columns:
-- First by salary DESC, then department_id ASC
-- ===============================================================================
SELECT * 
FROM employees 
ORDER BY salary DESC, department_id 
LIMIT 5;

-- ===============================================================================
-- ORDER BY works even if column is not selected
-- ===============================================================================
SELECT first_name, last_name, manager_id 
FROM employees
ORDER BY salary DESC;
-- salary is used for sorting but not shown in result

-- ===============================================================================
-- DERIVED COLUMN (CALCULATED COLUMN)
-- ===============================================================================

-- ===============================================================================
-- Create new column: salary increased by 10%
-- ===============================================================================
SELECT *, salary + salary * 0.1 AS revised_salary
FROM employees 
ORDER BY salary DESC;

-- ===============================================================================
-- Sort using derived column alias
-- ===============================================================================
SELECT *, salary + salary * 0.1 AS revised_salary
FROM employees 
ORDER BY revised_salary DESC;

-- ===============================================================================
-- Sorting using expression without showing it
-- ===============================================================================
SELECT * 
FROM employees 
ORDER BY salary + salary * 0.1 DESC;

-- ===============================================================================
-- Show calculated column in result
-- ===============================================================================
SELECT *, salary + salary * 0.1 AS revised_salary
FROM employees 
ORDER BY salary + salary * 0.1 DESC;

-- ==========================================================================================================
/*
What we covered so far:
AGGREGATION & SORTING:
	- COUNT() Aggregate Function
	- COUNT(*), COUNT(1), COUNT(column_name)
	- Counting records with conditions using WHERE clause
	- ORDER BY Clause
	- ASC (Ascending) and DESC (Descending) sorting
	- Sorting using multiple columns
	- Using expressions and derived columns in ORDER BY
*/


