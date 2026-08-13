-- Day 033: Integrated Validation Workflow
-- Purpose: Combine count, key, total, completeness, and exception checks.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: integrated validation summary.
WITH accepted_review AS (
    SELECT
        COUNT(*) AS staged_count,
        SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
        SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
    FROM staged_order_output
),
clean_duplicates AS (
    SELECT
        COUNT(*) AS issue_count
    FROM (
        SELECT order_id
        FROM clean_order_output
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) AS duplicate_keys
),
target_only_clean AS (
    SELECT
        COUNT(*) AS issue_count
    FROM clean_order_output AS c
    LEFT JOIN source_order_extract AS s
        ON c.order_id = s.order_id
    WHERE s.order_id IS NULL
),
reporting_nulls AS (
    SELECT
        COUNT(*) AS issue_count
    FROM reporting_order_metrics
    WHERE completed_order_count IS NULL
       OR total_completed_amount IS NULL
       OR refund_order_count IS NULL
       OR total_refund_amount IS NULL
       OR pending_order_count IS NULL
)
SELECT
    'ACCEPTED_REVIEW_RECONCILIATION' AS check_name,
    staged_count - accepted_count - review_count AS issue_count,
    CASE
        WHEN staged_count - accepted_count - review_count = 0 THEN 'PASS'
        ELSE 'REVIEW'
    END AS validation_status
FROM accepted_review
UNION ALL
SELECT
    'CLEAN_DUPLICATE_KEYS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM clean_duplicates
UNION ALL
SELECT
    'TARGET_ONLY_CLEAN_KEYS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM target_only_clean
UNION ALL
SELECT
    'NULL_REPORTING_METRICS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM reporting_nulls
ORDER BY
    check_name;

-- Query 2: integrated exception output.
WITH source_only AS (
    SELECT
        s.order_id,
        s.source_file
    FROM source_order_extract AS s
    LEFT JOIN clean_order_output AS c
        ON s.order_id = c.order_id
    WHERE c.order_id IS NULL
),
target_only AS (
    SELECT
        c.order_id,
        c.source_file
    FROM clean_order_output AS c
    LEFT JOIN source_order_extract AS s
        ON c.order_id = s.order_id
    WHERE s.order_id IS NULL
)
SELECT
    'SOURCE_ONLY_ORDER' AS exception_type,
    order_id,
    source_file,
    'Review whether the source order was excluded by a documented rule.' AS review_message
FROM source_only
UNION ALL
SELECT
    'TARGET_ONLY_ORDER' AS exception_type,
    order_id,
    source_file,
    'Review why the clean order has no matching source order.' AS review_message
FROM target_only
ORDER BY
    exception_type,
    order_id;

-- Query 3: integrated grouped reconciliation.
WITH clean_metrics AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS total_completed_amount
    FROM clean_order_output
    GROUP BY
        order_date,
        country_group
),
report_metrics AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS total_completed_amount
    FROM reporting_order_metrics
    GROUP BY
        report_date,
        country_group
)
SELECT
    c.report_date,
    c.country_group,
    c.total_completed_amount AS clean_completed_amount,
    r.total_completed_amount AS reporting_completed_amount,
    r.total_completed_amount - c.total_completed_amount AS amount_difference
FROM clean_metrics AS c
LEFT JOIN report_metrics AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
ORDER BY
    c.report_date,
    c.country_group;
