-- Day 036: Issue Category Design
-- Purpose: Review controlled exception categories and issue types.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: rule catalogue by issue category.
SELECT
    issue_category,
    COUNT(*) AS rule_count
FROM exception_rule_catalog
GROUP BY issue_category
ORDER BY issue_category;

-- Query 2: issue types inside each category.
SELECT
    issue_category,
    issue_type,
    severity,
    review_message
FROM exception_rule_catalog
ORDER BY issue_category, issue_type;

-- Query 3: casebook category examples.
SELECT
    case_id,
    business_question,
    exception_level,
    stage_name,
    issue_category,
    investigation_context
FROM exception_casebook
ORDER BY case_id;
