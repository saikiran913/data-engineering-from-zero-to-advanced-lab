-- Day 021: Keep Latest Record Practice
-- Purpose: Practise latest-version selection with documented ordering rules.
-- Safety: These SELECT queries do not modify source data.

-- Example 1: latest order version by updated_at, then loaded_at.
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
SELECT *
FROM ranked_orders
WHERE row_num = 1
ORDER BY order_id;

-- Example 2: latest customer contact version by updated_date, then loaded_at.
WITH ranked_contacts AS (
    SELECT
        customer_id,
        email,
        phone_number,
        contact_status,
        updated_date,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_date DESC, loaded_at DESC
        ) AS row_num
    FROM customer_contacts_versions
)
SELECT *
FROM ranked_contacts
WHERE row_num = 1
ORDER BY customer_id;

-- Example 3: latest website event version by event time, then receive time.
WITH ranked_events AS (
    SELECT
        event_id,
        user_id,
        event_name,
        event_timestamp,
        received_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY event_timestamp DESC, received_at DESC
        ) AS row_num
    FROM website_event_versions
)
SELECT *
FROM ranked_events
WHERE row_num = 1
ORDER BY event_id;

-- Example 4: latest campaign performance delivery by composite key.
WITH ranked_campaigns AS (
    SELECT
        campaign_id,
        performance_date,
        channel,
        country,
        impressions,
        clicks,
        spend,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY campaign_id, performance_date, channel, country
            ORDER BY loaded_at DESC, source_file DESC
        ) AS row_num
    FROM campaign_performance_versions
)
SELECT *
FROM ranked_campaigns
WHERE row_num = 1
ORDER BY campaign_id, performance_date, channel, country;

-- Example 5: latest order with review metadata.
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
    row_num,
    CASE
        WHEN row_num = 1 THEN 'KEEP'
        ELSE 'OLDER_VERSION'
    END AS dedup_action
FROM ranked_orders
ORDER BY order_id, row_num;
