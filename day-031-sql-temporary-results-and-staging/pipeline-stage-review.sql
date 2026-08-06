-- Day 031: Pipeline Stage Review
-- Purpose: Use the casebook to review stage purpose, grain, method, validation, and risks.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.
-- This is educational guidance, not an automatic production design engine.

-- Stage-purpose review.
SELECT
    case_id,
    business_question,
    input_layer,
    output_layer,
    recommended_action
FROM pipeline_stage_casebook
ORDER BY case_id;

-- Input/output grain review.
SELECT
    case_id,
    input_grain,
    output_grain,
    CASE
        WHEN input_grain = output_grain THEN 'SAME_GRAIN'
        ELSE 'GRAIN_CHANGE_REVIEW'
    END AS grain_review
FROM pipeline_stage_casebook
ORDER BY case_id;

-- Intermediate-method review.
SELECT
    intermediate_method,
    COUNT(*) AS case_count
FROM pipeline_stage_casebook
GROUP BY intermediate_method
ORDER BY intermediate_method;

-- Validation coverage review.
SELECT
    case_id,
    main_validation,
    CASE
        WHEN main_validation IS NULL THEN 'REVIEW'
        ELSE 'PASS'
    END AS validation_status
FROM pipeline_stage_casebook;

-- Main-risk summary.
SELECT
    main_risk,
    COUNT(*) AS risk_count
FROM pipeline_stage_casebook
GROUP BY main_risk
ORDER BY main_risk;

-- Too-many-stages review.
SELECT
    case_id,
    business_question,
    recommended_action
FROM pipeline_stage_casebook
WHERE intermediate_method = 'too-many-stages';

-- Missing-stage review.
SELECT
    case_id,
    business_question,
    recommended_action
FROM pipeline_stage_casebook
WHERE main_risk LIKE '%stage filters%';

-- No-extra-stage-needed review.
SELECT
    case_id,
    business_question,
    recommended_action
FROM pipeline_stage_casebook
WHERE intermediate_method = 'no-extra-stage-needed';

-- Recommended-action summary.
SELECT
    recommended_action,
    COUNT(*) AS action_count
FROM pipeline_stage_casebook
GROUP BY recommended_action
ORDER BY recommended_action;
