SELECT * FROM users;

SELECT * FROM users WHERE YEAR(created_at) = 2024;

SELECT * FROM users WHERE age < 30 AND gender = 'female';

SELECT product_name, price FROM products;

SELECT u.name AS user_name, o.order_date
FROM orders AS o
JOIN users  AS u ON u.id = o.user_id
ORDER BY o.order_date;


SELECT
  oi.id,
  p.product_name,
  p.price        AS unit_price,
  oi.quantity,
  (p.price * oi.quantity) AS amount
FROM order_items AS oi
JOIN products    AS p ON p.id = oi.product_id
ORDER BY oi.id;


SELECT
  u.id,
  u.name,
  COUNT(o.id) AS order_count
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;


SELECT
  u.id,
  u.name,
  COALESCE(SUM(p.price * oi.quantity), 0) AS total_amount
FROM users        AS u
LEFT JOIN orders       AS o  ON o.user_id   = u.id
LEFT JOIN order_items  AS oi ON oi.order_id = o.id
LEFT JOIN products     AS p  ON p.id        = oi.product_id
GROUP BY u.id, u.name
ORDER BY total_amount DESC, u.id;


SELECT u.name, SUM(p.price * oi.quantity) AS total_amount
FROM orders       AS o
JOIN users        AS u  ON u.id        = o.user_id
JOIN order_items  AS oi ON oi.order_id = o.id
JOIN products     AS p  ON p.id        = oi.product_id
GROUP BY u.id, u.name
ORDER BY total_amount DESC
LIMIT 1;


SELECT
  p.id,
  p.product_name,
  COALESCE(SUM(oi.quantity), 0) AS total_ordered_qty
FROM products AS p
LEFT JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY total_ordered_qty DESC, p.id;


SELECT u.*
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
WHERE o.id IS NULL;


SELECT oi.order_id
FROM order_items AS oi
GROUP BY oi.order_id
HAVING COUNT(DISTINCT oi.product_id) >= 2;


SELECT DISTINCT u.name
FROM users        AS u
JOIN orders       AS o  ON o.user_id   = u.id
JOIN order_items  AS oi ON oi.order_id = o.id
JOIN products     AS p  ON p.id        = oi.product_id
WHERE p.product_name = 'テレビ'
ORDER BY u.name;


SELECT
  o.order_date,
  u.name        AS user_name,
  p.product_name,
  oi.quantity,
  (p.price * oi.quantity) AS amount
FROM orders       AS o
JOIN users        AS u  ON u.id        = o.user_id
JOIN order_items  AS oi ON oi.order_id = o.id
JOIN products     AS p  ON p.id        = oi.product_id
ORDER BY o.order_date, o.id, oi.id;


SELECT
  p.product_name,
  SUM(oi.quantity) AS total_qty
FROM order_items AS oi
JOIN products    AS p ON p.id = oi.product_id
GROUP BY p.id, p.product_name
ORDER BY total_qty DESC
LIMIT 1;


SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS ym,
  COUNT(*) AS orders_count
FROM orders
GROUP BY ym
ORDER BY ym;


SELECT p.*
FROM products AS p
LEFT JOIN order_items AS oi ON oi.product_id = p.id
WHERE oi.product_id IS NULL;


ALTER TABLE order_items
ADD INDEX idx_order_items_product_id (product_id);


SELECT u.id, u.name,
       COALESCE(AVG(ot.order_total), 0) AS avg_order_amount
FROM users AS u
LEFT JOIN (
  SELECT
    o.id AS order_id,
    o.user_id,
    SUM(p.price * oi.quantity) AS order_total
  FROM orders       AS o
  JOIN order_items  AS oi ON oi.order_id = o.id
  JOIN products     AS p  ON p.id        = oi.product_id
  GROUP BY o.id, o.user_id
) AS ot
  ON ot.user_id = u.id
GROUP BY u.id, u.name
ORDER BY avg_order_amount DESC, u.id;


SELECT
  u.id,
  u.name,
  MAX(o.order_date) AS latest_order_date
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;
（

INSERT INTO users (id, name, age, gender, created_at)
VALUES (6, '中村愛', 25, 'female', '2025-06-01');

INSERT INTO products (id, product_name, price)
VALUES (6, 'エアコン', 60000);

INSERT INTO orders (id, user_id, order_date)
VALUES (10, 1, '2025-06-10');

INSERT INTO order_items (id, order_id, product_id, quantity)
VALUES (10, 10, 6, 1);

UPDATE users
SET age = 24
WHERE name = '田中美咲';

UPDATE products
SET price = ROUND(price * 1.10);

UPDATE orders
SET order_date = '2024-05-01'
WHERE order_date < '2024-06-01';

DELETE FROM users
WHERE name = '高橋健一';

DELETE FROM order_items
WHERE order_id = 5;

DELETE FROM products
WHERE id NOT IN (SELECT product_id FROM order_items);
