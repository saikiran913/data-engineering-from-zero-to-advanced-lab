-- Day 039: Transaction Failure Scenarios
-- Purpose: Identify situations that should trigger rollback thinking conceptually.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No transaction or write statement is executable in this file.
-- Target population: transaction_casebook failure scenarios.
-- Expected affected rows: varies by scenario and should be documented.

-- Query 1: failure scenarios from the casebook.
SELECT
    case_id,
    business_question,
    scenario_type,
    pre_change_check,
    post_change_check,
    rollback_condition,
    main_risk
FROM transaction_casebook
WHERE scenario_type = 'failure_scenario'
ORDER BY case_id;

-- Query 2: cases where the source or target key is missing.
SELECT
    case_id,
    business_question,
    pre_change_check,
    rollback_condition,
    main_risk
FROM transaction_casebook
WHERE main_risk IN ('Invalid starting state', 'Invalid target state')
ORDER BY case_id;

-- Query 3: rules that should stop commit if validation fails.
SELECT
    rule_id,
    scenario_name,
    validation_stage,
    rule_name,
    expected_condition,
    severity,
    review_message
FROM transaction_rules
WHERE severity = 'HIGH_REVIEW'
ORDER BY rule_id;

-- Query 4: unrelated account changes should return no rows.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance,
    'UNRELATED_ROW_CHANGED' AS rollback_reason
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id NOT IN (101, 202)
  AND b.balance_amount <> a.balance_amount;

