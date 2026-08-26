-- Day 039: Safe Change Planning
-- Purpose: Build read-only evidence before any conceptual multi-step change.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Planning queries do not execute transactions or write data.
-- Target population: accounts 101 and 202; orders O2001 and O2002.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: transaction rules that belong to planning.
SELECT
    rule_id,
    scenario_name,
    validation_stage,
    rule_name,
    expected_condition,
    severity,
    review_message
FROM transaction_rules
WHERE validation_stage = 'planning'
ORDER BY rule_id;

-- Query 2: balance transfer planning case.
SELECT
    case_id,
    business_question,
    related_steps,
    atomicity_need,
    pre_change_check,
    post_change_check,
    rollback_condition,
    main_risk
FROM transaction_casebook
WHERE case_id = 'TC001';

-- Query 3: account target key existence check.
SELECT
    account_id,
    account_name,
    balance_amount,
    account_status
FROM account_balances_before
WHERE account_id IN (101, 202)
ORDER BY account_id;

-- Query 4: order target key existence check.
SELECT
    order_id,
    customer_id,
    order_status,
    review_flag
FROM order_status_before
WHERE order_id IN ('O2001', 'O2002')
ORDER BY order_id;

