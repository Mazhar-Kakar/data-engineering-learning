-- ===============================================================================
-- DAY 17 SQL : BUILT-IN STRING FUNCTIONS 
-- =============================================================================== 

/*
STRING FUNCTIONS:
    - SQL provides many built-in string functions to manipulate and retrieve data stored in text format.
    - CONCAT
    - LENGTH
    - LOWER / UPPER
    - SUBSTRING
    - TRIM / LTRIM / RTRIM
    - REPLACE
    - LOCATE
    - INSTR
*/

-- STRING FUNCTIONS
-- =========================

-- =================================================================================
-- CONCAT (USED TO CONCATENATE TWO OR MORE STRINGS)
-- =================================================================================
SELECT *, CONCAT(customer_fname,' ',customer_lname) AS full_name
FROM customers;

SELECT *, CONCAT(customer_street,', ',customer_city,', ',customer_zipcode) AS full_address
FROM customers;

-- =================================================================================
-- LENGTH (RETURNS LENGTH OF STRING)
-- =================================================================================
SELECT *, LENGTH(customer_fname) AS fname_length
FROM customers
WHERE LENGTH(customer_fname) = 8;

-- LENGTH OF GIVEN STRING - SPACE IS ALSO COUNTED AS CHARACTER
SELECT LENGTH('MAZHAR KAKAR ');

-- =================================================================================
-- VALID: LENGTH OF NON-STRING VALUE
-- customer_id IS A NUMERIC COLUMN BUT WHEN WE USE LENGTH FUNCTION
-- SQL INTERNALLY CONVERTS IT INTO STRING
-- THIS IS CALLED IMPLICIT TYPE CASTING
-- =================================================================================
SELECT LENGTH(customer_id)
FROM sales;

-- =================================================================================
-- IMPLEMENT DATA QUALITY CHECK:
-- customer_state SHOULD BE 2 CHAR
-- customer_zipcode SHOULD BE 5 CHAR
-- =================================================================================
SELECT COUNT(*) 
FROM customers
WHERE LENGTH(customer_state) != 2 
   OR LENGTH(customer_zipcode) != 5;
-- If result = 0 → data quality is good

-- =================================================================================
-- LOWER / UPPER
-- LOWER() converts string to lowercase
-- UPPER() converts string to uppercase
-- =================================================================================
SELECT LOWER('MAZHAR kakar'); -- O/P: mazhar kakar
SELECT UPPER('MAZHAR kakar'); -- O/P: MAZHAR KAKAR

SELECT LOWER(customer_fname) 
FROM customers;

SELECT UPPER(CONCAT(customer_fname,' ',customer_lname)) AS full_name 
FROM customers;

-- =================================================================================
-- SUBSTRING
-- USED TO EXTRACT CHARACTERS FROM A STRING BASED ON POSITION
-- IN SQL INDEXING STARTS FROM 1
-- =================================================================================

-- INDEXING: H1,E2,L3,L4,O5, 6,W7,O8,R9,L10,D11
SELECT SUBSTRING('HELLO WORLD', 7,5); -- O/P: WORLD
-- Starts from position 7 and returns 5 characters

-- WITHOUT LENGTH PARAMETER - RETURNS FROM START POSITION TO END
SELECT SUBSTRING('HELLO WORLD', 7); -- O/P: WORLD

-- BOTH RETURN SAME RESULT
SELECT SUBSTRING('HELLO WORLD', 1,5);  -- O/P: HELLO
SELECT SUBSTRING('HELLO WORLD', -11,5); -- O/P: HELLO (MySQL supports negative index)

-- RETRIEVE FIRST 5 CHARACTERS OF customer_fname
SELECT SUBSTRING(customer_fname, 1, 5) 
FROM customers;

SELECT LENGTH(SUBSTRING(customer_fname, 1, 5)) 
FROM customers;

-- LAST 5 CHARACTERS
SELECT SUBSTRING('HELLO WORLD', -5);

-- ONLY FIRST CHARACTER
SELECT SUBSTRING('HELLO WORLD', 1,1);

-- =================================================================================
-- TRIM / LTRIM / RTRIM
-- Leading spaces = spaces at the beginning
-- Trailing spaces = spaces at the end
-- TRIM() removes both leading and trailing spaces
-- RTRIM() removes trailing spaces
-- LTRIM() removes leading spaces
-- =================================================================================
SELECT TRIM('  SQL CHAMPION PROGRAM  '); -- O/P: 'SQL CHAMPION PROGRAM'
SELECT RTRIM('SQL CHAMPION PROGRAM  ');
SELECT LTRIM('   SQL CHAMPION PROGRAM');

-- =================================================================================
-- FIND ALL customers WHERE customer_street HAS LEADING OR TRAILING SPACES
-- =================================================================================
SELECT * 
FROM customers
WHERE TRIM(customer_street) != customer_street;

-- =================================================================================
-- REPLACE: USED TO REPLACE PART OF A STRING
-- =================================================================================
SELECT REPLACE('HELLO WORLD', 'WORLD','MYSQL');
-- Replaces WORLD with MYSQL

-- REPLACE customer_state CA WITH CALIFORNIA
SELECT REPLACE(customer_state,'CA','CALIFORNIA') 
FROM customers;

-- =================================================================================
-- LOCATE / INSTR
-- USED TO FIND POSITION OF A SUBSTRING
-- =================================================================================
SELECT LOCATE('WORLD','HELLO WORLD') AS position; 
-- O/P: 7 (position of W)

-- INSTR: SAME FUNCTIONALITY (SYNTAX DIFFERENT ORDER)
SELECT INSTR('HELLO WORLD','WORLD') AS position;

-- FIND POSITION OF 'L'
-- Since L appears multiple times, it returns the FIRST occurrence
SELECT LOCATE('L','HELLO WORLD') AS position; -- O/P: 3

-- =================================================================================
-- FIND THE STREET NUMBER FROM customer_street
-- =================================================================================
SELECT TRIM(SUBSTRING(customer_street, 1, LOCATE(' ',customer_street) - 1)) AS street_number
FROM customers;

-- Logic: sorted based on space after street number
-- 1. LOCATE(' ') → find first space
-- 2. SUBSTRING from position 1 to space-1
-- 3. TRIM removes extra spaces if any

-- ===============================================================================
/*
WHAT WE COVERED SO FAR:
BUILT-IN STRING FUNCTIONS:
    - Retrieve and manipulate strings using built-in functions
    - Used nested functions for complex string manipulation
    - Understood indexing in SUBSTRING
    - Created derived columns using CONCAT
    - Performed basic data quality checks using LENGTH
*/