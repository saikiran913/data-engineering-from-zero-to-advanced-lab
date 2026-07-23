-- Day 023: Multiple CTE Practice
-- Topic: Build logic through named steps in dependency order.
-- Safety note: every query in this file is read-only.

-- Workflow 1: Valid orders to customer totals.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM valid_orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_order_value > 500
ORDER BY total_order_value DESC;

-- Workflow 2: Latest order versions to completed-order summary.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_orders
),
latest_orders AS (
    SELECT order_id, customer_id, order_status, order_amount, updated_at, source_file
    FROM ranked_orders
    WHERE row_num = 1
),
completed_orders AS (
    SELECT *
    FROM latest_orders
    WHERE order_status = 'COMPLETED'
      AND customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_total
FROM completed_orders;

-- Workflow 3: Successful payments to paid orders.
WITH successful_payments AS (
    SELECT order_id, SUM(payment_amount) AS successful_payment_amount
    FROM payments
    WHERE payment_status = 'SUCCESS'
    GROUP BY order_id
),
paid_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_amount,
        p.successful_payment_amount
    FROM raw_orders AS o
    JOIN successful_payments AS p
        ON o.order_id = p.order_id
    WHERE o.order_status = 'COMPLETED'
      AND o.order_amount > 0
)
SELECT *
FROM paid_orders
ORDER BY order_id;

-- Workflow 4: Daily sales cleanup to daily totals.
WITH valid_sales AS (
    SELECT sale_date, product_id, customer_id, quantity, sales_amount
    FROM daily_sales
    WHERE product_id IS NOT NULL
      AND quantity > 0
      AND sales_amount > 0
),
daily_totals AS (
    SELECT
        sale_date,
        SUM(quantity) AS total_quantity,
        SUM(sales_amount) AS total_sales_amount
    FROM valid_sales
    GROUP BY sale_date
)
SELECT *
FROM daily_totals
WHERE total_sales_amount > 500
ORDER BY total_sales_amount DESC;

-- Workflow 5: Source-target comparison.
WITH source_data AS (
    SELECT record_id, business_key, record_value, record_status
    FROM source_records
),
target_data AS (
    SELECT record_id, business_key, record_value, record_status
    FROM target_records
),
missing_target_records AS (
    SELECT
        s.record_id,
        s.business_key,
        s.record_value,
        s.record_status
    FROM source_data AS s
    LEFT JOIN target_data AS t
        ON s.record_id = t.record_id
    WHERE t.record_id IS NULL
)
SELECT *
FROM missing_target_records
ORDER BY record_id;
