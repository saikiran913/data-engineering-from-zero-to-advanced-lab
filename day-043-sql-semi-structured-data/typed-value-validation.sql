-- Day 043: Typed Value Validation
-- Purpose: Validate extracted text values before treating them as numbers, dates, or booleans.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per event or validation case.

-- Section 1: numeric amount validation using known invalid cases.
SELECT
    event_id,
    event_type,
    amount_text,
    extraction_status,
    CASE
        WHEN amount_text IS NULL OR amount_text = '' THEN 'MISSING_AMOUNT'
        WHEN extraction_status = 'INVALID_TYPED_VALUE' THEN 'INVALID_NUMBER_REVIEW'
        ELSE 'READY_FOR_TYPED_REVIEW'
    END AS amount_validation_status
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
ORDER BY event_id;

-- Section 2: quantity validation in array elements.
SELECT
    event_id,
    array_index,
    product_code,
    quantity_text,
    CASE
        WHEN quantity_text IS NULL OR quantity_text = '' THEN 'MISSING_QUANTITY'
        WHEN quantity_text = 'two' THEN 'INVALID_NUMBER_REVIEW'
        ELSE 'READY_FOR_TYPED_REVIEW'
    END AS quantity_validation_status
FROM array_element_records
WHERE array_name = 'items'
ORDER BY event_id, array_index;

-- Section 3: date-text validation concept.
SELECT
    event_id,
    event_type,
    event_date_text,
    CASE
        WHEN event_date_text IN ('2026-99-99', 'bad-date') THEN 'INVALID_DATE_REVIEW'
        WHEN event_date_text IS NULL OR event_date_text = '' THEN 'MISSING_DATE'
        ELSE 'READY_FOR_DATE_REVIEW'
    END AS date_validation_status
FROM extracted_json_fields
ORDER BY event_id;

-- Section 4: boolean-like values.
SELECT
    event_id,
    event_type,
    payload_text,
    'Boolean values may arrive as true, false, or text such as true.' AS review_message
FROM event_records
WHERE payload_text LIKE '%active%'
ORDER BY event_id;

-- Section 5: status validation.
SELECT
    event_id,
    event_type,
    status_text,
    CASE
        WHEN status_text IS NULL OR status_text = '' THEN 'MISSING_STATUS'
        WHEN status_text NOT IN ('CREATED', 'SHIPPED', 'CANCELLED', 'COMPLETED') THEN 'UNSUPPORTED_STATUS'
        ELSE 'SUPPORTED_STATUS'
    END AS status_validation_status
FROM extracted_json_fields
WHERE event_type IN ('ORDER_CREATED', 'ORDER_UPDATED')
ORDER BY event_id;

-- Section 6: safe-cast concept.
-- PLATFORM-SPECIFIC CONCEPT
-- TRY_CAST(amount_text AS DECIMAL(12, 2))
--
-- PLATFORM-SPECIFIC CONCEPT
-- SAFE_CAST(amount_text AS NUMERIC)

-- Section 7: typed value issue summary.
SELECT
    issue_category,
    COUNT(*) AS issue_count
FROM json_validation_cases
WHERE issue_category IN ('INVALID_NUMBER', 'INVALID_DATE', 'UNSUPPORTED_VALUE')
GROUP BY issue_category
ORDER BY issue_category;

