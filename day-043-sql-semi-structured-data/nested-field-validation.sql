-- Day 043: Nested Field Validation
-- Purpose: Validate required nested fields using relationalized extracted values.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per exception.

-- Section 1: required customer ID exceptions.
SELECT
    event_id,
    event_type,
    'customer.id' AS field_name,
    'Required non-blank customer ID' AS expected_condition,
    customer_id_text AS observed_value,
    CASE
        WHEN customer_id_text IS NULL THEN 'MISSING_OR_NULL'
        WHEN customer_id_text = '' THEN 'BLANK_VALUE'
        ELSE 'OK'
    END AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Review missing, null, and blank customer IDs separately.' AS review_message
FROM extracted_json_fields
WHERE event_type IN ('ORDER_CREATED', 'ORDER_UPDATED', 'CUSTOMER_UPDATED')
  AND (customer_id_text IS NULL OR customer_id_text = '');

-- Section 2: required order amount for ORDER_CREATED.
SELECT
    event_id,
    event_type,
    'order.amount' AS field_name,
    'Required numeric amount' AS expected_condition,
    amount_text AS observed_value,
    extraction_status AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Order-created events need a valid amount.' AS review_message
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
  AND (amount_text IS NULL OR amount_text = '' OR extraction_status = 'INVALID_TYPED_VALUE');

-- Section 3: required status for ORDER_UPDATED.
SELECT
    event_id,
    event_type,
    'order.status' AS field_name,
    'Required supported status' AS expected_condition,
    status_text AS observed_value,
    CASE
        WHEN status_text IS NULL THEN 'NULL_OR_MISSING'
        WHEN status_text NOT IN ('CREATED', 'SHIPPED', 'CANCELLED', 'COMPLETED') THEN 'UNSUPPORTED_STATUS'
        ELSE 'OK'
    END AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Order status must be present and supported.' AS review_message
FROM extracted_json_fields
WHERE event_type = 'ORDER_UPDATED'
  AND (status_text IS NULL OR status_text NOT IN ('CREATED', 'SHIPPED', 'CANCELLED', 'COMPLETED'));

-- Section 4: optional country review.
SELECT
    event_id,
    event_type,
    country_text,
    'Country may be optional for some event types, but coverage should be reviewed.' AS review_message
FROM extracted_json_fields
WHERE country_text IS NULL OR country_text = ''
ORDER BY event_id;

-- Section 5: event-type-specific required paths.
SELECT
    event_type,
    json_path,
    required_flag,
    expected_value_type,
    severity
FROM expected_json_paths
WHERE required_flag = 'YES'
ORDER BY event_type, json_path;

-- Section 6: nested-field exception output from case metadata.
SELECT
    event_id,
    event_type,
    path_or_array AS field_name,
    expected_condition,
    observed_condition AS observed_value,
    issue_category AS issue_type,
    severity,
    review_message
FROM json_validation_cases
WHERE severity IN ('REVIEW', 'HIGH_REVIEW')
ORDER BY severity DESC, event_id;

