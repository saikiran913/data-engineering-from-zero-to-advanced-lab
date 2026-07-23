-- Day 022: Validation Subqueries
-- Topic: Data quality, reconciliation, and missing-record checks.
-- Safety note: every query in this file is read-only.
-- Validation results are review inputs. Investigate before making business decisions.

-- 1. Customers without orders.
SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 2. Orders without customers.
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders AS o
WHERE o.customer_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM customers AS c
      WHERE c.customer_id = o.customer_id
  );

-- 3. Orders without payments.
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
);

-- 4. Payments without orders.
SELECT p.payment_id, p.order_id, p.payment_amount
FROM payments AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.order_id = p.order_id
);

-- 5. Products without sales.
SELECT p.product_id, p.product_name
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM daily_sales AS s
    WHERE s.product_id = p.product_id
);

-- 6. Source records missing from target.
SELECT s.record_id, s.source_value
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.record_id = s.record_id
  );

-- 7. Target records missing from source.
SELECT t.record_id, t.target_value
FROM source_target_reconciliation AS t
WHERE t.record_type = 'TARGET'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS s
      WHERE s.record_type = 'SOURCE'
        AND s.record_id = t.record_id
  );

-- 8. Values above an expected aggregate.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);

-- 9. Count comparison using scalar subqueries.
SELECT
    (SELECT COUNT(*) FROM customers) AS customer_count,
    (SELECT COUNT(DISTINCT customer_id) FROM orders WHERE customer_id IS NOT NULL) AS order_customer_count;

-- 10. Source and target count comparison.
SELECT
    (SELECT COUNT(*) FROM source_target_reconciliation WHERE record_type = 'SOURCE') AS source_record_count,
    (SELECT COUNT(*) FROM source_target_reconciliation WHERE record_type = 'TARGET') AS target_record_count;

-- 11. Total comparison from reconciliation data.
SELECT
    (SELECT SUM(source_value) FROM source_target_reconciliation WHERE record_type = 'SOURCE') AS source_total,
    (SELECT SUM(target_value) FROM source_target_reconciliation WHERE record_type = 'TARGET') AS target_total;

-- 12. Mismatched source and target values.
SELECT s.record_id, s.source_value, s.target_value
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND s.record_id IN (
      SELECT t.record_id
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.source_value <> t.target_value
  )
ORDER BY s.record_id;

-- 13. Simple review queue.
SELECT
    s.record_id,
    'SOURCE_MISSING_IN_TARGET' AS validation_type,
    'Check whether this source record loaded to the target' AS suggested_action
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.record_id = s.record_id
  );
