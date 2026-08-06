-- Day 032: Integrated Staging Workflow
-- Purpose: Combine standardisation, deduplication, validation, clean output, and reporting output.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: integrated accepted and review staging result.
-- Input grain: one raw source event.
-- Output grain: one validated candidate per order.
-- Business key: order_id.
WITH source_events AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        raw_status,
        event_timestamp,
        order_amount,
        country_code,
        source_file,
        received_at
    FROM raw_customer_orders
),
standardised_events AS (
    SELECT
        s.source_event_id,
        s.order_id,
        s.customer_id,
        s.raw_status,
        m.standard_status,
        m.is_supported,
        m.review_required,
        s.event_timestamp,
        s.order_amount,
        CASE
            WHEN s.country_code = 'IN' THEN 'India'
            WHEN s.country_code = 'UK' THEN 'Europe'
            WHEN s.country_code = 'US' THEN 'North America'
            WHEN s.country_code = 'SG' THEN 'Asia Pacific'
            ELSE 'Other'
        END AS country_group,
        s.source_file,
        s.received_at
    FROM source_events AS s
    LEFT JOIN source_status_mapping AS m
        ON s.raw_status = m.source_status
),
ranked_events AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        raw_status,
        standard_status,
        is_supported,
        review_required,
        event_timestamp,
        order_amount,
        country_group,
        source_file,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC,
                     received_at DESC,
                     source_event_id
        ) AS row_num
    FROM standardised_events
),
candidate_orders AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        raw_status,
        standard_status,
        is_supported,
        review_required,
        event_timestamp,
        order_amount,
        country_group,
        source_file,
        received_at
    FROM ranked_events
    WHERE row_num = 1
),
validated_orders AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        standard_status,
        order_amount,
        event_timestamp AS order_timestamp,
        country_group,
        source_file,
        received_at,
        CASE
            WHEN order_id IS NULL THEN 'REVIEW'
            WHEN customer_id IS NULL THEN 'REVIEW'
            WHEN order_amount IS NULL THEN 'REVIEW'
            WHEN order_amount < 0 THEN 'REVIEW'
            WHEN order_amount = 0 THEN 'REVIEW'
            WHEN standard_status IS NULL THEN 'REVIEW'
            WHEN is_supported = 'No' THEN 'REVIEW'
            WHEN review_required = 'Yes' THEN 'REVIEW'
            ELSE 'ACCEPTED'
        END AS validation_status,
        CASE
            WHEN order_id IS NULL THEN 'NULL_ORDER_ID'
            WHEN customer_id IS NULL THEN 'NULL_CUSTOMER_ID'
            WHEN order_amount IS NULL THEN 'NULL_ORDER_AMOUNT'
            WHEN order_amount < 0 THEN 'NEGATIVE_ORDER_AMOUNT'
            WHEN order_amount = 0 THEN 'ZERO_AMOUNT_REVIEW'
            WHEN standard_status IS NULL THEN 'MISSING_STATUS_MAPPING'
            WHEN is_supported = 'No' THEN 'UNSUPPORTED_STATUS'
            WHEN review_required = 'Yes' THEN 'STATUS_REQUIRES_REVIEW'
            ELSE 'READY_FOR_CLEAN'
        END AS validation_reason
    FROM candidate_orders
)
SELECT
    source_event_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    order_timestamp,
    country_group,
    source_file,
    received_at,
    validation_status,
    validation_reason
FROM validated_orders
ORDER BY
    validation_status,
    order_id;

-- Query 2: clean-order projection from accepted staged data.
-- Input grain: one accepted staged candidate.
-- Output grain: one clean order.
-- Business key: order_id.
SELECT
    order_id,
    customer_id,
    standard_status AS order_status,
    order_amount,
    order_date,
    country_group,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED'
ORDER BY
    order_date,
    order_id;

-- Query 3: reporting projection from clean orders.
-- Input grain: one clean order.
-- Output grain: one row per date and country group.
-- Business key: order_date plus country_group.
SELECT
    order_date AS report_date,
    country_group,
    COUNT(*) AS clean_order_count,
    SUM(
        CASE
            WHEN order_status = 'COMPLETED' THEN order_amount
            ELSE 0
        END
    ) AS completed_amount_total,
    SUM(
        CASE
            WHEN order_status = 'REFUNDED' THEN order_amount
            ELSE 0
        END
    ) AS refund_amount_total
FROM clean_customer_orders
GROUP BY
    order_date,
    country_group
ORDER BY
    order_date,
    country_group;

-- Query 4: final handoff summary.
-- Input grain: one handoff case.
-- Output grain: one handoff case summary.
-- Business key: case_id.
SELECT
    case_id,
    stage_name,
    input_grain,
    output_grain,
    business_key,
    validation_check,
    downstream_handoff,
    main_risk
FROM staging_handoff_cases
ORDER BY
    case_id;
