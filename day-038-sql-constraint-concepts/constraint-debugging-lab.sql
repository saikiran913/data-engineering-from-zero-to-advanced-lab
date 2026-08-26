-- Day 038: Constraint Debugging Lab
-- Purpose: Show risky validation patterns and safer read-only alternatives.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Debugging examples do not create, change, or remove constraints.
-- Grain: each pair shows a mistake and a safer review pattern.

-- Mistake 1: checking uniqueness without checking nulls.
SELECT
    COUNT(DISTINCT customer_id) AS distinct_customer_id_count
FROM customers;

-- Safer 1: check row count, non-null count, and distinct count.
SELECT
    COUNT(*) AS row_count,
    COUNT(customer_id) AS non_null_customer_id_count,
    COUNT(DISTINCT customer_id) AS distinct_customer_id_count
FROM customers;

-- Mistake 2: using an inner join for orphan review hides unmatched children.
SELECT
    o.order_id,
    o.customer_id
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;

-- Safer 2: use a left join and look for missing parent rows.
SELECT
    o.order_id,
    o.customer_id,
    'ORPHAN_ORDER_CUSTOMER' AS issue_type
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Mistake 3: treating every orphan as something to remove.
SELECT
    o.order_id,
    'REMOVE_ROW' AS unsafe_action
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Safer 3: report the orphan for investigation.
SELECT
    o.order_id,
    o.customer_id,
    'REVIEW_ORPHAN_RECORD' AS review_action
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Mistake 4: assuming a negative amount is always invalid.
SELECT
    order_id,
    order_amount,
    'INVALID' AS unsupported_conclusion
FROM orders
WHERE order_amount < 0;

-- Safer 4: flag the value against the documented sample rule.
SELECT
    order_id,
    order_amount,
    'ORDER_AMOUNT_RANGE_REVIEW' AS issue_type,
    'Review business context before deciding correction.' AS review_message
FROM orders
WHERE order_amount < 0;

-- Mistake 5: forgetting audit context.
SELECT
    product_code,
    COUNT(*) AS row_count
FROM products
WHERE product_code IS NOT NULL
GROUP BY product_code
HAVING COUNT(*) > 1;

-- Safer 5: include duplicate product rows with source context.
SELECT
    product_id,
    product_code,
    product_name,
    source_file,
    loaded_at
FROM products
WHERE product_code IN (
    SELECT
        product_code
    FROM products
    WHERE product_code IS NOT NULL
    GROUP BY product_code
    HAVING COUNT(*) > 1
);

