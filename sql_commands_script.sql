
-- connect to databse
mysql --host=172.21.217.189 --port=3306 --user=root --password=wOp8x1hacmZai6kAPFUI1b5V

-- create OLTP database in MySQL
CREATE DATABASE sales;

-- create table in sales database
USE sales;
CREATE TABLE IF NOT EXISTS sales_data (
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    price FLOAT(2),
    quantity INT,
    timestamp TIMESTAMP,
    CONSTRAINT PK_sales_data PRIMARY KEY (product_id,customer_id,timestamp)  
); 

-- import csv data into sales_data table
LOAD DATA INFILE './oltpdata.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, customer_id, price, quantity, timestamp);

-- list tables in sales database
SHOW TABLES;

-- query count of records in sales_data
SELECT COUNT(*) FROM sales_data;

-- create an index named ts on the timestamp field and list indexes
CREATE INDEX ts ON sales_data(timestamp);
SHOW INDEX FROM sales.sales_data;
