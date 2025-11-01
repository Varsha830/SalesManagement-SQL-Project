Create database SalesManagement;
Use SalesManagement;
create table customers(
customer_id int primary key, 
customer_name varchar(25) not null,
 city varchar(50), 
 country varchar(25)
 );
create table products(
 product_id int primary key, 
 product_name varchar(50),
 category varchar(25),
 price float,
 stock integer 
 );
 
 create table orders(
 order_id int primary key,
 customer_id INT,
 order_date date,
 status varchar(25),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create table order_details(order_detail_id varchar(100),
order_id int, 
product_id int, 
quantity int, 
total_amount int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

create table payments(payment_id int primary key,
order_id int,
payment_date date,
payment_mode varchar(25),
amount float8,
foreign key (order_id) references orders(order_id)
 );
INSERT INTO customers (customer_id, customer_name, city, country) VALUES
(1, 'Amit Sharma', 'Mumbai', 'India'),
(2, 'Priya Patel', 'Ahmedabad', 'India'),
(3, 'John Smith', 'New York', 'USA'),
(4, 'Sara Khan', 'Delhi', 'India'),
(5, 'Ravi Mehta', 'Pune', 'India'),
(6, 'Emma Brown', 'London', 'UK'),
(7, 'Rajesh Gupta', 'Bangalore', 'India'),
(8, 'Olivia White', 'Sydney', 'Australia'),
(9, 'Neha Verma', 'Chennai', 'India'),
(10, 'David Johnson', 'Toronto', 'Canada');

INSERT INTO products (product_id, product_name, category, price, stock) VALUES
(101, 'Laptop HP', 'Electronics', 55000.00, 25),
(102, 'Smartphone Samsung', 'Electronics', 30000.00, 40),
(103, 'Refrigerator LG', 'Appliances', 45000.00, 15),
(104, 'Microwave Oven', 'Appliances', 12000.00, 30),
(105, 'Air Conditioner', 'Appliances', 38000.00, 18),
(106, 'Smartwatch', 'Electronics', 8000.00, 50),
(107, 'Bluetooth Speaker', 'Electronics', 3500.00, 60),
(108, 'LED TV', 'Electronics', 42000.00, 20),
(109, 'Washing Machine', 'Appliances', 25000.00, 22),
(110, 'Headphones', 'Electronics', 2000.00, 70);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(201, 1, '2025-10-01', 'Shipped'),
(202, 2, '2025-10-02', 'Delivered'),
(203, 3, '2025-10-03', 'Pending'),
(204, 4, '2025-10-04', 'Cancelled'),
(205, 5, '2025-10-05', 'Shipped'),
(206, 6, '2025-10-06', 'Delivered'),
(207, 7, '2025-10-07', 'Pending'),
(208, 8, '2025-10-08', 'Shipped'),
(209, 9, '2025-10-09', 'Delivered'),
(210, 10, '2025-10-10', 'Pending');

INSERT INTO order_details (order_id, product_id, quantity, total_amount) VALUES
(201, 101, 1, 55000.00),
(202, 102, 2, 60000.00),
(203, 103, 1, 45000.00),
(204, 104, 1, 12000.00),
(205, 105, 1, 38000.00),
(206, 106, 2, 16000.00),
(207, 107, 3, 10500.00),
(208, 108, 1, 42000.00),
(209, 109, 1, 25000.00),
(210, 110, 4, 8000.00);

INSERT INTO payments (payment_id, order_id, payment_date, payment_mode, amount) VALUES
(301, 201, '2025-10-01', 'Credit Card', 55000.00),
(302, 202, '2025-10-02', 'UPI', 60000.00),
(303, 203, '2025-10-03', 'Cash', 45000.00),
(304, 204, '2025-10-04', 'Credit Card', 12000.00),
(305, 205, '2025-10-05', 'Debit Card', 38000.00),
(306, 206, '2025-10-06', 'UPI', 16000.00),
(307, 207, '2025-10-07', 'Cash', 10500.00),
(308, 208, '2025-10-08', 'Credit Card', 42000.00),
(309, 209, '2025-10-09', 'Debit Card', 25000.00),
(310, 210, '2025-10-10', 'UPI', 8000.00);

/*Level 1: Basic SQL (SELECT, WHERE, ORDER BY)*/
-- Display all customers from the table.
select*from customers;
-- Show all products with price greater than ₹10,000.
select*from products where price>10000;
-- List all orders placed in October 2025.
SELECT *
FROM orders
WHERE order_date BETWEEN '2025-10-01' AND '2025-10-31';
-- Find all products that belong to the “Electronics” category.
select*from products where category='Electronics';
-- Display all customers from Mumbai or Delhi.
select*from customers where city='Mumbai' or city='Delhi';

/*Level 2: Joins*/
-- Show all orders along with customer names.
SELECT 
    c.customer_name, 
    o.order_id, 
    o.order_date, 
    o.status
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- Display all order details with product names and quantities.
select p.product_name,od.order_id, od.product_id, od.quantity,od.total_amount from products as p
inner join order_details as od on p.product_id=od.product_id;

-- Show all customers who made at least one order.
select c.customer_name,o.order_id from customers as c inner join orders as o on c.customer_id=o.customer_id where o.order_id is not null;

-- List all payments with corresponding customer name and amount.
SELECT 
    c.customer_name,
    p.payment_id,
    p.order_id,
    p.payment_date,
    p.payment_mode,
    p.amount
FROM payments AS p
INNER JOIN orders AS o ON p.order_id = o.order_id
INNER JOIN customers AS c ON o.customer_id = c.customer_id;


-- Show each product’s total sold quantity (join order_details and products).
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sold_quantity
FROM products AS p
INNER JOIN order_details AS od ON p.product_id = od.product_id
GROUP BY p.product_name;

/* Level 3: Aggregation & Grouping*/

-- Find total sales (revenue) for each product.
SELECT p.product_name,sum(od.total_amount) as total_revenue from products as p inner join order_details as od on p.product_id=od.product_id group by p.product_name;

-- Find total revenue generated per city.
select c.city,sum(od.total_amount) as total_revenue from customers as c inner join order_details as od on c.customer_id=(select o.customer_id from orders as o where o.order_id=od.order_id) group by c.city;

-- Find the average order value (use AVG).
SELECT AVG(od.total_amount) AS average_order_value FROM order_details AS od;

-- Show the number of orders placed by each customer.
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;   

-- Find the most sold product (highest total quantity).
select count(od.product_id) as total_quantity,p.product_name from products as p inner join order_details as od on p.product_id=od.product_id group by p.product_name order by total_quantity desc limit 1;

/*Level 4: Subqueries*/

-- Find customers who have made more than 1 order.
SELECT customer_name FROM customers WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(order_id) > 1);

-- Find products that were never ordered.
SELECT product_name FROM products WHERE product_id NOT IN (SELECT product_id FROM order_details);

-- Display customers who made payments greater than ₹50,000.
SELECT customer_name FROM customers WHERE customer_id IN (SELECT o.customer_id FROM orders AS o INNER JOIN payments AS p ON o.order_id = p.order_id GROUP BY o.customer_id HAVING SUM(p.amount) > 50000);

-- Find the highest revenue order (total_amount).
SELECT * FROM order_details WHERE total_amount = (SELECT MAX(total_amount) FROM order_details);

-- Show customers who made no payments yet.
SELECT customer_name FROM customers WHERE customer_id IN (SELECT o.customer_id FROM orders AS o LEFT JOIN payments AS p ON o.order_id = p.order_id GROUP BY o.customer_id HAVING SUM(p.amount) IS NULL);



