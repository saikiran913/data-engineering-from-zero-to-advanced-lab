-- Day 034: Control-Total Summary
-- Purpose: Produce compact validation evidence rows.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: control summary across major controls.
WITH accepted_review AS (
    SELECT
        COUNT(*) AS total_stage_count,
        SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
        SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
    FROM staged_sales_output
),
clean_duplicates AS (
    SELECT COUNT(*) AS issue_count
    FROM (
        SELECT order_id
        FROM clean_sales_output
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) AS duplicate_keys
),
report_duplicates AS (
    SELECT COUNT(*) AS issue_count
    FROM (
        SELECT report_date, country_group
        FROM reporting_sales_summary
        GROUP BY report_date, country_group
        HAVING COUNT(*) > 1
    ) AS duplicate_groups
),
completed_amounts AS (
    SELECT
        (SELECT SUM(order_amount)
         FROM clean_sales_output
         WHERE order_status = 'COMPLETED') AS clean_amount,
        (SELECT SUM(total_completed_amount)
         FROM reporting_sales_summary) AS reporting_amount
)
SELECT
    'CTRL_STAGE_ACCEPTED_REVIEW' AS control_id,
    'accepted_review' AS control_type,
    0 AS expected_difference,
    total_stage_count - accepted_count - review_count AS actual_difference,
    CASE
        WHEN total_stage_count - accepted_count - review_count = 0 THEN 'PASS'
        ELSE 'REVIEW'
    END AS control_status
FROM accepted_review
UNION ALL
SELECT
    'CTRL_CLEAN_DUPLICATE_KEYS',
    'distinct_key',
    0,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM clean_duplicates
UNION ALL
SELECT
    'CTRL_REPORTING_DUPLICATE_GRAIN',
    'grouped_count',
    0,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM report_duplicates
UNION ALL
SELECT
    'CTRL_COMPLETED_AMOUNT',
    'sum',
    0,
    reporting_amount - clean_amount,
    CASE WHEN reporting_amount - clean_amount = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM completed_amounts
ORDER BY
    control_id;

-- Query 2: control rule catalogue.
SELECT
    control_id,
    stage_pair,
    control_type,
    control_name,
    expected_relationship,
    severity,
    review_message
FROM control_total_rules
ORDER BY
    control_id;
