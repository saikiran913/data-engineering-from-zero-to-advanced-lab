-- Day 030: Decision Casebook
-- Purpose: Use documented cases to practise interface recommendations.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.
-- Human review remains necessary; this is not a production decision engine.

-- Case classification.
SELECT
    case_id,
    business_question,
    recommended_interface,
    main_risk,
    validation_check
FROM interface_decision_cases
ORDER BY case_id;

-- Recommended-interface summary.
SELECT
    recommended_interface,
    COUNT(*) AS case_count
FROM interface_decision_cases
GROUP BY recommended_interface
ORDER BY recommended_interface;

-- Persistence mismatch review.
SELECT
    case_id,
    business_question,
    persistence_need,
    recommended_interface,
    'PERSISTENCE_REVIEW' AS review_type
FROM interface_decision_cases
WHERE persistence_need = 'Yes'
  AND recommended_interface NOT LIKE '%table%';

-- Reuse mismatch review.
SELECT
    case_id,
    business_question,
    reuse_need,
    recommended_interface,
    'REUSE_REVIEW' AS review_type
FROM interface_decision_cases
WHERE reuse_need = 'Yes'
  AND recommended_interface IN ('CTE', 'subquery', 'simple query');

-- History mismatch review.
SELECT
    case_id,
    business_question,
    history_need,
    recommended_interface,
    'HISTORY_REVIEW' AS review_type
FROM interface_decision_cases
WHERE history_need = 'Yes'
  AND recommended_interface NOT LIKE '%table%';

-- Freshness mismatch review.
SELECT
    case_id,
    business_question,
    freshness_need,
    recommended_interface,
    'FRESHNESS_REVIEW' AS review_type
FROM interface_decision_cases
WHERE freshness_need LIKE '%current%'
  AND recommended_interface LIKE '%table%';

-- Risk summary.
SELECT
    recommended_interface,
    main_risk,
    COUNT(*) AS risk_case_count
FROM interface_decision_cases
GROUP BY recommended_interface, main_risk
ORDER BY recommended_interface;

-- Validation requirement summary.
SELECT
    validation_check,
    COUNT(*) AS case_count
FROM interface_decision_cases
GROUP BY validation_check
ORDER BY validation_check;

-- CASE-based educational recommendation output.
SELECT
    case_id,
    business_question,
    CASE
        WHEN persistence_need = 'Yes' AND history_need = 'Yes' THEN 'Consider a stored table-style interface.'
        WHEN reuse_need = 'Yes' AND persistence_need = 'No' THEN 'Consider a view-style reusable query interface.'
        WHEN reuse_need = 'No' AND persistence_need = 'No' THEN 'Consider a CTE, subquery, or simple query.'
        ELSE 'Review requirements manually.'
    END AS educational_recommendation,
    recommended_interface AS documented_recommendation,
    validation_check
FROM interface_decision_cases
ORDER BY case_id;
