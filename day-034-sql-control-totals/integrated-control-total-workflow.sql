-- Day 034: Integrated Control-Total Workflow
-- Purpose: Combine counts, distinct keys, sums, boundaries, and grouped controls.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: integrated control summary.
WITH source_controls AS (
    SELECT
        COUNT(*) AS source_rows,
        COUNT(DISTINCT order_id) AS source_distinct_orders,
        SUM(order_amount) AS source_amount,
        MIN(order_date) AS source_min_date,
        MAX(order_date) AS source_max_date
    FROM source_sales_extract
),
stage_controls AS (
    SELECT
        COUNT(*) AS stage_rows,
        SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_rows,
        SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_rows
    FROM staged_sales_output
),
clean_controls AS (
    SELECT
        COUNT(*) AS clean_rows,
        COUNT(DISTINCT order_id) AS clean_distinct_orders,
        SUM(order_amount) AS clean_amount,
        MIN(order_date) AS clean_min_date,
        MAX(order_date) AS clean_max_date
    FROM clean_sales_output
)
SELECT
    s.source_rows,
    s.source_distinct_orders,
    st.stage_rows,
    st.accepted_rows,
    st.review_rows,
    st.stage_rows - st.accepted_rows - st.review_rows AS stage_unexplained_difference,
    c.clean_rows,
    c.clean_distinct_orders,
    c.clean_rows - c.clean_distinct_orders AS clean_duplicate_key_rows,
    s.source_min_date,
    c.clean_min_date,
    s.source_max_date,
    c.clean_max_date
FROM source_controls AS s
CROSS JOIN stage_controls AS st
CROSS JOIN clean_controls AS c;

-- Query 2: integrated clean-to-reporting grouped completed amount control.
WITH clean_grouped AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_sales_output
    GROUP BY order_date, country_group
),
report_grouped AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_sales_summary
    GROUP BY report_date, country_group
)
SELECT
    c.report_date,
    c.country_group,
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS reconciliation_difference
FROM clean_grouped AS c
LEFT JOIN report_grouped AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
ORDER BY
    c.report_date,
    c.country_group;

-- Query 3: integrated casebook review.
SELECT
    case_id,
    business_question,
    control_type,
    expected_relationship,
    expected_difference,
    recommended_check
FROM reconciliation_cases
ORDER BY
    case_id;
