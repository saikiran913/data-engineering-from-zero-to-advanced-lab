-- Day 021: Safe Dedup Review Queries
-- Purpose: Review duplicate groups, ties, and selected outputs.
-- Safety: SELECT-only validation and review queries.

-- Count order versions by business key.
SELECT
    order_id,
    COUNT(*) AS version_count
FROM raw_orders_duplicate_versions
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_id;

-- Find order groups with same updated_at values.
SELECT
    order_id,
    updated_at,
    COUNT(*) AS same_timestamp_count
FROM raw_orders_duplicate_versions
GROUP BY order_id, updated_at
HAVING COUNT(*) > 1
ORDER BY order_id, updated_at;

-- Review all versions of unresolved order examples.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    loaded_at,
    source_file
FROM raw_orders_duplicate_versions
WHERE order_id IN ('ORD-1004', 'ORD-1005')
ORDER BY order_id, updated_at, loaded_at;

-- Validate selected order output has one row per order_id.
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
    COUNT(*) AS selected_count
FROM ranked_orders
WHERE row_num = 1
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Review payment groups with inconsistent amounts.
SELECT
    transaction_id,
    COUNT(*) AS version_count,
    MIN(payment_amount) AS min_payment_amount,
    MAX(payment_amount) AS max_payment_amount
FROM payment_transaction_versions
GROUP BY transaction_id
HAVING MIN(payment_amount) <> MAX(payment_amount)
ORDER BY transaction_id;

-- Review event groups with conflicting names.
SELECT
    event_id,
    COUNT(*) AS version_count,
    MIN(event_name) AS first_event_name,
    MAX(event_name) AS last_event_name
FROM website_event_versions
GROUP BY event_id
HAVING MIN(event_name) <> MAX(event_name)
ORDER BY event_id;

-- Review campaign groups with same loaded_at values.
SELECT
    campaign_id,
    performance_date,
    channel,
    country,
    loaded_at,
    COUNT(*) AS same_load_count
FROM campaign_performance_versions
GROUP BY campaign_id, performance_date, channel, country, loaded_at
HAVING COUNT(*) > 1
ORDER BY campaign_id, performance_date, channel, country;

-- Show rule examples that require review.
SELECT
    scenario_id,
    dataset_name,
    business_key,
    recommended_rule,
    tie_breaker,
    review_required,
    reason_for_review
FROM deduplication_rule_examples
WHERE review_required = 'Yes'
ORDER BY scenario_id;
