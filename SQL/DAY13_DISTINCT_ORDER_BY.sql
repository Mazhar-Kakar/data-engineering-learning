-- ===============================================================================
-- DAY 13 SQL : DISTINCT
-- ===============================================================================

/*
DISTINCT:
	- Used to remove duplicate values from result
	- Show only unique records
	- Helpful when we want to know unique states, cities, departments, etc.
	- Works on one column or multiple columns	
*/

-- =================================================================================
-- GET UNIQUE STATES FROM CUSTOMERS TABLE
-- =================================================================================
SELECT DISTINCT customer_state 
FROM customers;

-- Real-world example:
-- If many customers belong to same state,
-- DISTINCT will show each state only one time.

-- =================================================================================
-- COUNT OF UNIQUE STATES
-- =================================================================================
SELECT COUNT(DISTINCT customer_state) AS total_state
FROM customers;

-- =================================================================================
-- UNIQUE CITY NAMES
-- =================================================================================
SELECT DISTINCT customer_city AS distinct_city
FROM customers;

SELECT COUNT(DISTINCT customer_city) AS DISTINCT_CITY_COUNT
FROM customers;

-- ===============================================================================
-- CREATE SAMPLE TABLE TO UNDERSTAND DISTINCT
-- ===============================================================================

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);

INSERT INTO employees (name, department, role) VALUES
('John Doe', 'Sales', 'Manager'),
('Jane Smith', 'Sales', 'Representative'),
('Alice Johnson', 'Marketing', 'Manager'),
('Chris Lee', 'IT', 'Developer'),
('Jack White', 'Sales', 'Representative'),
('Eve Davis', 'IT', 'Support'),
('Frank Brown', 'Marketing', 'Representative'),
('Grace Wilson', 'HR', 'Manager'),
('Henry Taylor', 'HR', 'Recruiter'),
('Chris Lee', 'IT', 'Developer');

SELECT * FROM employees;

-- =================================================================================
-- DISTINCT ON TWO COLUMNS
-- =================================================================================
-- Removes duplicate combinations of department + role

SELECT DISTINCT department, role 
FROM employees;

-- Count unique department-role combinations
SELECT COUNT(DISTINCT department, role) 
FROM employees_new;

-- =================================================================================
-- DISTINCT ON ALL COLUMNS
-- =================================================================================
-- Since id is unique, result will show all rows

SELECT DISTINCT id, name, department, role 
FROM employees_new;
-- OR
SELECT DISTINCT *
FROM employees_new;

DROP TABLES students, courses, enrollements; -- DROP MULTIPLE TABLES IN SINGLE COMMAND

-- ===============================================================
-- CREATE students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_fname VARCHAR(30) NOT NULL,
    student_lname VARCHAR(30) NOT NULL,
    student_email VARCHAR(30) NOT NULL,
    student_phone VARCHAR(15) NOT NULL,
    years_of_exp INT NOT NULL,
    student_company VARCHAR(30),
    batch_date DATE NOT NULL,
    source_of_joining VARCHAR(30) NOT NULL,
    location VARCHAR(30) NOT NULL,
    UNIQUE KEY uk_student_email (student_email)
);

INSERT INTO students
(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES
('Amit','Sharma','amit.sharma@gmail.com','9191919191',6,'Walmart','2021-02-05','LinkedIn','Bangalore'),
('Priya','Rao','priya.rao@gmail.com','9292929292',3,'Flipkart','2021-02-05','LinkedIn','Hyderabad'),
('Rahul','Verma','rahul.verma@gmail.com','9393939393',12,'Google','2021-02-19','Google','Bangalore'),
('Neha','Singh','neha.singh@gmail.com','9090909090',4,'Amazon','2021-02-05','Referral','Delhi'),
('Arjun','Mehta','arjun.mehta@gmail.com','9898989898',8,'Infosys','2021-02-05','LinkedIn','Pune'),
('Kavya','Nair','kavya.nair@gmail.com','9797979797',2,'TCS','2021-02-05','Instagram','Kochi'),
('Rohit','Kumar','rohit.kumar@gmail.com','9696969696',5,'Accenture','2021-02-19','LinkedIn','Noida'),
('Sneha','Patil','sneha.patil@gmail.com','9595959595',3,'Capgemini','2021-02-19','Referral','Mumbai'),
('Vikas','Gupta','vikas.gupta@gmail.com','9494949494',10,'IBM','2021-02-19','CompanySite','Bangalore'),
('Anjali','Iyer','anjali.iyer@gmail.com','9393939394',7,'HCL','2021-02-05','LinkedIn','Chennai'),

('Suresh','Reddy','suresh.reddy@gmail.com','9292929293',9,'Wipro','2021-02-05','Referral','Hyderabad'),
('Pooja','Malhotra','pooja.malhotra@gmail.com','9191919192',4,'Deloitte','2021-02-05','LinkedIn','Gurgaon'),
('Kunal','Bansal','kunal.bansal@gmail.com','9898989899',6,'EY','2021-02-19','LinkedIn','Delhi');
-- ====================================================================================================================
-- ===============================================================================
-- STUDENTS TABLE (REAL WORLD DATA EXAMPLE)
-- ===============================================================================

SELECT * FROM students;

-- Unique locations of students
SELECT DISTINCT location 
FROM students;

-- Count number of unique locations
SELECT COUNT(DISTINCT location) 
FROM students;

-- ===============================================================================
-- ORDER BY WITH LIMIT (REAL WORLD THINKING)
-- ===============================================================================

-- Top 6 students with highest experience
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 6;

-- 4th and 5th highest experienced students
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 3,2;

-- First 3 highest experienced students
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 0,3;

-- Third, fourth and fifth students
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 2,3;

-- Least experienced 3 students
SELECT * 
FROM students 
ORDER BY years_of_exp 
LIMIT 3;

-- ===============================================================================
-- REAL WORLD QUESTION
-- FROM WHICH SOURCES MOST EXPERIENCED STUDENTS JOINED
-- ===============================================================================

SELECT source_of_joining, years_of_exp 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 5;

-- ===============================================================================
-- IMPORTANT NOTE ABOUT DISTINCT + ORDER BY
-- ===============================================================================

-- This query may not work properly because
-- ORDER BY column is not part of DISTINCT selection

SELECT DISTINCT source_of_joining
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 5;

-- Reason:
-- DISTINCT applies first, then ORDER BY tries to sort using a column
-- which is not selected.

-- ===============================================================================
/*
What we covered so far:
DISTINCT:
	- DISTINCT keyword
	- COUNT(DISTINCT column)
	- Removing duplicate records
	- DISTINCT with multiple columns
	- DISTINCT with ORDER BY
	- Real-world filtering using LIMIT + ORDER BY
*/
