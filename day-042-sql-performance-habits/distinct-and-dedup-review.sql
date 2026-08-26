-- Day 042: DISTINCT and Deduplication Review
-- Purpose: Use DISTINCT intentionally and avoid hiding join problems.
-- Safety: All executable SQL is read-only.
-- Warning: DISTINCT removes duplicate result rows. It does not explain why those duplicates appeared.

-- Section 1: legitimate DISTINCT for a unique list of country groups.
SELECT DISTINCT
    country_group
FROM orders_performance_sample
ORDER BY country_group;

-- Section 2: legitimate DISTINCT for a unique list of channels.
SELECT DISTINCT
    channel
FROM orders_performance_sample
ORDER BY channel;

-- Section 3: suspicious DISTINCT after joining order items.
SELECT DISTINCT
    o.order_id,
    o.order_amount
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
WHERE o.order_status = 'COMPLETED';

-- Section 4: duplicate cause analysis.
SELECT
    o.order_id,
    COUNT(*) AS item_line_count
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
WHERE o.order_status = 'COMPLETED'
GROUP BY o.order_id
HAVING COUNT(*) > 1
ORDER BY o.order_id;

-- Section 5: correct order-grain join using item pre-aggregation.
WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS item_total_amount
    FROM order_items_performance_sample
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.order_amount,
    i.item_total_amount
FROM orders_performance_sample AS o
LEFT JOIN item_totals AS i
    ON o.order_id = i.order_id
WHERE o.order_status = 'COMPLETED';

-- Section 6: business-key count versus result-row count.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT o.order_id) AS distinct_order_count
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
WHERE o.order_status = 'COMPLETED';

-- Section 7: ROW_NUMBER concept reuse for duplicate investigation.
-- This ranks item rows inside each order for review only.
SELECT
    order_id,
    line_number,
    product_code,
    ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY line_number
    ) AS item_sequence
FROM order_items_performance_sample
ORDER BY order_id, line_number;

-- Section 8: DISTINCT summary cases.
SELECT
    case_id,
    business_question,
    current_pattern,
    safer_habit,
    correctness_risk
FROM performance_casebook
WHERE current_pattern LIKE '%DISTINCT%'
   OR main_unnecessary_work LIKE '%distinct%'
   OR main_unnecessary_work LIKE '%DISTINCT%';

