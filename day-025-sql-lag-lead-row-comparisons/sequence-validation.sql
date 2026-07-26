-- Day 025: Sequence Validation
-- Topic: Use LAG to validate numeric and event sequences.
-- Safety note: every query in this file is read-only.

-- Previous event sequence.
WITH event_comparison AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        event_name,
        event_timestamp,
        LAG(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_sequence
    FROM website_event_sequence
)
SELECT *
FROM event_comparison
ORDER BY user_id, event_sequence, event_id;

-- Expected sequence difference and issue flags.
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
    event_id,
    user_id AS entity_id,
    event_sequence AS current_sequence,
    previous_sequence,
    event_sequence - previous_sequence AS sequence_difference,
    CASE
        WHEN previous_sequence IS NULL THEN 'FIRST_EVENT'
        WHEN event_sequence - previous_sequence = 1 THEN 'SEQUENCE_OK'
        WHEN event_sequence - previous_sequence = 0 THEN 'DUPLICATE_SEQUENCE'
        WHEN event_sequence - previous_sequence > 1 THEN 'SEQUENCE_GAP'
        ELSE 'OUT_OF_ORDER'
    END AS issue_type,
    'Review event capture and sequence assignment' AS suggested_action
FROM event_comparison
ORDER BY user_id, event_sequence, event_id;

-- Payment status sequence validation.
WITH payment_sequence AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        LAG(status_sequence) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status_sequence
    FROM payment_status_history
)
SELECT
    transaction_id,
    status_sequence,
    previous_status_sequence,
    status_sequence - previous_status_sequence AS sequence_difference,
    payment_status
FROM payment_sequence
ORDER BY transaction_id, status_sequence;

-- First sequence value check.
WITH first_sequences AS (
    SELECT
        user_id,
        event_sequence,
        LAG(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_sequence
    FROM website_event_sequence
)
SELECT user_id, event_sequence
FROM first_sequences
WHERE previous_sequence IS NULL
  AND event_sequence <> 1
ORDER BY user_id;

-- Last sequence value review.
WITH event_neighbours AS (
    SELECT
        user_id,
        event_id,
        event_sequence,
        LEAD(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS next_sequence
    FROM website_event_sequence
)
SELECT user_id, event_id, event_sequence
FROM event_neighbours
WHERE next_sequence IS NULL
ORDER BY user_id;
