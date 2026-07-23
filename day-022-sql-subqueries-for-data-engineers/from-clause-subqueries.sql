-- Day 022: FROM-Clause Subqueries
-- Topic: Treating an inner query as a temporary table-like result.
-- Safety note: every query in this file is read-only.

-- 1. Customer order totals.
-- Inner query groups orders by customer.
-- Outer query filters the grouped result.
SELECT
    customer_id,
    order_count,
    total_order_value
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
) AS customer_totals
WHERE total_order_value > 500
ORDER BY total_order_value DESC;

-- 2. Daily sales totals above a fixed threshold.
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
WHERE daily_total > 500
ORDER BY daily_total DESC;

-- 3. Product sales summary.
SELECT
    product_id,
    sale_count,
    total_sales_amount
FROM (
    SELECT
        product_id,
        COUNT(*) AS sale_count,
        SUM(sales_amount) AS total_sales_amount
    FROM daily_sales
    GROUP BY product_id
) AS product_sales_summary
WHERE total_sales_amount > 300
ORDER BY total_sales_amount DESC;

-- 4. Status summary with more than one order.
SELECT
    order_status,
    status_order_count,
    status_total_amount
FROM (
    SELECT
        order_status,
        COUNT(*) AS status_order_count,
        SUM(order_amount) AS status_total_amount
    FROM orders
    GROUP BY order_status
) AS status_summary
WHERE status_order_count > 1
ORDER BY status_order_count DESC;

-- 5. Beginner version for daily totals above the average daily total.
-- This uses two simple layers and keeps nesting shallow.
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
WHERE daily_total > (
    SELECT AVG(daily_total)
    FROM (
        SELECT
            sale_date,
            SUM(sales_amount) AS daily_total
        FROM daily_sales
        GROUP BY sale_date
    ) AS average_input
)
ORDER BY daily_total DESC;

-- CTE preview only:
-- Day 023 will teach this style in detail because named steps can be easier to read.
