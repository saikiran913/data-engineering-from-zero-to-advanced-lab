-- Day 030: View Versus CTE Comparison
-- Purpose: Compare reusable view logic with one-statement CTE logic.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Reusable valid-orders logic as a CTE.
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
)
SELECT
    customer_id,
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_amount
FROM valid_orders
GROUP BY customer_id;

-- Conceptual view definition only.
-- CREATE VIEW vw_valid_orders AS
-- SELECT order_id, customer_id, order_date, order_amount
-- FROM order_transactions
-- WHERE customer_id IS NOT NULL
--   AND order_amount > 0
--   AND order_status = 'COMPLETED';

-- Customer sales summary with CTEs.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
),
customer_sales AS (
    SELECT
        customer_id,
        SUM(order_amount) AS completed_order_amount
    FROM valid_orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    customer_sales.completed_order_amount
FROM clean_customers AS c
INNER JOIN customer_sales
    ON c.customer_id = customer_sales.customer_id;

-- Campaign-style latest delivery using raw events.
WITH ranked_events AS (
    SELECT
        event_id,
        customer_id,
        event_type,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY received_at DESC
        ) AS row_num
    FROM raw_customer_events
)
SELECT
    event_id,
    customer_id,
    event_type,
    received_at
FROM ranked_events
WHERE row_num = 1;

-- Exception queue with CTE.
WITH order_exceptions AS (
    SELECT
        order_id AS entity_key,
        'ORDER_REVIEW' AS issue_type
    FROM order_transactions
    WHERE customer_id IS NULL
       OR order_amount <= 0
)
SELECT
    entity_key,
    issue_type
FROM order_exceptions;

-- Current-state customer logic is already suitable as a clean table in the sample data.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status
FROM clean_customers;
