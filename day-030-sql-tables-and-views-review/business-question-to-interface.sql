-- Day 030: Business Question to Interface
-- Purpose: Translate business needs into table, view, CTE, subquery, or simple-query choices.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- 1. Store all raw customer events.
SELECT
    COUNT(*) AS raw_event_rows,
    COUNT(DISTINCT event_id) AS distinct_events
FROM raw_customer_events;

-- 2. Expose one current customer row.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status
FROM clean_customers;

-- 3. Reuse valid-order logic across reports.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_date, order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
)
SELECT COUNT(*) AS valid_order_count
FROM valid_orders;

-- 4. Calculate one-time average comparison.
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

-- 5. Build daily regional sales interface.
SELECT
    report_date,
    region,
    total_orders,
    total_sales,
    total_refunds
FROM daily_sales_reporting;

-- 6. Preserve monthly reporting history.
SELECT
    region,
    SUM(total_sales) AS month_sales
FROM daily_sales_reporting
WHERE total_sales IS NOT NULL
GROUP BY region;

-- 7. Create one-query deduplication step.
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
    order_amount
FROM ranked_orders
WHERE row_num = 1;

-- 8. Expose payment-style order exceptions.
SELECT
    order_id,
    customer_id,
    order_amount,
    'ORDER_EXCEPTION' AS issue_type
FROM order_transactions
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- 9. Support dashboard with stable columns.
SELECT
    report_date,
    region,
    total_sales,
    total_refunds
FROM daily_sales_reporting;

-- 10. Temporary source-target check.
SELECT
    'orders' AS dataset_name,
    COUNT(*) AS row_count
FROM order_transactions
UNION ALL
SELECT
    'customers',
    COUNT(*)
FROM clean_customers;

-- 11. Latest-order interface.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC
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

-- 12. Simple query when no new interface is needed.
SELECT
    customer_id,
    customer_name
FROM clean_customers
WHERE country = 'India';
