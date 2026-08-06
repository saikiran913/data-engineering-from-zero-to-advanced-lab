-- Day 032: Multi-Step Transformation Practice
-- Purpose: Show a readable source-to-stage workflow with named CTE stages.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: staged candidates.
-- This query keeps each stage focused and documents grain as the data moves.
WITH source_events AS (
    -- Input grain: one row per received source order event.
    -- Output grain: one row per received source order event.
    -- Purpose: expose the raw source population.
    -- Key: source_event_id.
    -- Validation expectation: row count should match raw_customer_orders.
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
    -- Input grain: one raw event.
    -- Output grain: one standardised event.
    -- Purpose: add mapped status and simple country group.
    -- Key: source_event_id.
    -- Validation expectation: no row loss from the raw source.
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
ranked_order_events AS (
    -- Input grain: one standardised event.
    -- Output grain: one ranked event.
    -- Purpose: rank events inside each order_id.
    -- Key: source_event_id, with order_id as business key.
    -- Validation expectation: every non-null order_id can be ranked.
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
    -- Input grain: one ranked event.
    -- Output grain: one candidate row per order_id where possible.
    -- Purpose: select the latest candidate by the documented ordering rule.
    -- Key: order_id.
    -- Validation expectation: one candidate per non-null order_id.
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
    FROM ranked_order_events
    WHERE row_num = 1
),
validated_orders AS (
    -- Input grain: one candidate row per order_id.
    -- Output grain: one validated candidate row per order_id.
    -- Purpose: add visible accepted or review decisions.
    -- Key: order_id.
    -- Validation expectation: each candidate receives one status and reason.
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
),
accepted_orders AS (
    -- Input grain: one validated candidate.
    -- Output grain: one accepted candidate.
    -- Purpose: prepare rows allowed to move toward clean output.
    -- Key: order_id.
    -- Validation expectation: no review reasons should remain.
    SELECT
        source_event_id,
        order_id,
        customer_id,
        standard_status,
        order_amount,
        order_timestamp,
        country_group,
        source_file,
        received_at
    FROM validated_orders
    WHERE validation_status = 'ACCEPTED'
),
review_orders AS (
    -- Input grain: one validated candidate.
    -- Output grain: one review candidate.
    -- Purpose: preserve rows needing investigation.
    -- Key: order_id when present, otherwise source_event_id.
    -- Validation expectation: every review row has a visible reason.
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
        validation_reason
    FROM validated_orders
    WHERE validation_status = 'REVIEW'
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
ORDER BY order_id;

-- Query 2: accepted orders only.
WITH accepted_orders AS (
    SELECT
        stage_record_id,
        order_id,
        customer_id,
        standard_status,
        order_amount,
        order_date,
        country_group,
        source_event_id,
        source_file,
        received_at
    FROM staged_customer_orders
    WHERE validation_status = 'ACCEPTED'
)
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    order_date,
    country_group,
    source_event_id,
    source_file,
    received_at
FROM accepted_orders
ORDER BY order_date,
         order_id;

-- Query 3: review orders only.
WITH review_orders AS (
    SELECT
        stage_record_id,
        order_id,
        customer_id,
        standard_status,
        order_amount,
        order_date,
        country_group,
        source_event_id,
        source_file,
        received_at,
        validation_reason
    FROM staged_customer_orders
    WHERE validation_status = 'REVIEW'
)
SELECT
    stage_record_id,
    order_id,
    customer_id,
    validation_reason,
    source_event_id,
    source_file,
    received_at
FROM review_orders
ORDER BY validation_reason,
         order_id;

-- Query 4: validation summary.
SELECT
    validation_status,
    validation_reason,
    COUNT(*) AS row_count
FROM staged_customer_orders
GROUP BY
    validation_status,
    validation_reason
ORDER BY
    validation_status,
    validation_reason;
