-- Day 030 Mini Project: Design a Small Data Interface Layer
-- Purpose: Combine raw, clean, reporting, consumer, and validation thinking.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Part 1: Raw event review.
SELECT
    event_id,
    customer_id,
    event_type,
    event_timestamp,
    event_value,
    received_at,
    source_file
FROM raw_customer_events
ORDER BY event_id, received_at;

SELECT
    event_id,
    COUNT(*) AS delivery_count
FROM raw_customer_events
GROUP BY event_id
HAVING COUNT(*) > 1;

SELECT
    event_id,
    customer_id,
    event_value,
    'RAW_EVENT_REVIEW' AS issue_type
FROM raw_customer_events
WHERE event_value IS NULL;

-- Part 2: Clean customer interface.
-- Decision: clean table if stored current state is required; clean view if live logic is enough.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    signup_date,
    updated_at,
    source_file
FROM clean_customers;

-- Part 3: Valid-order interface and review rows.
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount,
        updated_at,
        source_file
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
review_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        updated_at,
        source_file
    FROM order_transactions
    WHERE customer_id IS NULL
       OR order_amount <= 0
)
SELECT
    'VALID_ORDER_COUNT' AS metric_name,
    COUNT(*) AS metric_value
FROM valid_orders
UNION ALL
SELECT
    'REVIEW_ORDER_COUNT',
    COUNT(*)
FROM review_orders;

-- Part 4: Customer sales reporting interface.
WITH valid_orders AS (
    SELECT customer_id, order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
customer_sales AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_order_count,
        SUM(order_amount) AS completed_order_amount
    FROM valid_orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    customer_sales.completed_order_count,
    customer_sales.completed_order_amount
FROM clean_customers AS c
INNER JOIN customer_sales
    ON c.customer_id = customer_sales.customer_id;

-- Part 5: Daily regional reporting interface.
SELECT
    report_date,
    region,
    total_orders,
    total_sales,
    total_refunds,
    reporting_loaded_at
FROM daily_sales_reporting
ORDER BY report_date, region;

-- Part 6: Consumer mapping.
SELECT
    consumer_name,
    consumer_type,
    required_interface,
    expected_grain,
    change_sensitivity
FROM interface_consumers
ORDER BY required_interface, consumer_name;

-- Part 7: Combined review queue.
SELECT
    'raw_customer_events' AS source_area,
    event_id AS entity_key,
    'NULL_EVENT_VALUE' AS issue_type,
    event_value AS issue_value,
    'Raw event value is null and should be reviewed.' AS review_message
FROM raw_customer_events
WHERE event_value IS NULL
UNION ALL
SELECT
    'order_transactions',
    order_id,
    'INVALID_ORDER',
    order_amount,
    'Order has null customer or invalid amount.'
FROM order_transactions
WHERE customer_id IS NULL
   OR order_amount <= 0
UNION ALL
SELECT
    'daily_sales_reporting',
    region,
    'NULL_REPORTING_METRIC',
    total_sales,
    'Reporting total_sales is null.'
FROM daily_sales_reporting
WHERE total_sales IS NULL;

-- Part 8: Decision summary.
SELECT
    recommended_interface AS interface_name,
    recommended_interface AS recommended_type,
    required_output_grain AS output_grain,
    business_question AS main_consumer,
    persistence_need,
    history_need,
    main_risk,
    validation_check AS required_validation
FROM interface_decision_cases
ORDER BY case_id;

-- Part 9: Validation summary.
WITH duplicate_reporting AS (
    SELECT report_date, region
    FROM daily_sales_reporting
    GROUP BY report_date, region
    HAVING COUNT(*) > 1
),
invalid_orders AS (
    SELECT order_id
    FROM order_transactions
    WHERE customer_id IS NULL
       OR order_amount <= 0
),
null_customers AS (
    SELECT customer_id
    FROM clean_customers
    WHERE country IS NULL
)
SELECT
    'DUPLICATE_REPORTING_ROWS' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Daily reporting should be one row per region-date.' AS explanation
FROM duplicate_reporting
UNION ALL
SELECT
    'INVALID_ORDERS',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Invalid orders should feed an exception output.'
FROM invalid_orders
UNION ALL
SELECT
    'NULL_CUSTOMER_COUNTRY',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Customer country supports reporting and should be reviewed when null.'
FROM null_customers;
