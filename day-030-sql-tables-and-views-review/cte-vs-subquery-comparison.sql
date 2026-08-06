-- Day 030: CTE Versus Subquery Comparison
-- Purpose: Compare named one-statement steps with smaller embedded query logic.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Orders above average using a subquery.
SELECT
    order_id,
    customer_id,
    order_amount
FROM order_transactions
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM order_transactions
    WHERE order_amount > 0
);

-- Orders above average using a CTE for readability.
WITH average_order AS (
    SELECT AVG(order_amount) AS average_positive_order_amount
    FROM order_transactions
    WHERE order_amount > 0
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_amount
FROM order_transactions AS o
INNER JOIN average_order AS a
    ON o.order_amount > a.average_positive_order_amount;

-- Customers with orders using a subquery.
SELECT
    customer_id,
    customer_name
FROM clean_customers
WHERE customer_id IN (
    SELECT customer_id
    FROM order_transactions
    WHERE customer_id IS NOT NULL
);

-- Customers without orders using a CTE.
WITH customers_with_orders AS (
    SELECT DISTINCT
        customer_id
    FROM order_transactions
    WHERE customer_id IS NOT NULL
)
SELECT
    c.customer_id,
    c.customer_name
FROM clean_customers AS c
LEFT JOIN customers_with_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Customer order totals with a CTE.
WITH customer_order_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS order_total
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    customer_id,
    order_total
FROM customer_order_totals;

-- Latest record filtering using a CTE.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM order_transactions
)
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at
FROM ranked_orders
WHERE row_num = 1;

-- Source-target validation concept.
SELECT
    'order_transactions' AS source_name,
    COUNT(*) AS row_count
FROM order_transactions
UNION ALL
SELECT
    'clean_customers' AS source_name,
    COUNT(*) AS row_count
FROM clean_customers;
