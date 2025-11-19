SELECT COUNT(product_id) AS total_products
FROM Products;
SELECT SUM(total_amount) AS total_revenue
FROM Orders;
SELECT AVG(price) AS average_price
FROM Products;
SELECT MAX(total_amount) AS max_order_amount
FROM Orders;
SELECT MIN(total_amount) AS min_order_amount
FROM Orders;
SELECT COUNT(customer_id) AS hanoi_customers_count
FROM Customers
WHERE city = 'Hanoi';
