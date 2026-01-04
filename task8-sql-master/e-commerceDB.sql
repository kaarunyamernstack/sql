-- create a database
create database ecommerce;
use ecommerce;

-- create a table for CUSTOMER
CREATE TABLE customer (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Address VARCHAR(200)
  );

-- Insert Data values into customer table
INSERT INTO customer(Name, Email, Address) VALUES ('Diya', 'diya@gmail.com', '1st cross street');
INSERT INTO customer(Name, Email, Address) VALUES ('Sam', 'sam@gmail.com', '1st cross street');
INSERT INTO customer(Name, Email, Address) VALUES ('Lithiya', 'lithiya@gmail.com', '1st cross street');
INSERT INTO customer(Name, Email, Address) VALUES ('Rayan', 'rayan@gmail.com', '1st cross street');
INSERT INTO customer(Name, Email, Address) VALUES ('Yazh', 'yazh@gmail.com', '1st cross street');

-- Create a table for products
CREATE TABLE products (
  ID INT PRIMARY KEY AUTO_INCREMENT KEY,
  Name VARCHAR(100),
  Price varchar(100),
  Description varchar(200)
);

-- Insert Data values into product table
INSERT INTO products(Name, Price, Description) VALUES ('Product A', 800.98, 'Description A');
INSERT INTO products(Name, Price, Description) VALUES ('Product B', 650.85, 'Description B');
INSERT INTO products(Name, Price, Description) VALUES ('Product C', 150.95, 'Description C');
INSERT INTO products(Name, Price, Description) VALUES ('Product D', 490.90, 'Description D');
INSERT INTO products(Name, Price, Description) VALUES ('Product E', 250.00, 'Description E');

  
-- Create a table for ORDERS
 CREATE TABLE orders (
   ID INT AUTO_INCREMENT PRIMARY KEY,
   customer_ID INT,
   order_date DATE,
   total_amount DECIMAL(10,2),
   FOREIGN KEY(customer_id) REFERENCES customer(ID)
   );
  
-- Insert Data values into ORDERS table
 INSERT INTO orders (customer_ID, order_Date, total_amount) VALUES
(1, CURDATE() - INTERVAL 5 DAY, 100.00),
(2, CURDATE() - INTERVAL 10 DAY, 200.00),
(1, CURDATE() - INTERVAL 40 DAY, 150.00),
(3, CURDATE() - INTERVAL 5 DAY, 80.00),
(4, CURDATE() - INTERVAL 20 DAY, 80.00);

-- Querries

-- reterive all data from customer table
SELECT * FROM customer; 

-- reterive all data from products table
SELECT * FROM products; 

-- reterive all data from orders table
SELECT * FROM orders; 

-- Retrieve all customers who have placed an order in the last 30 days
SELECT * FROM orders where order_Date >= CURDATE()- INTERVAL 30 DAY;

-- Get the total amount of all orders placed by each customer.
SELECT sum(total_amount) from orders;

-- Update the price of Product C to 45.00.
UPDATE products SET Price = 45.00 WHERE Name = 'Product C';

--Add a new column discount to the products table.
ALTER TABLE products ADD COLUMN Discount DECIMAL(5,2)DEFAULT 00.00;

--Retrieve the top 3 products with the highest price.
SELECT * from products ORDER BY Price DESC LIMIT 3 ;


--Normalize the database by creating a separate table for order items and 
--updating the orders table to reference the order_items table.
-- create a order-items table
CREATE TABLE order_items(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  Quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(ID),
  FOREIGN KEY (product_id) REFERENCES products(ID)
  );
  
-- Insert values for order-items table
INSERT INTO order_items(order_id, product_id, Quantity) VALUES
(1, 1, 2),  
(2, 2, 1),  
(2, 1, 1),  
(3, 3, 2),  
(4, 1, 1);

--Get the names of customers who have ordered Product A.
SELECT DISTINCT C.Name FROM customer C JOIN orders o ON C.ID = O.customer_ID
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.ID
WHERE p.name = 'Product A';

--Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.Name AS customer_Name, o.order_date
FROM orders o
JOIN customer c ON o.customer_ID = c.ID;

--Retrieve the orders with a total amount greater than 150.00.
SELECT * FROM orders WHERE total_amount > 150.00;

--Retrieve the average total of all orders.
SELECT avg(total_amount)AS average_order_total FROM orders;

