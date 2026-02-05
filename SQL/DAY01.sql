-- Day01SQL BASICS
-- ===============================================
/*
=> Database:
	Database is a collection of Tables. it is organized form of Data stored  
   Electronically in The Computer System.
   
=> Table: 
	A entity that holds data in the form of Rows and Columns.
     
=> 2 Kinde of Datababes: 
-- Relational dbs (tables have relation between theme)
-- mysql
-- sql server
-- prostresql
-- sql lite 
-- maria db

-- NoSQL databases
-- hbase
-- mongodb
-- dynamodb
*/
-- ===========================================================================

-- show databases 
show databases;

-- Create a new database
create database retail_db;

-- which database is connected
select database();

-- connect to the database
use retail_db;

-- Create a new table inside the connected db
CREATE TABLE orders(
order_id int,
order_date datetime,
customer_id int,
order_status varchar(30)
);

-- show existing tables inside the db which a we are using
show tables;

-- Retrieve all data from the orders table
SELECT * FROM orders;

-- Insert data/Records into tables
INSERT INTO orders VALUES (1,'2013-07-25 00:00:00.0',11599,'COMPLETED');
INSERT INTO orders VALUES (2,'2013-07-25',256,'PNEDING_PAYEMENT');

-- drop table inside the db which we are connected
drop table orders;

-- switch to another db then use this command to drop database
drop database retail_db;


/*
ASSIGMENT:
CREAT A TABLE customers AND INSERT 5 RECORDS
CREAT A TABLE orders_items AND INSERT 5 RECORDS
*/

CREATE TABLE customers(
customer_id int,
customer_fname varchar(30),
customer_lname varchar(30),
customer_email varchar(30),
cusotmer_phone varchar(30),
customer_address varchar(60),
city varchar(30),
state varchar(30),
pincode varchar(30)
);

-- Insert data into customers table
INSERT INTO customers
(customer_id, customer_fname, customer_lname, customer_email, customer_phone,
 customer_address, city, state, pincode)
VALUES
(1,'Richard','Harnandez','richard123@gmail.com','+919960488612','bharat nagar pachora','pachora','maharashtra','424207'),
(2,'harmony','kaza','harmony3@gmail.com','+919978763465','ali nagar bhadgaon','bhadgaon','maharashtra','424207'),
(3,'salam','majid','salam@gmail.com','+918765563765','kashi peth ratlam','ratlam','maharashtra','424207'),
(4,'suriye','yadav','yadav@gmail.com','+919969355632','pune maharashtra','pune','maharashtra','424207'),
(5,'hari','baba','hari3@gmail.com','+919987676523','bharat nagar pachora','jalna','maharashtra','424207');


CREATE TABLE orders_items(
order_item_id int,
order_item_order_id int,
product_id int,
quntity int,
total_amount int,
price int
);

-- Insert data into orders_items table
INSERT INTO orders_items VALUES
(1,134,11599,5,2000,400),
(2,125,1176,5,1000,200),
(3,178,1152,5,500,100),
(4,134,1123,5,2000,400),
(5,1112,1187,5,2000,400);

/*
creating a database
creating a tables
commenting #, --, /**\/
inserting data into tables 
dataTypes (int,varchar,datatime,date,float)

schema - logical folder inside db

databse -> schema -> tables
reatail_db -> dev / test / prod -> orders

In mysql
databse --> tables
retail_db -> orders
*/


