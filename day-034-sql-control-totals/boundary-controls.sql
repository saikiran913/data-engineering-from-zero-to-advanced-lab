-- Day 034: Boundary Controls
-- Purpose: Use MIN and MAX to validate date and value boundaries.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: source date and amount boundaries.
-- Source population: source_sales_extract.
-- Source grain: one source record.
-- Control type: boundary.
SELECT
    MIN(order_date) AS minimum_source_order_date,
    MAX(order_date) AS maximum_source_order_date,
    MIN(order_amount) AS minimum_source_order_amount,
    MAX(order_amount) AS maximum_source_order_amount
FROM source_sales_extract;

-- Query 2: clean date and amount boundaries.
SELECT
    MIN(order_date) AS minimum_clean_order_date,
    MAX(order_date) AS maximum_clean_order_date,
    MIN(order_amount) AS minimum_clean_order_amount,
    MAX(order_amount) AS maximum_clean_order_amount
FROM clean_sales_output;

-- Query 3: source-to-clean boundary comparison.
WITH source_boundaries AS (
    SELECT
        MIN(order_date) AS minimum_order_date,
        MAX(order_date) AS maximum_order_date,
        MIN(order_amount) AS minimum_order_amount,
        MAX(order_amount) AS maximum_order_amount
    FROM source_sales_extract
),
clean_boundaries AS (
    SELECT
        MIN(order_date) AS minimum_order_date,
        MAX(order_date) AS maximum_order_date,
        MIN(order_amount) AS minimum_order_amount,
        MAX(order_amount) AS maximum_order_amount
    FROM clean_sales_output
)
SELECT
    s.minimum_order_date AS source_minimum_date,
    c.minimum_order_date AS clean_minimum_date,
    s.maximum_order_date AS source_maximum_date,
    c.maximum_order_date AS clean_maximum_date,
    s.minimum_order_amount AS source_minimum_amount,
    c.minimum_order_amount AS clean_minimum_amount,
    s.maximum_order_amount AS source_maximum_amount,
    c.maximum_order_amount AS clean_maximum_amount
FROM source_boundaries AS s
CROSS JOIN clean_boundaries AS c;

-- Query 4: reporting date boundaries.
SELECT
    MIN(report_date) AS minimum_report_date,
    MAX(report_date) AS maximum_report_date
FROM reporting_sales_summary;

-- Query 5: inspect abnormal clean value boundaries.
SELECT
    order_id,
    order_status,
    order_date,
    order_amount,
    source_file
FROM clean_sales_output
WHERE order_amount = (
    SELECT MAX(order_amount)
    FROM clean_sales_output
)
   OR order_amount = (
    SELECT MIN(order_amount)
    FROM clean_sales_output
)
ORDER BY
    order_amount;
