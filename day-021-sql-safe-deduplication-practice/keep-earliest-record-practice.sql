-- Day 021: Keep Earliest Record Practice
-- Purpose: Practise earliest-version selection with safe SELECT queries.
-- Safety: These queries do not modify source data.

-- Earliest order version.
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
            ORDER BY updated_at ASC, loaded_at ASC
        ) AS row_num
    FROM raw_orders_duplicate_versions
)
SELECT *
FROM ranked_orders
WHERE row_num = 1
ORDER BY order_id;

-- Earliest customer contact version.
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
            ORDER BY updated_date ASC, loaded_at ASC
        ) AS row_num
    FROM customer_contacts_versions
)
SELECT *
FROM ranked_contacts
WHERE row_num = 1
ORDER BY customer_id;

-- Earliest website event occurrence.
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
            ORDER BY event_timestamp ASC, received_at ASC
        ) AS row_num
    FROM website_event_versions
)
SELECT *
FROM ranked_events
WHERE row_num = 1
ORDER BY event_id;

-- Earliest campaign delivery by composite key.
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
            ORDER BY loaded_at ASC, source_file ASC
        ) AS row_num
    FROM campaign_performance_versions
)
SELECT *
FROM ranked_campaigns
WHERE row_num = 1
ORDER BY campaign_id, performance_date, channel, country;
