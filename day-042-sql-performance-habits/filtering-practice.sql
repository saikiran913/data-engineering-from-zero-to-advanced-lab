-- Day 042: Filtering Practice
-- Purpose: Practise keeping only the rows needed for the business result.
-- Safety: All executable SQL is read-only.
-- Business goal: reduce unnecessary rows without changing meaning.

-- Section 1: full dataset for context.
SELECT
    order_id,
    order_date,
    order_status,
    country_group,
    order_amount
FROM orders_performance_sample;

-- Section 2: date filter for the business period.
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_date >= '2026-08-01'
  AND order_date < '2026-09-01';

-- Section 3: status filter.
SELECT
    order_id,
    order_status,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Section 4: country filter.
SELECT
    order_id,
    country_group,
    order_amount
FROM orders_performance_sample
WHERE country_group = 'UK';

-- Section 5: combined filters.
SELECT
    order_id,
    order_date,
    country_group,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
  AND country_group IN ('UK', 'India')
  AND order_date >= '2026-08-01'
  AND order_date < '2026-09-01';

-- Section 6: filter before aggregation when the report only needs completed orders.
SELECT
    country_group,
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
GROUP BY country_group
ORDER BY country_group;

-- Section 7: filter before inner join where logically safe.
WITH completed_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    o.order_id,
    o.order_date,
    o.order_amount,
    c.customer_segment
FROM completed_orders AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id;

-- Section 8: outer join caution.
-- Risky pattern: this WHERE condition removes rows with no matching active customer.
SELECT
    o.order_id,
    o.customer_id,
    c.customer_status
FROM orders_performance_sample AS o
LEFT JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_status = 'ACTIVE';

-- Section 9: safer optional-customer pattern when all orders must remain.
WITH active_customers AS (
    SELECT
        customer_id,
        customer_status
    FROM customers_performance_sample
    WHERE customer_status = 'ACTIVE'
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_status
FROM orders_performance_sample AS o
LEFT JOIN active_customers AS c
    ON o.customer_id = c.customer_id;

-- Section 10: filtering summary by status.
SELECT
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_amount
FROM orders_performance_sample
GROUP BY order_status
ORDER BY order_count DESC;

