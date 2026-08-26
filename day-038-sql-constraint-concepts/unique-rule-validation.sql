-- Day 038: Unique-Rule Validation
-- Purpose: Validate uniqueness rules that are not necessarily primary keys.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define or change constraints.
-- Table grain: products one row per product.
-- Candidate unique rule: product_code should be unique when present.

-- Query 1: product code uniqueness summary.
SELECT
    COUNT(*) AS product_row_count,
    COUNT(product_code) AS non_null_product_code_count,
    COUNT(DISTINCT product_code) AS distinct_product_code_count
FROM products;

-- Query 2: duplicate product codes.
SELECT
    product_code,
    COUNT(*) AS row_count
FROM products
WHERE product_code IS NOT NULL
GROUP BY product_code
HAVING COUNT(*) > 1;

-- Query 3: product rows with duplicate codes and audit context.
SELECT
    p.product_id,
    p.product_code,
    p.product_name,
    p.category,
    p.source_file,
    p.loaded_at,
    'DUPLICATE_PRODUCT_CODE' AS issue_type
FROM products AS p
WHERE p.product_code IN (
    SELECT
        product_code
    FROM products
    WHERE product_code IS NOT NULL
    GROUP BY product_code
    HAVING COUNT(*) > 1
)
ORDER BY p.product_code, p.product_id;

