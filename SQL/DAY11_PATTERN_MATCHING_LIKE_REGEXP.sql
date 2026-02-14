-- ===============================================================================
-- DAY 11 SQL : SELECT, PATTERN MATCHING - LIKE, REGEXP
-- ===============================================================================
/*
LIKE:
	- Match pattern
	- eg. LIKE "HELLO" OR LIKE 'a%'

WILDCARD CHARACTER:
	- (% - Percent Sign) - Represents zero, one, or multiple characters
	- (_ - Underscore) - Represents a single character
*/

-- =================================================================================
-- Find employees where first_name starts with 'a'
-- =================================================================================
SELECT * FROM employees 
WHERE first_name LIKE ('a%');

-- =================================================================================
-- Find employees where first_name ends with 'k'
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('%k');

-- =================================================================================
-- Find employees where first_name starts with 'a' and last_name ends with 't'
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('a%') AND last_name LIKE ('%t');
-- employee does not exist

SELECT * FROM employees
WHERE first_name LIKE ('a%') OR last_name LIKE ('%t');

-- =================================================================================
-- Find employees where first_name starts with 'am' and ends with 't'
-- =================================================================================
SELECT * 
FROM employees WHERE first_name LIKE 'am%t';

-- =================================================================================
-- Find employees where length of first_name is exactly 4 characters
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('____');

-- =================================================================================
-- Find employees where length of first_name is at least 4 characters or more
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('____%');

-- =================================================================================
-- Find employees where 1st character is 'a' AND 3rd character is 'e'
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('a_e%');

-- =================================================================================
-- Find employees where length of first_name is EXACT 4 characters AND starts with 'j'
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('j___');

-- =================================================================================
-- Find employees where first_name contains 'sun' anywhere
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('%sun%');

-- =================================================================================
-- Find employees where department_id = 2 AND have 'manager' in job_title
-- =================================================================================
SELECT * FROM employees
WHERE department_id = 2 AND job_title LIKE ('%manager%');

-- =================================================================================
-- Find employees where email pattern is invalid
-- =================================================================================
SELECT * FROM employees
WHERE email NOT LIKE ('_%@_%._%'); -- INVALID

SELECT * FROM employees
WHERE email LIKE ('_%@_%._%'); -- VALID

-- =================================================================================
-- Find employees where email contains '\%' -- use escape sequence backslash \
-- =================================================================================
SELECT * FROM employees
WHERE email LIKE ('%\%%'); 

SELECT * FROM employees
WHERE email NOT LIKE ('%\%%'); -- NEGATIVE

-- =================================================================================
-- Find employees where email contains '\' -- use \\ double backslash
-- =================================================================================
SELECT * FROM employees
WHERE email LIKE ('%\\%');

-- =================================================================================
-- Find employees where email contains '/' forward slash
-- =================================================================================
SELECT * FROM employees
WHERE email LIKE ('%/%');

-- =================================================================================
-- Find employees where first_name starts with 'A' OR 'B' OR 'C'
-- =================================================================================
SELECT * FROM employees
WHERE first_name LIKE ('A%') 
   OR first_name LIKE ('B%') 
   OR first_name LIKE ('C%'); 

-- ===============================================================================
-- PATTERN MATCHING USING REGEXP - REGULAR EXPRESSION
-- ===============================================================================
/*
REGEXP:
	- Match pattern
	- eg. REGEXP '^[ABC]'

special metacharacters:
	- (^ - CARET)  : Match start of the string
    - ($ - DOLLAR) : Match end of string
    
WILDCARD CHAR:
	- (. - DOT)   : Represents single character
    - (+ - PLUS) : One or more characters
    - (* - STAR) : Zero or more characters 
    - (? - QMARK): Zero or one character
*/

-- ===============================================================================
-- Find employees where first_name starts with 'A' OR 'B' OR 'C' using REGEXP
-- ===============================================================================
SELECT * FROM employees
WHERE first_name REGEXP '^[ABC]';

-- ===============================================================================
-- Find employees where first_name ends with 'A' OR 'B' OR 'C'
-- ===============================================================================
SELECT * FROM employees
WHERE first_name REGEXP '[ABC]$';

-- ===============================================================================
-- Find employees where 2nd character is VOWEL (A,I,E,O,U)
-- ===============================================================================
SELECT * FROM employees
WHERE first_name REGEXP '^.[AIEOU]';

-- =========================================================================================
-- Find employees where 2nd AND 4th characters are VOWELS
-- =========================================================================================
SELECT * FROM employees
WHERE first_name REGEXP '^.[AIEOU].[AIEOU]';

-- ================================================================================
-- CREATE TABLE users
CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
email VARCHAR(50) NOT NULL
);

-- ================================================================================

-- =================================================================================
-- Find users where email pattern is valid using REGEXP
-- =================================================================================
SELECT * FROM users
WHERE email REGEXP '^[A-Za-z0-9._]+@[a-z0-9_]+\.[a-z]{2,}$';

SELECT * FROM users -- INVALID EMAIL PATTERN
WHERE email NOT REGEXP '^[A-Za-z0-9._]+@[a-z0-9_]+\.[a-z]{2,}$';

-- =================================================================================
-- Find users where length of email is 10 or more characters
-- =================================================================================
SELECT * FROM users
WHERE email REGEXP '..........';

-- =================================================================================
-- Find users where email length is EXACT 10 characters
-- =================================================================================
SELECT * FROM users
WHERE email REGEXP '^..........$';

-- =================================================================================
-- Find users where email length is 10 or more
-- =================================================================================
SELECT * FROM users
WHERE email REGEXP '^........';

-- ========================================================================================
-- Find users where email name does not start with underscore (_) or dash (-)
-- ========================================================================================
SELECT * FROM users 
WHERE email REGEXP '^[^_-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';  

SELECT * FROM users 
WHERE email REGEXP '^[^_\-+#]+@[a-z0-9_]+\.[a-z]{2,}$'; 
-- NOTE:
-- dash (-) inside [] creates range if placed between characters.
-- So always place dash at start or end or escape using \-
-- ====================================================================================================
/*
What we covered so far:
PATTERN MATCHING:
	- LIKE
    - REGEXP
    - Used various characters for filtering like wildcard characters and special meta characters
*/
