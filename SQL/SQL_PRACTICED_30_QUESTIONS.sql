-- ====================================================
-- SQL PRACTICE
-- ====================================================

USE retail_db;
DROP TABLES customers, products, orders;

-- ==============================================================================
CREATE TABLE customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50) DEFAULT 'Mumbai',
    signup_date DATE
);

-- Insert data into customers table
INSERT INTO customers(customer_name,email,city,signup_date) VALUES
('Amit','amit@gmail.com','Mumbai','2023-01-10'),
('Sara','sara@test.com','Delhi','2023-02-11'),
('Imran','imran@yahoo.com','Pune','2023-03-15'),
('Neha','neha@gmail.com','Mumbai','2023-03-20'),
('Omar','omar@test.com','Delhi','2023-04-01'),
('Isha','isha@gmail.com','Mumbai','2023-04-05'),
('Ali','ali@yahoo.com','Hyderabad','2023-05-07'),
('Riya','riya@gmail.com','Pune','2023-05-20');

-- ===============================================================================
CREATE TABLE products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price INT CHECK(price >= 1000)
);

-- Insert into products table
INSERT INTO products(product_name,category,price) VALUES
('Laptop','Electronics',70000),
('Phone','Electronics',30000),
('Headphones','Electronics',3000),
('Shoes','Fashion',2000),
('Watch','Fashion',5000),
('Bag','Fashion',1500),
('Tablet','Electronics',25000);

-- ==================================================================================
CREATE TABLE orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    amount INT,
    order_date DATE
);

-- add product_id column in orders table
ALTER TABLE orders ADD COLUMN product_id INT;

-- add foreign keys in orders table
ALTER TABLE orders 
ADD CONSTRAINT customer_id_FK FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT product_id_FK FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE;

SHOW CREATE TABLE orders;

-- Insert into orders table
INSERT INTO orders(customer_id, product_id, amount, order_date) VALUES
(1,1,70000,'2023-05-01'),   
(2,2,30000,'2023-05-02'),   
(1,3,3000,'2023-05-03'),    
(3,4,2000,'2023-05-05'),    
(4,5,5000,'2023-05-07'),    
(2,3,3000,'2023-05-08'),    
(5,7,25000,'2023-05-10'),   
(6,3,3000,'2023-05-11');    

-- =====================================================================
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- ======================================================================
-- 🟢 EASY LEVEL (1–10)
-- ======================================================================

-- 1. Show all customers from Mumbai.
SELECT * FROM customers
WHERE city = 'Mumbai';

/*
CASE SENSITIVITY:
- SQL keywords are NOT case sensitive
- Table/Database names may be case sensitive (depends on OS)
- Data comparison depends on COLLATION (ci = case insensitive, cs = case sensitive)
*/

-- 2. Display unique cities from customers table.
SELECT DISTINCT city FROM customers;

-- 3. Show products where price > 5000.
SELECT * FROM products
WHERE price > 5000;

-- 4. Find customers whose email ends with gmail.com.
SELECT * FROM customers
WHERE email LIKE "%gmail.com";

-- 5. Show orders after 2023-05-05.
SELECT * FROM orders
WHERE order_date > '2023-05-05';

-- 6. Display top 3 highest price products.
SELECT * FROM products 
ORDER BY price DESC LIMIT 3; 

-- 7. Count total customers.
SELECT COUNT(*) AS total_customers 
FROM customers;

-- 8. Show products sorted by price ascending.
SELECT * FROM products
ORDER BY price; -- default ASC

-- 9. Show customers whose name starts with vowel.
SELECT * FROM customers
WHERE customer_name REGEXP "^[AEIOUaeiou]";

-- 10. Find orders where amount = 3000.
SELECT * FROM orders
WHERE amount = 3000;

-- ========================================================================
-- 🟡 MEDIUM LEVEL (11–20)
-- ========================================================================

-- 11. Count customers per city.
SELECT city, COUNT(*) AS total_customers 
FROM customers
GROUP BY city;

-- 12. Show cities having more than 1 customer.
SELECT city, COUNT(*) AS total_customers
FROM customers 
GROUP BY city HAVING total_customers > 1;

-- 13. Find average product price per category.
SELECT category AS product_category,
COUNT(*) AS total_products,
SUM(price) AS total_amount_per_category,
AVG(price) AS average_price_per_category
FROM products
GROUP BY category;

-- 14. Show products whose name length is more than 5.
SELECT * FROM products 
WHERE LENGTH(product_name) > 5; 

-- 15. Find customers who signed up in March.
SELECT * FROM customers
WHERE signup_date BETWEEN '2023-03-01' AND '2023-03-31'; 

-- 16. Show emails that start with letter and end with .com.
SELECT * FROM customers 
WHERE email REGEXP '^[A-Za-z._]+@[a-zA-Z0-9]+\.com$';

-- 17. Find total order amount per customer.
SELECT customer_id, SUM(amount) AS total_amount
FROM orders 
GROUP BY customer_id;

-- 18. Customers whose name contains only alphabets.
SELECT * FROM customers
WHERE customer_name REGEXP "^[A-Za-z ]+$";

-- 19. Show products where price ends with 000.
SELECT * FROM products
WHERE price % 1000 = 0;

-- 20. Find categories where max price > 20000.
SELECT category, MAX(price) AS maximum_price 
FROM products
GROUP BY category 
HAVING maximum_price > 20000;
    
-- ========================================================================
-- 🔴 HARD LEVEL (21–30)
-- ========================================================================

-- 21. Find second highest product price.
SELECT * FROM products
ORDER BY price DESC LIMIT 1 OFFSET 1;

-- 22. Show customers whose email does NOT start with _ or -
SELECT * FROM customers
WHERE email NOT REGEXP '^[_-]';

-- 23. Count orders per date and sort by count descending.
SELECT COUNT(*) AS orders, order_date 
FROM orders
GROUP BY order_date
ORDER BY orders DESC;

-- 24. Show cities where earliest signup_date is before March.
SELECT city, MIN(signup_date) AS earliest_signup
FROM customers
GROUP BY city
HAVING MIN(signup_date) < '2023-03-01'; 

-- 25. Customers whose email username contains numbers.
SELECT * FROM customers
WHERE email REGEXP "[0-9]+.*@";

-- NOTE:
-- Use simple REGEXP when possible.
-- Complex regex uses more processing power (performance impact).

-- 26. Find total revenue.
SELECT SUM(amount) AS total_revenue 
FROM orders;

-- 27. Show order dates having total amount greater than 5000.
SELECT order_date, SUM(amount) AS total_amount
FROM orders
GROUP BY order_date
HAVING total_amount > 5000;

-- 28. Products whose category contains only lowercase letters.
SELECT * FROM products
WHERE BINARY category = LOWER(category);

-- 29. Show customers sorted by signup month.
SELECT * FROM customers 
ORDER BY YEAR(signup_date), MONTH(signup_date);

-- 30. Customers whose name has no vowels.
SELECT * FROM customers
WHERE customer_name NOT REGEXP "[AEIOUaeiou]";
