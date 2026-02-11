-- ===============================================================================
-- DAY 10 SQL : SELECT, FILTERATION USING
-- (WHERE CLAUSE - AND, OR, NOT, BETWEEN, IS, IN)
-- ===============================================================================

/*
AND: Both conditions must be TRUE
OR: At least one condition should be TRUE
NOT: Reverse/negate the condition
BETWEEN: Used for range filtering (example: 1 to 4)
IS: Used to check NULL values (IS NULL / IS NOT NULL)
IN: Used to match multiple values in a list
*/

-- connect to database
USE retail_db;

-- View all data from customers table
SELECT * FROM customers;

-- View few columns from customers table
SELECT customer_id, customer_fname, customer_lname
FROM customers;

-- View top 10 records using LIMIT
SELECT * FROM customers LIMIT 10;

-- View top 10 records in descending order
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 10;

-- View top 10 records in ascending order
SELECT * FROM customers ORDER BY customer_id LIMIT 10;

-- ==================================================================
-- Finde employees where customer_id between 10 to 20 using AND operator
-- ==================================================================

SELECT * FROM customers
WHERE (customer_id >= 10 AND customer_id <= 20);

-- View data by renaming column using alias
SELECT customer_fname AS FirstName, customer_id, customer_lname
FROM customers;

-- change position of column in select
SELECT customer_id, customer_fname AS FirstName, customer_lname
FROM customers;

-- ===================================================================

-- Create new table
CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
department_id INT,
salary DECIMAL(10,2),
hire_date DATE,
manager_id INT,
email VARCHAR(100),
phone_number VARCHAR(20),
job_title VARCHAR(50)
);

-- Insert data into employees table
INSERT INTO employees
(
  first_name,
  last_name,
  department_id,
  salary,
  hire_date,
  manager_id,
  email,
  phone_number,
  job_title
)
VALUES 
('Amit','Sharma',10,75000,'2019-01-15',NULL,'amit.sharma@company.com','9000000001','Manager'),
('Vikram','Malhotra',10,82000,'2018-06-20',NULL,'vikram.malhotra@company.com','9000000002','Senior Manager'),

('Neha','Verma',20,48000,'2021-02-10',1,'neha.verma@company.com','9000000003','Software Engineer'),
('Rahul','Mehta',20,50000,'2020-09-18',1,'rahul.mehta@company.com','9000000004','Software Engineer'),
('Arjun','Reddy',20,52000,'2021-07-12',1,'arjun.reddy@company.com','9000000005','Backend Developer'),
('Rohit','Gupta',20,47000,'2022-01-05',1,'rohit.gupta@company.com','9000000006','Java Developer'),
('Gaurav','Saxena',20,49000,'2020-11-22',1,'gaurav.saxena@company.com','9000000007','Frontend Developer'),
('Anil','Kumar',20,46000,'2022-04-14',1,'anil.kumar@company.com','9000000008','Software Tester'),
('Ayesha','Khan',20,51000,'2021-08-09',1,'ayesha.khan@company.com','9000000009','UI Developer'),
('Sandeep','Joshi',20,49500,'2020-03-03',1,'sandeep.joshi@company.com','9000000010','Software Engineer'),

('Priya','Singh',30,55000,'2019-10-25',1,'priya.singh@company.com','9000000011','Data Analyst'),
('Pooja','Nair',30,56000,'2020-05-30',1,'pooja.nair@company.com','9000000012','Business Analyst'),
('Karan','Patel',30,58000,'2021-06-18',1,'karan.patel@company.com','9000000013','Data Engineer'),
('Meena','Das',30,54000,'2022-02-11',1,'meena.das@company.com','9000000014','BI Analyst'),
('Nidhi','Bansal',30,56500,'2020-12-07',1,'nidhi.bansal@company.com','9000000015','Data Analyst'),
('Swati','Joshi',30,57000,'2019-08-19',1,'swati.joshi@company.com','9000000016','Analytics Consultant'),
('Komal','Shah',30,55500,'2021-09-23',1,'komal.shah@company.com','9000000017','Data Engineer'),
('Ritika','Kapoor',30,53500,'2022-05-16',1,'ritika.kapoor@company.com','9000000018','Reporting Analyst'),
('Abhishek','Mishra',30,59000,'2020-01-28',1,'abhishek.mishra@company.com','9000000019','Senior Analyst'),
('Naveen','Shetty',30,56000,'2021-11-02',1,'naveen.shetty@company.com','9000000020','Business Analyst'),

('Sneha','Iyer',40,45000,'2021-03-01',2,'sneha.iyer@company.com','9000000021','HR Executive'),
('Anita','Kumari',40,42000,'2022-04-10',2,'anita.kumari@company.com','9000000022','HR Assistant'),
('Kavita','Rao',40,46000,'2020-06-14',2,'kavita.rao@company.com','9000000023','HR Executive'),
('Sunita','Pandey',40,44000,'2023-01-18',2,'sunita.pandey@company.com','9000000024','HR Coordinator'),
('Ritu','Kapoor',40,43000,'2022-09-09',2,'ritu.kapoor@company.com','9000000025','HR Officer'),

('Deepak','Chauhan',10,70000,'2019-02-12',2,'deepak.chauhan@company.com','9000000026','Project Manager'),
('Harish','Verma',10,72000,'2018-11-05',2,'harish.verma@company.com','9000000027','Operations Manager'),
('Suresh','Yadav',10,68000,'2020-07-21',2,'suresh.yadav@company.com','9000000028','Operations Lead'),
('Pankaj','Jain',10,76000,'2017-05-17',2,'pankaj.jain@company.com','9000000029','Senior Manager'),

-- remaining valid employees (same realistic pattern)

('Ramesh','Patil',20,48000,'2021-04-06',1,'ramesh.patil@company.com','9000000030','Software Engineer'),
('Mohit','Agarwal',20,50000,'2020-10-10',1,'mohit.agarwal@company.com','9000000031','Software Engineer'),
('Isha','Malik',30,54500,'2021-07-27',1,'isha.malik@company.com','9000000032','Data Analyst'),
('Farhan','Ali',20,47000,'2022-02-19',1,'farhan.ali@company.com','9000000033','Backend Developer'),
('Shubham','Tiwari',20,49000,'2020-08-13',1,'shubham.tiwari@company.com','9000000034','Java Developer'),
('Pallavi','Kulkarni',30,55500,'2019-09-09',1,'pallavi.kulkarni@company.com','9000000035','Data Analyst'),
('Aman','Srivastava',20,46500,'2022-06-11',1,'aman.srivastava@company.com','9000000036','QA Engineer'),
('Divya','Chopra',40,43500,'2021-01-22',2,'divya.chopra@company.com','9000000037','HR Executive'),
('Sahil','Bhat',10,71000,'2020-03-15',2,'sahil.bhat@company.com','9000000038','Operations Manager'),
('Varun','Khanna',30,58500,'2019-12-12',1,'varun.khanna@company.com','9000000039','Data Engineer'),
		
('Tanvi','Deshpande',30,55000,'2021-10-18',1,'tanvi.deshpande@company.com','9000000040','Business Analyst'),
('Kunal','Arora',20,49500,'2020-04-29',1,'kunal.arora@company.com','9000000041','Software Engineer'),
('Riya','Saxena',40,42500,'2022-08-08',2,'riya.saxena@company.com','9000000042','HR Assistant'),
('Ashish','Narang',10,74000,'2018-02-26',2,'ashish.narang@company.com','9000000043','Senior Manager'),
('Monika','Goyal',30,56500,'2020-06-30',1,'monika.goyal@company.com','9000000044','Analytics Consultant'),

('Nitin','Rawat',20,48000,'2021-09-14',1,'nitin.rawat@company.com','9000000045','Software Engineer'),
('Preeti','Sinha',40,44000,'2022-11-01',2,'preeti.sinha@company.com','9000000046','HR Coordinator'),
('Yogesh','Pawar',20,50500,'2020-01-19',1,'yogesh.pawar@company.com','9000000047','Backend Developer'),
('Shalini','Mishra',30,57000,'2019-07-08',1,'shalini.mishra@company.com','9000000048','Data Analyst'),
('Aditya','Bose',10,69000,'2021-05-03',2,'aditya.bose@company.com','9000000049','Project Lead'),

('Sameer','Qureshi',20,49500,'2020-10-21',1,'sameer.qureshi@company.com','9000000050','Software Engineer');

-- ========================================================================================================================

-- Count of records in table
SELECT COUNT(*) FROM employees;

-- Find employees whose salary is more than 50k
SELECT * FROM employees WHERE salary > 50000;

-- COUNT how many employees have more than 50k salary
SELECT COUNT(*) FROM employees WHERE salary > 50000;

-- String comparison also works (alphabetical comparison)
SELECT * FROM employees WHERE first_name >= 'Amit';

-- Find all employees hired after 2019
SELECT * FROM employees WHERE hire_date > '2019-12-31';

-- ==================================================================================
-- AND, OR, NOT - LOGICAL OPERATORS:
-- AND: All conditions must be TRUE
-- OR : Any one condition must be TRUE
-- NOT: Reverse the result
-- ==================================================================================

-- AND: Find employees who belong to department_id = 10 AND salary > 50000
SELECT * FROM employees
WHERE (department_id = 10 AND salary > 50000);

-- NOT with AND: employees who DO NOT satisfy both conditions
SELECT * FROM employees
WHERE NOT (department_id = 10 AND salary > 50000);

-- OR: employees from department_id = 10 OR salary > 50000
SELECT * FROM employees
WHERE (department_id = 10 OR salary > 50000);

-- employees from department 10 OR department 30
SELECT * FROM employees
WHERE (department_id = 10 OR department_id = 30);

-- Find employees where job_title is software engineer AND department 10 or 20
SELECT *
FROM employees
WHERE department_id = 10 OR department_id = 20 AND job_title = 'software engineer';

-- Result may be wrong because AND has higher precedence than OR

-- Correct precedence using brackets
SELECT *
FROM employees
WHERE (department_id = 10 OR department_id = 20)
AND job_title = 'software engineer';

-- ===============================================================================================================
-- BETWEEN, IN, IS OPERATORS
-- ==============================================================================================================

-- Find employees where salary between 30k to 50k
SELECT * FROM employees
WHERE salary BETWEEN 30000 AND 50000;

-- Find employee_id between 1 to 5
SELECT * FROM employees
WHERE employee_id BETWEEN 1 AND 5;

-- Find all employees hired between 2020 to 2021
SELECT * FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-12-31';

-- Negate BETWEEN condition
SELECT * FROM employees
WHERE NOT (hire_date BETWEEN '2020-01-01' AND '2021-12-31');

-- Find employees from department_id 10,20,30
SELECT * FROM employees
WHERE department_id IN (10,20,30);

-- Find employees NOT from department_id 10,20,30
SELECT * FROM employees
WHERE department_id NOT IN (10,20,30);

-- Get employees where job_title matches multiple values
SELECT * FROM employees
WHERE job_title IN ('software engineer','data engineer','business analyst');

-- Negative condition
SELECT * FROM employees
WHERE job_title NOT IN ('software engineer','data engineer','business analyst');

-- employees who do not have manager
SELECT *
FROM employees
WHERE manager_id IS NULL;

SELECT *
FROM employees
WHERE manager_id IS NOT NULL;

-- This Query is wrong because NULL means absence of value
SELECT *
FROM employees
WHERE manager_id = NULL;

-- ====================================================================================================
/*
What we covered so far:
FILTERATION:
- WHERE CLAUSE
- AND, OR, NOT operators
- IS, IS NOT, IN, NOT IN, BETWEEN operators
*/