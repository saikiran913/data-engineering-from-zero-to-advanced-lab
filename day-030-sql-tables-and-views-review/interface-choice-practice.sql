-- Day 030: Interface Choice Practice
-- Purpose: Practise choosing between tables, views, CTEs, subqueries, and simple queries.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Source preview: raw event history.
SELECT
    event_id,
    customer_id,
    event_type,
    event_timestamp,
    event_value,
    received_at,
    source_file
FROM raw_customer_events
ORDER BY event_id, received_at
LIMIT 20;

-- Scenario 1: Raw event history.
-- Source grain: one row per delivered event. Output grain: same.
-- Persistence need: yes. Reuse need: yes. History need: yes.
-- Recommended interface: raw table.
SELECT
    COUNT(*) AS raw_event_delivery_count,
    COUNT(DISTINCT event_id) AS distinct_event_count
FROM raw_customer_events;

-- Scenario 2: One-time duplicate investigation.
-- Recommended interface: one-time validation query.
SELECT
    event_id,
    COUNT(*) AS delivery_count
FROM raw_customer_events
GROUP BY event_id
HAVING COUNT(*) > 1;

-- Scenario 3: Customer-level clean dataset.
-- Recommended interface: clean table or clean view depending on storage need.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    signup_date,
    updated_at,
    source_file
FROM clean_customers;

-- Scenario 4: Repeated valid-order logic used by many consumers.
-- Recommended interface: view if live logic is enough; clean table if stored result is required.
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
      AND order_amount > 0
      AND order_status = 'COMPLETED'
)
SELECT
    COUNT(*) AS valid_order_count,
    SUM(order_amount) AS valid_order_total
FROM valid_orders;

-- Scenario 5: Scalar average comparison.
-- Recommended interface: subquery is enough.
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

-- Scenario 6: Dashboard-ready daily summary.
-- Recommended interface: reporting table or reporting view depending on persistence and freshness.
SELECT
    report_date,
    region,
    total_orders,
    total_sales,
    total_refunds
FROM daily_sales_reporting
ORDER BY report_date, region;

-- Scenario 7: Temporary staged transformation.
-- Recommended interface: CTE inside one statement.
WITH accepted_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS customer_order_total
    FROM accepted_orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    customer_order_total
FROM customer_totals
ORDER BY customer_id;

-- Scenario 8: Current-state event convenience.
-- Recommended interface: current-state view if reused; CTE if one query only.
WITH ranked_events AS (
    SELECT
        event_id,
        customer_id,
        event_type,
        event_timestamp,
        event_value,
        received_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY received_at DESC, source_file DESC
        ) AS row_num
    FROM raw_customer_events
)
SELECT
    event_id,
    customer_id,
    event_type,
    event_timestamp,
    event_value,
    received_at,
    source_file
FROM ranked_events
WHERE row_num = 1;

-- Scenario 9: Payment-like exception output from orders.
-- Recommended interface: exception view if reused; one-time query if temporary.
SELECT
    order_id,
    customer_id,
    order_amount,
    'ORDER_REVIEW' AS issue_type
FROM order_transactions
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- Scenario 10: Consumer inventory review.
-- Recommended interface: documentation table or metadata view.
SELECT
    consumer_name,
    required_interface,
    expected_grain,
    change_sensitivity
FROM interface_consumers
ORDER BY change_sensitivity, consumer_name;

-- Scenario 11: No-new-interface case.
-- Recommended interface: simple query.
SELECT
    customer_id,
    customer_name,
    country
FROM clean_customers
WHERE customer_status = 'ACTIVE';

-- Scenario 12: Decision-case answers.
SELECT
    case_id,
    business_question,
    recommended_interface,
    validation_check
FROM interface_decision_cases
ORDER BY case_id;
