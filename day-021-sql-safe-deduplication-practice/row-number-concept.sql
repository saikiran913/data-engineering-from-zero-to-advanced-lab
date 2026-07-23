-- Day 021: ROW_NUMBER Concept
-- Purpose: Understand safe SELECT-based row sequencing for duplicate groups.
-- Safety: These queries do not modify source data.

-- Preview source rows.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file
FROM raw_orders_duplicate_versions
ORDER BY order_id, updated_at, loaded_at;

-- Review duplicate counts before ranking.
SELECT
    order_id,
    COUNT(*) AS version_count
FROM raw_orders_duplicate_versions
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_id;

-- Rank newest order version first.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file,
    ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY updated_at DESC
    ) AS row_num
FROM raw_orders_duplicate_versions
ORDER BY order_id, row_num;

-- Rank earliest order version first.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file,
    ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY updated_at ASC
    ) AS row_num
FROM raw_orders_duplicate_versions
ORDER BY order_id, row_num;

-- Add a tie-breaker using loaded_at.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file,
    ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY updated_at DESC, loaded_at DESC
    ) AS row_num
FROM raw_orders_duplicate_versions
ORDER BY order_id, row_num;

-- Keep row number 1 safely using a CTE.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, loaded_at DESC
        ) AS row_num
    FROM raw_orders_duplicate_versions
)
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file,
    row_num
FROM ranked_orders
WHERE row_num = 1
ORDER BY order_id;

-- Show all ranked rows for review.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, loaded_at DESC
        ) AS row_num
    FROM raw_orders_duplicate_versions
)
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file,
    row_num
FROM ranked_orders
ORDER BY order_id, row_num;

-- Practice task: change DESC to ASC and compare which row becomes row_num = 1.
-- Practice task: remove loaded_at from ORDER BY and inspect tie behaviour.
