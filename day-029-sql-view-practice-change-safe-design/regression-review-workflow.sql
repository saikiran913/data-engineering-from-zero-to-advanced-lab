-- Day 029: Regression Review Workflow
-- Purpose: End-to-end read-only review for a proposed customer sales summary change.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Stage 1 and 2: define old and proposed logic.
WITH old_logic AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_order_count,
        SUM(order_amount) AS completed_order_amount,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS latest_order_date
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
new_logic AS (
    SELECT
        customer_id,
        COUNT(*) AS reportable_order_count,
        SUM(order_amount) AS reportable_order_amount,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS latest_order_date
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND order_amount > 0
    GROUP BY customer_id
),
joined_comparison AS (
    SELECT
        old_logic.customer_id,
        old_logic.completed_order_count,
        new_logic.reportable_order_count,
        old_logic.completed_order_amount,
        new_logic.reportable_order_amount,
        old_logic.first_order_date AS old_first_order_date,
        new_logic.first_order_date AS new_first_order_date,
        old_logic.latest_order_date AS old_latest_order_date,
        new_logic.latest_order_date AS new_latest_order_date
    FROM old_logic
    INNER JOIN new_logic
        ON old_logic.customer_id = new_logic.customer_id
)
SELECT
    customer_id,
    completed_order_count,
    reportable_order_count,
    completed_order_amount,
    reportable_order_amount
FROM joined_comparison
ORDER BY customer_id;

-- Stages 3 to 7: validation summary.
WITH old_logic AS (
    SELECT customer_id, SUM(order_amount) AS amount, MIN(order_date) AS first_date, MAX(order_date) AS latest_date
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
new_logic AS (
    SELECT customer_id, SUM(order_amount) AS amount, MIN(order_date) AS first_date, MAX(order_date) AS latest_date
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND order_amount > 0
    GROUP BY customer_id
),
checks AS (
    SELECT
        'ROW_COUNT' AS check_name,
        (SELECT COUNT(*) FROM old_logic) AS old_value,
        (SELECT COUNT(*) FROM new_logic) AS new_value,
        'Customer rows may increase if refunded-like orders introduce customers.' AS explanation
    UNION ALL
    SELECT
        'DISTINCT_KEYS',
        (SELECT COUNT(DISTINCT customer_id) FROM old_logic),
        (SELECT COUNT(DISTINCT customer_id) FROM new_logic),
        'Distinct customer counts should be reviewed.'
    UNION ALL
    SELECT
        'NULL_KEYS',
        (SELECT COUNT(*) FROM old_logic WHERE customer_id IS NULL),
        (SELECT COUNT(*) FROM new_logic WHERE customer_id IS NULL),
        'Customer keys should not be null after filtering.'
    UNION ALL
    SELECT
        'TOTAL_AMOUNT',
        (SELECT SUM(amount) FROM old_logic),
        (SELECT SUM(amount) FROM new_logic),
        'Amount difference may be expected if refunded-like rows are included.'
)
SELECT
    check_name,
    old_value,
    new_value,
    new_value - old_value AS difference,
    CASE
        WHEN old_value = new_value THEN 'PASS'
        WHEN check_name = 'TOTAL_AMOUNT' THEN 'EXPECTED_CHANGE'
        ELSE 'REVIEW'
    END AS status,
    explanation
FROM checks;

-- Stage 8: old-only rows.
WITH old_logic AS (
    SELECT customer_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
new_logic AS (
    SELECT customer_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    old_logic.customer_id,
    'ONLY_IN_OLD' AS difference_type
FROM old_logic
LEFT JOIN new_logic
    ON old_logic.customer_id = new_logic.customer_id
WHERE new_logic.customer_id IS NULL;

-- Stage 9: new-only rows.
WITH old_logic AS (
    SELECT customer_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
new_logic AS (
    SELECT customer_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    new_logic.customer_id,
    'ONLY_IN_NEW' AS difference_type
FROM new_logic
LEFT JOIN old_logic
    ON new_logic.customer_id = old_logic.customer_id
WHERE old_logic.customer_id IS NULL;

-- Stages 10 and 11: changed values and representative samples.
WITH old_logic AS (
    SELECT customer_id, SUM(order_amount) AS amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
new_logic AS (
    SELECT customer_id, SUM(order_amount) AS amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    old_logic.customer_id,
    old_logic.amount AS old_amount,
    new_logic.amount AS new_amount,
    new_logic.amount - old_logic.amount AS amount_difference
FROM old_logic
INNER JOIN new_logic
    ON old_logic.customer_id = new_logic.customer_id
WHERE old_logic.amount <> new_logic.amount
ORDER BY old_logic.customer_id;

-- Stage 13: consumer-impact summary.
SELECT
    consumer_name,
    view_name,
    required_columns,
    change_sensitivity,
    'Review alias and metric meaning before changing customer sales summary.' AS review_action
FROM view_consumers
WHERE view_name = 'vw_customer_sales_summary';

-- Stage 14: final review queue.
SELECT
    'HIGH_SENSITIVITY_CONSUMER' AS issue_type,
    consumer_name AS entity_name,
    view_name,
    change_sensitivity,
    'Consumer needs review before proposed change.' AS review_message
FROM view_consumers
WHERE view_name = 'vw_customer_sales_summary'
  AND change_sensitivity = 'HIGH'
UNION ALL
SELECT
    'EXPECTED_TOTAL_CHANGE',
    'customer_sales_summary',
    'vw_customer_sales_summary',
    'HIGH',
    'Total amount changes when refunded-like rows are included.'
FROM view_change_cases
WHERE case_id = 'CASE012';
