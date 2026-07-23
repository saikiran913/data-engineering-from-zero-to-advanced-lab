-- Day 021: Duplicate Resolution Patterns
-- Purpose: Practise documented rule patterns without modifying source data.
-- Safety: SELECT-only examples.

-- Pattern 1: prefer payment status using business priority.
WITH ranked_payments AS (
    SELECT
        transaction_id,
        order_id,
        payment_status,
        payment_amount,
        updated_at,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id
            ORDER BY
                CASE
                    WHEN payment_status = 'SUCCESS' THEN 1
                    WHEN payment_status = 'REFUNDED' THEN 2
                    WHEN payment_status = 'PENDING' THEN 3
                    WHEN payment_status = 'FAILED' THEN 4
                    ELSE 5
                END,
                updated_at DESC,
                loaded_at DESC
        ) AS row_num
    FROM payment_transaction_versions
)
SELECT *
FROM ranked_payments
WHERE row_num = 1
ORDER BY transaction_id;

-- Pattern 2: label keep and older order versions.
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
    *,
    CASE
        WHEN row_num = 1 THEN 'KEEP'
        ELSE 'OLDER_VERSION'
    END AS review_flag
FROM ranked_orders
ORDER BY order_id, row_num;

-- Pattern 3: label contact records for review when selected row has missing phone.
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
SELECT
    *,
    CASE
        WHEN row_num = 1 AND phone_number IS NULL THEN 'REVIEW'
        WHEN row_num = 1 THEN 'KEEP'
        ELSE 'OLDER_VERSION'
    END AS review_flag
FROM ranked_contacts
ORDER BY customer_id, row_num;

-- Pattern 4: campaign latest-load rule with composite key.
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
SELECT
    *,
    CASE
        WHEN row_num = 1 THEN 'KEEP'
        ELSE 'OLDER_VERSION'
    END AS review_flag
FROM ranked_campaigns
ORDER BY campaign_id, performance_date, channel, country, row_num;
