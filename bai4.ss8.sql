SELECT category, COUNT(product_id) AS number_of_products
FROM Products
GROUP BY category;
SELECT customer_id, SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id;
SELECT 
    category,
    COUNT(product_id) AS product_count,
    AVG(price) AS avg_price,
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM Products
GROUP BY category;
SELECT 
    customer_id, 
    SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;
SELECT 
    category, 
    COUNT(product_id) AS product_count
FROM Products
GROUP BY category
HAVING COUNT(product_id) > 5;
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 3;
