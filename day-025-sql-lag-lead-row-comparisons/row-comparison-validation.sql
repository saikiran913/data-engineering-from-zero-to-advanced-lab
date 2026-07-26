-- Day 025: Row-Comparison Validation
-- Topic: Validate partitions, ordering, boundaries, gaps, and changes.
-- Safety note: every query in this file is read-only.

-- 1 and 2: Count partitions and rows per partition.
SELECT region, COUNT(*) AS row_count
FROM daily_sales_history
GROUP BY region
ORDER BY region;

-- 3: Find null ordering columns.
SELECT 'daily_sales_history' AS dataset, region AS entity_key, sale_date AS ordering_value
FROM daily_sales_history
WHERE sale_date IS NULL
UNION ALL
SELECT 'website_event_sequence' AS dataset, user_id AS entity_key, event_timestamp AS ordering_value
FROM website_event_sequence
WHERE event_timestamp IS NULL;

-- 4: Find duplicate ordering values.
SELECT user_id, event_sequence, COUNT(*) AS duplicate_ordering_count
FROM website_event_sequence
GROUP BY user_id, event_sequence
HAVING COUNT(*) > 1
ORDER BY user_id, event_sequence;

-- 5 and 6: Find first-row and last-row counts.
WITH event_neighbours AS (
    SELECT
        user_id,
        event_id,
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
    user_id,
    SUM(CASE WHEN previous_event_id IS NULL THEN 1 ELSE 0 END) AS first_row_count,
    SUM(CASE WHEN next_event_id IS NULL THEN 1 ELSE 0 END) AS last_row_count
FROM event_neighbours
GROUP BY user_id
ORDER BY user_id;

-- 7 and 8: Unexpected null neighbour values inside a sequence.
WITH payment_neighbours AS (
    SELECT
        transaction_id,
        status_sequence,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status,
        LEAD(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS next_status
    FROM payment_status_history
)
SELECT transaction_id, COUNT(*) AS rows_checked
FROM payment_neighbours
GROUP BY transaction_id
ORDER BY transaction_id;

-- 9 and 10: Validate one first and one last row per partition.
WITH event_neighbours AS (
    SELECT
        user_id,
        event_id,
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
SELECT user_id
FROM event_neighbours
GROUP BY user_id
HAVING SUM(CASE WHEN previous_event_id IS NULL THEN 1 ELSE 0 END) <> 1
    OR SUM(CASE WHEN next_event_id IS NULL THEN 1 ELSE 0 END) <> 1;

-- 11 to 14: Review queue.
WITH event_comparison AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        LAG(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_sequence
    FROM website_event_sequence
)
SELECT
    'website_event_sequence' AS dataset,
    user_id AS entity_key,
    CASE
        WHEN previous_sequence IS NULL THEN 'FIRST_ROW'
        WHEN event_sequence - previous_sequence = 0 THEN 'DUPLICATE_SEQUENCE'
        WHEN event_sequence - previous_sequence > 1 THEN 'SEQUENCE_GAP'
        ELSE 'SEQUENCE_OK'
    END AS issue_type,
    event_sequence AS current_value,
    previous_sequence AS neighbour_value,
    event_sequence AS ordering_value,
    'Review sequence before reporting user journey' AS review_message
FROM event_comparison
WHERE previous_sequence IS NULL
   OR event_sequence - previous_sequence <> 1
ORDER BY entity_key, ordering_value;
