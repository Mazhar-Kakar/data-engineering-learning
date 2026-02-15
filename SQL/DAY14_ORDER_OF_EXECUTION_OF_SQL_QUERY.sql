-- ===============================================================================
-- DAY 14 SQL : ORDER OF EXECUTION OF QUERY
-- ===============================================================================

/*
SQL does NOT run query from top to bottom.
There is an internal execution order.

ACTUAL ORDER OF EXECUTION:

FROM       → Load table data
WHERE      → Filter rows
SELECT     → Choose columns / create derived columns
DISTINCT   → Remove duplicate rows
ORDER BY   → Sort result
LIMIT      → Restrict number of rows
*/

-- ===============================================================================
-- DISTINCT + ORDER BY ISSUE
-- ===============================================================================

-- BELOW QUERY WILL NOT WORK
SELECT DISTINCT source_of_joining 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 5;

/*
Reason:
DISTINCT keeps only columns present in SELECT.
Here we selected only source_of_joining,
but ORDER BY is using years_of_exp.

After DISTINCT step, years_of_exp column is not available.
So MySQL throws error.
*/

-- WORKING QUERY (NO DISTINCT)
SELECT source_of_joining 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 5;

-- WORKING WHEN ORDER COLUMN IS ALSO SELECTED
SELECT DISTINCT source_of_joining, years_of_exp
FROM students
WHERE location IN ('Bangalore','Hyderabad')
ORDER BY years_of_exp DESC
LIMIT 5;

-- ===============================================================================
-- SIMPLE EXECUTION FLOW EXAMPLE
-- ===============================================================================

SELECT student_fname
FROM students
WHERE years_of_exp > 9;

/*
Execution Flow:

FROM students           → full table loaded
WHERE years_of_exp > 9  → rows filtered
SELECT student_fname    → only required column returned
*/

-- ===============================================================================
-- WHY DERIVED COLUMN DOES NOT WORK IN WHERE
-- ===============================================================================

-- THIS WILL NOT WORK
SELECT first_name, salary * 1.1 AS revised_salary
FROM employees
WHERE revised_salary > 50000;

/*
Reason:
WHERE runs BEFORE SELECT.
Derived column (revised_salary) is created in SELECT step.
So WHERE cannot see it.
*/

-- WORKING QUERY
SELECT first_name, salary * 1.1 AS revised_salary
FROM employees
WHERE job_title != 'MANAGER'
ORDER BY revised_salary DESC
LIMIT 5;

/*
Execution:
FROM → WHERE → SELECT → ORDER BY → LIMIT
ORDER BY can use alias because it runs AFTER SELECT.
*/

-- ===============================================================================
-- ORDER BY USING COLUMN NOT IN SELECT
-- ===============================================================================

SELECT first_name
FROM employees
WHERE job_title != 'manager'
ORDER BY salary
LIMIT 5;

/*
Even if salary is not in SELECT,
MySQL can still sort using salary.
Engine internally uses that column for sorting.
*/

-- ===============================================================================
-- ERROR EXPLANATION
-- ===============================================================================

SELECT DISTINCT source_of_joining
FROM students
WHERE location IN ('Bangalore','Hyderabad')
ORDER BY years_of_exp DESC
LIMIT 5;

/*
Error:
Expression #1 of ORDER BY clause is not in SELECT list.

Meaning:
DISTINCT removed other columns,
so ORDER BY cannot see years_of_exp.
*/

-- ===============================================================================
-- SIMPLE FILTER EXAMPLE
-- ===============================================================================

SELECT *
FROM employees
WHERE first_name LIKE 'A%';

/*
Execution Flow:
FROM employees → WHERE filter → SELECT result
*/

-- ===============================================================================
/*
WHAT WE COVERED SO FAR:
ORDER OF EXECUTION:
    - FROM
    - WHERE
    - SELECT
    - DISTINCT
    - ORDER BY
    - LIMIT

IMPORTANT RULES:
    - WHERE cannot use SELECT alias
    - ORDER BY can use SELECT alias
    - DISTINCT removes non-selected columns
*/
