-- Day 036: Exception Debugging Lab
-- Purpose: Practise finding weak or misleading exception outputs.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Debug 1: vague categories from the rule catalogue should be avoided.
SELECT
    rule_id,
    issue_category,
    issue_type,
    review_message
FROM exception_rule_catalog
ORDER BY rule_id;

-- Debug 2: exception rows without entity keys are hard to investigate.
WITH queue AS (
    SELECT
        order_id AS entity_key,
        'NULL_CUSTOMER_ID' AS issue_type
    FROM source_order_data
    WHERE customer_id IS NULL
)
SELECT
    entity_key,
    issue_type
FROM queue
WHERE entity_key IS NULL;

-- Debug 3: find duplicate reporting grain before building reporting exceptions.
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_order_data
GROUP BY report_date, country_group
HAVING COUNT(*) > 1
ORDER BY report_date, country_group;

-- Debug 4: review casebook examples by exception level.
SELECT
    exception_level,
    severity,
    COUNT(*) AS case_count
FROM exception_casebook
GROUP BY exception_level, severity
ORDER BY exception_level, severity;
