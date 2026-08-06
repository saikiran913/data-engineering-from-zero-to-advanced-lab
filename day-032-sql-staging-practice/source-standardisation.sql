-- Day 032: Source Standardisation Practice
-- Purpose: Prepare raw source values before business logic.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: map raw statuses while preserving raw values.
-- Input grain: one raw event.
-- Output grain: one standardised event.
-- Business key: source_event_id.
SELECT
    r.source_event_id,
    r.order_id,
    r.customer_id,
    r.raw_status,
    m.standard_status,
    m.is_supported,
    m.review_required,
    r.event_timestamp,
    r.order_amount,
    r.country_code,
    r.source_file,
    r.received_at
FROM raw_customer_orders AS r
LEFT JOIN source_status_mapping AS m
    ON r.raw_status = m.source_status
ORDER BY
    r.source_event_id;

-- Query 2: add simple country groups.
-- Input grain: one raw event.
-- Output grain: one raw event with a reporting-friendly country group.
-- Business key: source_event_id.
SELECT
    r.source_event_id,
    r.order_id,
    r.country_code,
    CASE
        WHEN r.country_code = 'IN' THEN 'India'
        WHEN r.country_code = 'UK' THEN 'Europe'
        WHEN r.country_code = 'US' THEN 'North America'
        WHEN r.country_code = 'SG' THEN 'Asia Pacific'
        ELSE 'Other'
    END AS country_group,
    r.source_file,
    r.received_at
FROM raw_customer_orders AS r
ORDER BY
    r.country_code,
    r.source_event_id;

-- Query 3: find raw statuses with no mapping row.
-- Input grain: one raw event.
-- Output grain: one unmatched raw status value.
-- Business key: raw_status.
SELECT
    r.raw_status,
    COUNT(*) AS event_count
FROM raw_customer_orders AS r
LEFT JOIN source_status_mapping AS m
    ON r.raw_status = m.source_status
WHERE m.source_status IS NULL
GROUP BY
    r.raw_status
ORDER BY
    r.raw_status;

-- Query 4: count source rows before and after mapping.
-- Input grain: one raw event.
-- Output grain: one reconciliation row.
-- Business key: not applicable.
WITH raw_count AS (
    SELECT
        COUNT(*) AS row_count
    FROM raw_customer_orders
),
mapped_count AS (
    SELECT
        COUNT(*) AS row_count
    FROM raw_customer_orders AS r
    LEFT JOIN source_status_mapping AS m
        ON r.raw_status = m.source_status
)
SELECT
    raw_count.row_count AS raw_event_count,
    mapped_count.row_count AS standardised_event_count,
    raw_count.row_count - mapped_count.row_count AS unexplained_difference
FROM raw_count
CROSS JOIN mapped_count;

-- Query 5: inspect support and review rules from the mapping table.
-- Input grain: one mapping row.
-- Output grain: one mapping row.
-- Business key: source_status.
SELECT
    source_status,
    standard_status,
    is_supported,
    reporting_category,
    review_required
FROM source_status_mapping
ORDER BY
    source_status;

-- Query 6: standardised sample with audit columns preserved.
-- Input grain: one raw event.
-- Output grain: one standardised event.
-- Business key: source_event_id.
SELECT
    r.source_event_id,
    r.order_id,
    r.raw_status,
    m.standard_status,
    r.order_amount,
    r.country_code,
    CASE
        WHEN r.country_code = 'IN' THEN 'India'
        WHEN r.country_code = 'UK' THEN 'Europe'
        WHEN r.country_code = 'US' THEN 'North America'
        WHEN r.country_code = 'SG' THEN 'Asia Pacific'
        ELSE 'Other'
    END AS country_group,
    r.source_file,
    r.received_at
FROM raw_customer_orders AS r
LEFT JOIN source_status_mapping AS m
    ON r.raw_status = m.source_status
ORDER BY
    r.received_at,
    r.source_event_id;
