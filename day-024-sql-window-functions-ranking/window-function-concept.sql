-- Day 024: Window Function Concept
-- Topic: Ranking rows while keeping original row detail visible.
-- Safety note: every query in this file is read-only.

-- Section 1: Preview sample data.
SELECT employee_id, department, review_period, performance_score, projects_completed
FROM employee_performance
ORDER BY department, review_period, employee_id;

-- Section 2: GROUP BY collapses rows into one row per group.
-- Input grain: one row per employee review.
-- Output grain: one row per department.
SELECT
    department,
    AVG(performance_score) AS average_score
FROM employee_performance
WHERE performance_score IS NOT NULL
GROUP BY department
ORDER BY department;

-- Section 3: Window ranking keeps each employee row visible.
-- Partition columns: none, so this is a global rank.
-- Ordering measure: performance_score, highest first.
SELECT
    employee_id,
    department,
    review_period,
    performance_score,
    RANK() OVER (
        ORDER BY performance_score DESC
    ) AS global_score_rank
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY global_score_rank, employee_id;

-- Section 4: Ranking inside departments.
-- PARTITION BY department restarts ranking for each department.
SELECT
    employee_id,
    department,
    performance_score,
    RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS department_score_rank
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY department, department_score_rank, employee_id;

-- Section 5: Lowest value first.
-- ASC ranks the lowest score as rank 1.
SELECT
    employee_id,
    department,
    performance_score,
    RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score ASC
    ) AS lowest_score_rank
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY department, lowest_score_rank, employee_id;

-- Section 6: Window ORDER BY versus outer ORDER BY.
-- Window ORDER BY controls the rank calculation.
-- The final ORDER BY controls display order only.
SELECT
    employee_id,
    department,
    performance_score,
    RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS department_score_rank
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY employee_id;

-- Section 7: Filter rank 1 safely using a CTE.
WITH ranked_employees AS (
    SELECT
        employee_id,
        department,
        performance_score,
        RANK() OVER (
            PARTITION BY department
            ORDER BY performance_score DESC
        ) AS department_score_rank
    FROM employee_performance
    WHERE performance_score IS NOT NULL
)
SELECT *
FROM ranked_employees
WHERE department_score_rank = 1
ORDER BY department, employee_id;

-- Practice tasks:
-- 1. Change the partition to review_period.
-- 2. Rank projects_completed instead of performance_score.
-- 3. Compare rank 1 with ROW_NUMBER row 1 for each department.
