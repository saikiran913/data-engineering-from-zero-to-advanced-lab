-- Day 025: LAG and LEAD Concept
-- Topic: Compare current rows with previous and next rows.
-- Safety note: every query in this file is read-only.

-- Section 1: Preview source data.
SELECT sale_date, region, total_sales, loaded_at
FROM daily_sales_history
ORDER BY region, sale_date;

-- Section 2: Previous daily sales with LAG.
-- Grain: one row per region per sale date.
-- Partition key: region. Ordering: sale_date.
SELECT
    sale_date,
    region,
    total_sales,
    LAG(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date
    ) AS previous_sales
FROM daily_sales_history
ORDER BY region, sale_date;

-- Section 3: Next daily sales with LEAD.
SELECT
    sale_date,
    region,
    total_sales,
    LEAD(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date
    ) AS next_sales
FROM daily_sales_history
ORDER BY region, sale_date;

-- Section 4: Previous payment status.
SELECT
    transaction_id,
    status_sequence,
    payment_status,
    LAG(payment_status) OVER (
        PARTITION BY transaction_id
        ORDER BY status_sequence, status_timestamp
    ) AS previous_payment_status
FROM payment_status_history
ORDER BY transaction_id, status_sequence, status_timestamp;

-- Section 5: Boundary flags.
WITH event_neighbours AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        event_name,
        LAG(event_id) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_event_id,
        LEAD(event_id) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS next_event_id
    FROM website_event_sequence
)
SELECT
    event_id,
    user_id,
    event_sequence,
    event_name,
    CASE
        WHEN previous_event_id IS NULL THEN 'FIRST_EVENT'
        ELSE 'HAS_PREVIOUS_EVENT'
    END AS first_row_flag,
    CASE
        WHEN next_event_id IS NULL THEN 'LAST_EVENT'
        ELSE 'HAS_NEXT_EVENT'
    END AS last_row_flag
FROM event_neighbours
ORDER BY user_id, event_sequence, event_id;

-- Section 6: Simple difference and CTE-based filtering.
WITH sales_comparison AS (
    SELECT
        sale_date,
        region,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sales
    FROM daily_sales_history
)
SELECT
    sale_date,
    region,
    total_sales,
    previous_sales,
    total_sales - previous_sales AS sales_change
FROM sales_comparison
WHERE previous_sales IS NOT NULL
ORDER BY region, sale_date;

-- Practice tasks:
-- 1. Compare current and next payment statuses.
-- 2. Add a change flag for daily sales increases and decreases.
-- 3. Review first and last rows before treating null neighbours as errors.
