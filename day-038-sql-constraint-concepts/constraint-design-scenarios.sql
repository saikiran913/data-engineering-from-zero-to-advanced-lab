-- Day 038: Constraint Design Scenarios
-- Purpose: Review documented rules and design questions before validation.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Design scenarios do not create or change constraints.
-- Grain: one row per rule or casebook scenario.

-- Query 1: inspect all constraint rules.
SELECT
    rule_id,
    table_name,
    constraint_concept,
    rule_name,
    column_or_columns,
    expected_condition,
    severity,
    issue_category,
    review_message
FROM constraint_rules
ORDER BY rule_id;

-- Query 2: primary-key-like design rules.
SELECT
    rule_id,
    table_name,
    column_or_columns,
    expected_condition,
    severity
FROM constraint_rules
WHERE constraint_concept = 'PRIMARY_KEY'
ORDER BY rule_id;

-- Query 3: relationship design rules.
SELECT
    rule_id,
    table_name,
    column_or_columns,
    expected_condition,
    review_message
FROM constraint_rules
WHERE constraint_concept = 'FOREIGN_KEY'
ORDER BY rule_id;

-- Query 4: check-like business rules.
SELECT
    rule_id,
    table_name,
    rule_name,
    column_or_columns,
    expected_condition,
    review_message
FROM constraint_rules
WHERE constraint_concept = 'CHECK'
ORDER BY rule_id;

-- Query 5: casebook scenarios requiring high-risk review.
SELECT
    case_id,
    business_question,
    table_name,
    constraint_concept,
    main_risk,
    recommended_validation
FROM constraint_casebook
WHERE main_risk LIKE '%Duplicate%'
   OR main_risk LIKE '%Orphan%'
   OR main_risk LIKE '%False confidence%'
ORDER BY case_id;

