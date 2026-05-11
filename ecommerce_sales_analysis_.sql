-- Query 1
create database ecommerce;

-- Query 2
use ecommerce;

-- Query 3
select * from orders
limit 5;

-- Query 4
select * from customers
limit 5;

-- Count customers by state
select o.order_id,o.order_status,c.customer_city,c.customer_state
from orders o
join customers c
on c.customer_id = o.customer_id
limit 10;

-- Query 6
select * from order_items
limit 5;

-- Query 7
select * from products
limit 5;

-- Analyze product category performance
select p.product_category_name, count(*) as Total_Sales
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.product_category_name
order by Total_Sales desc
limit 10;

-- Calculate total company revenue
select p.product_category_name, ROUND(sum(oi.price),2) as Total_Revenue
from order_items oi
join products p
on oi.product_id = p.product_id
group by product_category_name
order by Total_Revenue desc
limit 10;

-- Query 10
select * from payments
limit 5;

-- Calculate total revenue generated
select ROUND(SUM(payment_value),2) as total_revenue
from payments;

-- Calculate total revenue generated
select ROUND(SUM(payment_value) / COUNT(DISTINCT order_id),2) as avg_revenue
from payments;

-- Query 13
select COUNT(DISTINCT order_id) as total_orders
from payments;

-- Find highest spending customers
select c.customer_unique_id, ROUND(SUM(p.payment_value),2) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
join payments p
on o.order_id = p.order_id
group by customer_unique_id
order by total_spent desc
limit 10;

-- Monthly revenue analysis
select DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
ROUND(SUM(p.payment_value),2) AS Total_Revenue
from orders o
join payments p
on o.order_id = p.order_id
group by month
order by month;

-- Monthly revenue analysis
select DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
ROUND(SUM(p.payment_value),2) AS Total_Revenue
from orders o
join payments p
on o.order_id = p.order_id
group by month
order by Total_Revenue DESC
limit 10;

-- Monthly revenue analysis
select ROUND(AVG(monthly_revenue),2) AS avg_monthly_revenue
from ( 
	select DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') as month,
    ROUND(SUM(p.payment_value),2) as monthly_revenue
    from orders o
    join payments p
    on o.order_id = p.order_id
    group by month
    ) AS monthly_sales;

-- Count orders by status
SELECT order_status,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Analyze product category performance
SELECT p.product_category_name,
       ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Monthly revenue analysis
SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
       ROUND(SUM(p.payment_value),2) AS total_revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- Find highest spending customers
SELECT c.customer_unique_id,
       ROUND(SUM(p.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Analyze payment method usage
SELECT payment_type,
       COUNT(*) AS usage_count
FROM payments
GROUP BY payment_type
ORDER BY usage_count DESC;

-- Analyze customer distribution by state
SELECT customer_state,
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Calculate average order value (AOV)
SELECT ROUND(SUM(payment_value) / COUNT(DISTINCT order_id),2) AS avg_order_value
FROM payments;
