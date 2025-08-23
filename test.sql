SELECT * FROM users;

SELECT * FROM users WHERE YEAR(created_at) = 2024;

SELECT * FROM users WHERE age < 30 AND gender = 'female';

SELECT product_name, price FROM products;

SELECT u.name, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.id;

SELECT u.name, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.id
ORDER BY o.order_date DESC;

SELECT product_name, AVG(price) AS avg_price
FROM products
GROUP BY product_name;

SELECT u.name, COUNT(o.id) AS order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name;

SELECT u.name, SUM(p.price * oi.quantity) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.name;

SELECT u.name, SUM(p.price * oi.quantity) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.name
ORDER BY total_amount DESC
LIMIT 1;

SELECT * FROM products WHERE price >= 20000;

SELECT * FROM users WHERE age >= 30 AND gender = 'male';

SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.product_name;

SELECT p.product_name, SUM(p.price * oi.quantity) AS total_sales
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.product_name;

SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

SELECT u.name, COUNT(o.id) AS order_count
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING COUNT(o.id) >= 2;

SELECT u.name, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE YEAR(o.order_date) = 2024 AND MONTH(o.order_date) = 6;

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, SUM(p.price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

SELECT u.name, COUNT(DISTINCT oi.product_id) AS product_types
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY u.name;

SELECT u.name, AVG(sub.total_amount) AS avg_amount
FROM users u
JOIN (
  SELECT o.user_id, SUM(p.price * oi.quantity) AS total_amount
  FROM orders o
  JOIN order_items oi ON o.id = oi.order_id
  JOIN products p ON oi.product_id = p.id
  GROUP BY o.id
) sub ON u.id = sub.user_id
GROUP BY u.name;

