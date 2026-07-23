-- Day 022: EXISTS and NOT EXISTS Practice
-- Topic: Checking whether matching rows exist.
-- Safety note: every query in this file is read-only.

-- 1. Customers with at least one order.
-- SELECT 1 is a common placeholder. EXISTS only cares whether a row is found.
SELECT c.customer_id, c.customer_name, c.country
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- 2. Customers with no orders.
SELECT c.customer_id, c.customer_name, c.country
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- 3. Orders with at least one successful payment.
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders AS o
WHERE EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
      AND p.payment_status = 'SUCCESS'
)
ORDER BY o.order_id;

-- 4. Orders with no payment row.
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
)
ORDER BY o.order_id;

-- 5. Products with at least one sale.
SELECT p.product_id, p.product_name, p.category
FROM products AS p
WHERE EXISTS (
    SELECT 1
    FROM daily_sales AS s
    WHERE s.product_id = p.product_id
)
ORDER BY p.product_id;

-- 6. Products with no sales.
SELECT p.product_id, p.product_name, p.category
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM daily_sales AS s
    WHERE s.product_id = p.product_id
)
ORDER BY p.product_id;

-- 7. Source records missing from target.
SELECT s.record_id, s.source_value, s.load_date
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.record_id = s.record_id
  )
ORDER BY s.record_id;

-- 8. Target records missing from source.
SELECT t.record_id, t.target_value, t.load_date
FROM source_target_reconciliation AS t
WHERE t.record_type = 'TARGET'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS s
      WHERE s.record_type = 'SOURCE'
        AND s.record_id = t.record_id
  )
ORDER BY t.record_id;

-- Common mistake example, kept as a comment:
-- Missing correlation can make EXISTS true for every customer if any order exists.
-- SELECT c.customer_id
-- FROM customers AS c
-- WHERE EXISTS (
--     SELECT 1
--     FROM orders AS o
-- );
