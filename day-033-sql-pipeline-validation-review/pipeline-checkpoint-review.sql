-- Day 033: Pipeline Checkpoint Review
-- Purpose: Review validation case decisions and checkpoint design.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: inspect all validation cases.
SELECT
    case_id,
    business_question,
    source_stage,
    target_stage,
    source_grain,
    target_grain,
    validation_type,
    expected_difference,
    main_risk,
    recommended_check
FROM pipeline_validation_cases
ORDER BY
    case_id;

-- Query 2: cases by validation type.
SELECT
    validation_type,
    COUNT(*) AS case_count
FROM pipeline_validation_cases
GROUP BY
    validation_type
ORDER BY
    validation_type;

-- Query 3: cases where source and target grain differ.
SELECT
    case_id,
    business_question,
    source_grain,
    target_grain,
    validation_type,
    expected_difference
FROM pipeline_validation_cases
WHERE source_grain <> target_grain
ORDER BY
    case_id;

-- Query 4: rules by severity.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM validation_rule_catalog
GROUP BY
    severity
ORDER BY
    severity;

-- Query 5: rules that should produce exception output.
SELECT
    rule_id,
    stage_name,
    check_type,
    check_name,
    severity,
    validation_message
FROM validation_rule_catalog
WHERE exception_output = 'exception'
ORDER BY
    rule_id;
