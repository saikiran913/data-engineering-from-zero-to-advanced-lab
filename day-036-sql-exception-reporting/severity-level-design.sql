-- Day 036: Severity Level Design
-- Purpose: Review educational severity labels and rule-based usage.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: severity distribution in rule catalogue.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM exception_rule_catalog
GROUP BY severity
ORDER BY severity;

-- Query 2: severity examples from casebook.
SELECT
    severity,
    exception_level,
    issue_category,
    COUNT(*) AS case_count
FROM exception_casebook
GROUP BY severity, exception_level, issue_category
ORDER BY severity, exception_level, issue_category;

-- Query 3: high-review rules.
SELECT
    rule_id,
    stage_name,
    issue_category,
    issue_type,
    rule_description,
    review_message
FROM exception_rule_catalog
WHERE severity = 'HIGH_REVIEW'
ORDER BY rule_id;
