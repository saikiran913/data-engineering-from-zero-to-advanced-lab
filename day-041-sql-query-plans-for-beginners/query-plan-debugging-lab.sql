-- Day 041: Query Plan Debugging Lab
-- Topic: Practising safe plan-reading questions
-- Safety: All executable SQL is read-only and SELECT-based.

-- Lab 1: What is the query trying to answer?
SELECT
    case_id,
    business_question,
    query_pattern
FROM query_plan_casebook
ORDER BY case_id;

-- Lab 2: Which main operator should receive attention first?
SELECT
    case_id,
    business_question,
    main_operator,
    main_risk
FROM query_plan_casebook
ORDER BY main_operator, case_id;

-- Lab 3: Which cases have high estimated rows?
SELECT
    case_id,
    business_question,
    query_pattern,
    estimated_rows_band,
    recommended_review
FROM query_plan_casebook
WHERE estimated_rows_band = 'HIGH'
ORDER BY case_id;

-- Lab 4: Which cases have high cost?
SELECT
    case_id,
    business_question,
    query_pattern,
    cost_band,
    recommended_review
FROM query_plan_casebook
WHERE cost_band = 'HIGH'
ORDER BY case_id;

-- Lab 5: Which plan steps may be doing broad scans?
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'TABLE_SCAN'
ORDER BY estimated_rows DESC;

-- Lab 6: Which plan steps may reduce rows through filters?
SELECT
    plan_id,
    query_name,
    step_number,
    filter_description,
    estimated_rows,
    notes
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
ORDER BY plan_id, step_number;

-- Lab 7: Which plan steps join data?
SELECT
    plan_id,
    query_name,
    step_number,
    join_description,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'JOIN'
ORDER BY estimated_cost DESC;

-- Lab 8: Which steps sort data after many rows?
SELECT
    plan_id,
    query_name,
    step_number,
    sort_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE operator_name = 'SORT'
ORDER BY estimated_rows DESC;

-- Lab 9: Which steps aggregate data?
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'AGGREGATE'
ORDER BY estimated_cost DESC;

-- Lab 10: Which comparison cases need careful interpretation?
SELECT
    case_id,
    query_goal,
    main_difference,
    estimated_rows_difference,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE beginner_interpretation LIKE '%not automatically%'
   OR beginner_interpretation LIKE '%caution%'
   OR beginner_interpretation LIKE '%evidence%'
ORDER BY case_id;

-- Lab 11: Verify the real sample data row counts.
SELECT
    'orders_plan_sample' AS source_table,
    COUNT(*) AS row_count
FROM orders_plan_sample
UNION ALL
SELECT
    'customers_plan_sample' AS source_table,
    COUNT(*) AS row_count
FROM customers_plan_sample;

-- Lab 12: Inspect the most selective-looking order filters in sample data.
SELECT
    order_id,
    customer_id,
    order_status,
    country_group,
    order_amount
FROM orders_plan_sample
WHERE order_id IN ('OP5001', 'OP5018', 'OP5036')
ORDER BY order_id;

-- Lab 13: Inspect a broader status filter in sample data.
SELECT
    order_id,
    customer_id,
    order_status,
    country_group,
    order_amount
FROM orders_plan_sample
WHERE order_status = 'Delivered'
ORDER BY order_date, order_id;

-- Lab 14: Inspect a join query that may produce repeated customer rows.
SELECT
    o.order_id,
    o.customer_id,
    c.customer_status,
    c.customer_segment,
    o.order_amount
FROM orders_plan_sample o
INNER JOIN customers_plan_sample c
    ON o.customer_id = c.customer_id
ORDER BY o.customer_id, o.order_id;

