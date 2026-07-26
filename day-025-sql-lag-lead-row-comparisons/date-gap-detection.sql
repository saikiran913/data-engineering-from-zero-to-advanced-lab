-- Day 025: Date Gap Detection
-- Topic: Compare current and previous dates to review missing intervals.
-- Safety note: every query in this file is read-only.

-- Daily sales date gaps by region.
-- Date subtraction syntax varies by SQL platform.
-- Some platforms allow sale_date - previous_sale_date, while others need DATEDIFF.
WITH sales_dates AS (
    SELECT
        sale_date,
        region,
        total_sales,
        LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sale_date
    FROM daily_sales_history
)
SELECT
    sale_date,
    region,
    total_sales,
    previous_sale_date,
    CASE
        WHEN previous_sale_date IS NULL THEN 'FIRST_DATE'
        WHEN sale_date = previous_sale_date THEN 'DUPLICATE_DATE'
        ELSE 'CHECK_DATE_INTERVAL_FOR_PLATFORM'
    END AS date_gap_review_flag
FROM sales_dates
ORDER BY region, sale_date;

-- Expected daily interval concept.
-- Adjust the date-difference expression for your SQL platform.
WITH sales_dates AS (
    SELECT
        sale_date,
        region,
        LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sale_date
    FROM daily_sales_history
)
SELECT
    sale_date,
    region,
    previous_sale_date,
    'Expected interval is one calendar day' AS expected_interval_rule
FROM sales_dates
ORDER BY region, sale_date;

-- Order-history update gaps.
SELECT
    order_id,
    updated_at,
    LAG(updated_at) OVER (
        PARTITION BY order_id
        ORDER BY updated_at, version_number
    ) AS previous_updated_at
FROM customer_order_history
ORDER BY order_id, updated_at, version_number;

-- Product-price date gaps.
SELECT
    product_id,
    price_date,
    LAG(price_date) OVER (
        PARTITION BY product_id
        ORDER BY price_date, updated_at
    ) AS previous_price_date
FROM product_price_history
ORDER BY product_id, price_date, updated_at;

-- Missing-load-date review and late-arriving records.
SELECT
    sale_date,
    region,
    loaded_at,
    LAG(loaded_at) OVER (
        PARTITION BY region
        ORDER BY sale_date
    ) AS previous_loaded_at,
    'Business date gaps and load timestamp gaps answer different questions' AS review_note
FROM daily_sales_history
ORDER BY region, sale_date;

-- Validation summary.
WITH sales_dates AS (
    SELECT
        sale_date,
        region,
        LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sale_date
    FROM daily_sales_history
)
SELECT
    region,
    COUNT(*) AS rows_checked,
    SUM(CASE WHEN previous_sale_date IS NULL THEN 1 ELSE 0 END) AS first_date_rows,
    SUM(CASE WHEN sale_date = previous_sale_date THEN 1 ELSE 0 END) AS duplicate_date_rows,
    SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END) AS null_date_rows
FROM sales_dates
GROUP BY region
ORDER BY region;
