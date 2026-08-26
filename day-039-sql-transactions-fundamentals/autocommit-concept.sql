-- Day 039: Autocommit Concept
-- Purpose: Review why platform transaction mode matters before writes.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Transaction syntax appears only in comments.
-- Target population: planning metadata in transaction_rules and transaction_casebook.
-- Expected affected rows: no data changes.

-- Query 1: transaction rules related to planning and platform behaviour.
SELECT
    rule_id,
    scenario_name,
    validation_stage,
    rule_name,
    expected_condition,
    severity,
    review_message
FROM transaction_rules
WHERE rule_name IN ('autocommit_review', 'backup_reminder', 'commit_condition')
ORDER BY rule_id;

-- Query 2: casebook examples where transaction behaviour is a risk.
SELECT
    case_id,
    business_question,
    scenario_type,
    atomicity_need,
    main_risk
FROM transaction_casebook
WHERE main_risk LIKE '%commit%'
   OR main_risk LIKE '%safety%'
   OR scenario_type = 'misconception'
ORDER BY case_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- Some tools commit each statement automatically.
-- Some platforms require explicit transaction start syntax.
-- Some statements may behave differently inside transactions.
-- Always verify platform behaviour before using transaction syntax.

