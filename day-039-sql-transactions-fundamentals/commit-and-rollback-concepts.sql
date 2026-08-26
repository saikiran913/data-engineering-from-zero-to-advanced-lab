-- Day 039: COMMIT and ROLLBACK Concepts
-- Purpose: Explain commit and rollback using commented examples and read-only checks.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Transaction statements appear only in commented conceptual blocks.
-- Target population: accounts 101 and 202.
-- Expected affected rows: 2 accounts.

-- Query 1: rules that mention commit or rollback conditions.
SELECT
    rule_id,
    scenario_name,
    validation_stage,
    rule_name,
    expected_condition,
    severity,
    review_message
FROM transaction_rules
WHERE rule_name IN ('rollback_condition', 'commit_condition')
ORDER BY rule_id;

-- Query 2: rollback-related casebook examples.
SELECT
    case_id,
    business_question,
    scenario_type,
    rollback_condition,
    main_risk
FROM transaction_casebook
WHERE scenario_type IN ('rollback_thinking', 'misconception', 'failure_scenario')
ORDER BY case_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- BEGIN TRANSACTION;
-- Write one related change.
-- Write another related change.
-- Run validation SELECT statements.
-- If validation passes, COMMIT.
-- If validation fails, ROLLBACK.

-- CONCEPTUAL ONLY - DO NOT RUN
-- ROLLBACK does not replace backups or recovery planning.
-- A committed bad change may require a separate recovery process.

