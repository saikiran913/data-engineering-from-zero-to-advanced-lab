-- Day 042: Performance Habit Summary
-- Purpose: Build compact review statuses from the casebook.
-- Safety: All executable SQL is read-only.
-- Business goal: classify safer performance habits without changing business meaning.

SELECT
    case_id,
    business_question,
    CASE
        WHEN main_unnecessary_work LIKE '%projection%' THEN 'PROJECTION'
        WHEN main_unnecessary_work LIKE '%filter%' THEN 'FILTERING'
        WHEN main_unnecessary_work LIKE '%join%' THEN 'JOIN_REDUCTION'
        WHEN main_unnecessary_work LIKE '%aggregation%' THEN 'AGGREGATION'
        WHEN main_unnecessary_work LIKE '%DISTINCT%' OR main_unnecessary_work LIKE '%distinct%' THEN 'DISTINCT'
        WHEN main_unnecessary_work LIKE '%sort%' THEN 'SORT'
        WHEN main_unnecessary_work LIKE '%Repeated%' THEN 'REPEATED_WORK'
        WHEN main_unnecessary_work LIKE '%No major%' THEN 'NO_CHANGE_NEEDED'
        ELSE 'NEEDS_CONTEXT'
    END AS habit_category,
    main_unnecessary_work AS unnecessary_work,
    correctness_risk,
    safer_habit AS recommended_habit,
    recommended_validation,
    CASE
        WHEN correctness_risk LIKE '%Hidden%'
          OR correctness_risk LIKE '%Wrong%'
          OR correctness_risk LIKE '%lost%'
          OR correctness_risk LIKE '%removed%' THEN 'DO_NOT_REWRITE_BLINDLY'
        WHEN main_unnecessary_work LIKE '%No major%' THEN 'NO_CHANGE_NEEDED'
        ELSE 'GOOD_CANDIDATE'
    END AS review_status
FROM performance_casebook
ORDER BY case_id;

-- Summary by review status.
SELECT
    CASE
        WHEN correctness_risk LIKE '%Hidden%'
          OR correctness_risk LIKE '%Wrong%'
          OR correctness_risk LIKE '%lost%'
          OR correctness_risk LIKE '%removed%' THEN 'DO_NOT_REWRITE_BLINDLY'
        WHEN main_unnecessary_work LIKE '%No major%' THEN 'NO_CHANGE_NEEDED'
        ELSE 'GOOD_CANDIDATE'
    END AS review_status,
    COUNT(*) AS case_count
FROM performance_casebook
GROUP BY
    CASE
        WHEN correctness_risk LIKE '%Hidden%'
          OR correctness_risk LIKE '%Wrong%'
          OR correctness_risk LIKE '%lost%'
          OR correctness_risk LIKE '%removed%' THEN 'DO_NOT_REWRITE_BLINDLY'
        WHEN main_unnecessary_work LIKE '%No major%' THEN 'NO_CHANGE_NEEDED'
        ELSE 'GOOD_CANDIDATE'
    END
ORDER BY review_status;

