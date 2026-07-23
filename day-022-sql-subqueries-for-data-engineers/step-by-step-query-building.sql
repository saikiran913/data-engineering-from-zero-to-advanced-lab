-- Day 022: Step-by-Step Query Building
-- Topic: Build the inner query first, validate it, then use it in the outer query.
-- Safety note: every query in this file is read-only.

-- Worked example 1: Customers with high-value orders.
-- Step 1: inspect orders above a threshold.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > 500;

-- Step 2: return only customer IDs.
SELECT customer_id
FROM orders
WHERE order_amount > 500
  AND customer_id IS NOT NULL;

-- Step 3 and 4: place the customer-ID query inside IN.
SELECT customer_id, customer_name, country
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_amount > 500
      AND customer_id IS NOT NULL
)
ORDER BY customer_id;

-- Worked example 2: Orders without payments.
-- Step 1: inspect payment order IDs.
SELECT order_id
FROM payments
WHERE order_id IS NOT NULL;

-- Step 2: check for null values.
SELECT payment_id, order_id
FROM payments
WHERE order_id IS NULL;

-- Step 3: use NOT EXISTS for the missing-payment check.
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
)
ORDER BY o.order_id;

-- Step 4: validate with a count.
SELECT COUNT(*) AS orders_without_payments
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
);

-- Worked example 3: Products above average price.
-- Step 1: calculate average price.
SELECT AVG(unit_price) AS average_unit_price
FROM products;

-- Step 2: use the scalar result in the outer query.
SELECT product_id, product_name, category, unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
);

-- Step 3: add status filtering.
SELECT product_id, product_name, category, unit_price
FROM products
WHERE product_status = 'ACTIVE'
  AND unit_price > (
      SELECT AVG(unit_price)
      FROM products
  )
ORDER BY unit_price DESC;

-- Worked example 4: Source-target missing records.
-- Step 1: isolate source IDs.
SELECT record_id
FROM source_target_reconciliation
WHERE record_type = 'SOURCE';

-- Step 2: isolate target IDs.
SELECT record_id
FROM source_target_reconciliation
WHERE record_type = 'TARGET';

-- Step 3 and 4: use NOT EXISTS and produce review output.
SELECT
    s.record_id,
    s.source_value,
    'Missing from target' AS issue_description
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.record_id = s.record_id
  );

-- Worked example 5: Daily sales above average daily total.
-- Beginner version using a FROM-clause subquery.
SELECT
    sale_date,
    daily_total
FROM (
    SELECT
        sale_date,
        SUM(sales_amount) AS daily_total
    FROM daily_sales
    GROUP BY sale_date
) AS daily_totals
WHERE daily_total > 400
ORDER BY daily_total DESC;

-- Debugging checklist:
-- 1. Run the inner query.
-- 2. Check row count.
-- 3. Check column count.
-- 4. Inspect NULL values.
-- 5. Confirm data types.
-- 6. Confirm the business key.
-- 7. Compare with a join where useful.
-- 8. Validate final totals.
