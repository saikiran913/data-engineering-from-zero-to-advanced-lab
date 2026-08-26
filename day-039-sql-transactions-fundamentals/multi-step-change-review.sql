-- Day 039: Multi-Step Change Review
-- Purpose: Review related changes as one transaction candidate.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Write and transaction syntax appears only in commented conceptual examples.
-- Target population: balance transfer accounts and order status rows.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: related balance changes.
SELECT
    b.account_id,
    b.account_name,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance,
    a.balance_amount - b.balance_amount AS expected_change
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.balance_amount <> a.balance_amount
ORDER BY b.account_id;

-- Query 2: related order status and review-flag changes.
SELECT
    b.order_id,
    b.order_status AS before_status,
    a.order_status AS expected_after_status,
    b.review_flag AS before_review_flag,
    a.review_flag AS expected_after_review_flag
FROM order_status_before AS b
JOIN order_status_expected_after AS a
    ON b.order_id = a.order_id
WHERE b.order_status <> a.order_status
   OR b.review_flag <> a.review_flag
ORDER BY b.order_id;

-- Query 3: casebook scenarios with related steps.
SELECT
    case_id,
    business_question,
    scenario_type,
    related_steps,
    atomicity_need,
    main_risk
FROM transaction_casebook
WHERE scenario_type IN ('related_multi_step', 'parent_child', 'reference_data')
ORDER BY case_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- BEGIN TRANSACTION;
-- UPDATE first_related_row_or_table ...
-- UPDATE second_related_row_or_table ...
-- Run post-change SELECT validation.
-- COMMIT only if the evidence matches the plan.
-- ROLLBACK if validation fails.

