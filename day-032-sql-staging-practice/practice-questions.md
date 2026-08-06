# Day 032 Practice Questions

## Section A: Concept Checks

1. What does grain mean?
2. Why should source values be standardised before complex business logic?
3. Why should `raw_status` be preserved after creating `standard_status`?
4. What is a mapping table?
5. What is a staged candidate?
6. What business key is used for order candidate selection in this lab?
7. What does `ROW_NUMBER` do in the deduplication stage?
8. Why does `ROW_NUMBER` not decide business truth by itself?
9. What is a validation flag?
10. What is a validation reason?
11. Give two reasons a row may be sent to review.
12. Why should review rows not be deleted silently?
13. What is the clean grain in this lab?
14. What is the reporting grain in this lab?
15. Name two audit columns used in this lab.
16. What should accepted count plus review count reconcile to?
17. Why are raw row count and clean row count not always equal?
18. What is a late-arriving record?
19. How can you debug a multi-stage SQL query?
20. What should a handoff contract document?

## Section B: Put the Stages in Order

Place each workflow in the safest order.

1. A: validate candidates, B: inspect raw source, C: standardise status, D: select candidate.
2. A: aggregate reporting, B: create clean output, C: validate reporting grain, D: select accepted rows.
3. A: document handoff, B: reconcile counts, C: split accepted and review, D: add validation flags.
4. A: rank events, B: inspect duplicate order IDs, C: choose candidate, D: standardise raw status.
5. A: check clean key uniqueness, B: prepare clean rows, C: review accepted rows.
6. A: map status, B: inspect missing mappings, C: preserve raw status.
7. A: compare totals, B: build reporting summary, C: confirm reporting grain.
8. A: inspect sample rows, B: count rows, C: add next stage, D: validate previous stage.

## Section C: Complete the SQL

1. Write a query to join raw orders to the status mapping table.
2. Add a `country_group` using `CASE`.
3. Rank raw events by `order_id`.
4. Select only `row_num = 1` candidates.
5. Flag null `order_id` rows as `REVIEW`.
6. Flag null `customer_id` rows as `REVIEW`.
7. Flag negative `order_amount` rows as `REVIEW`.
8. Flag unsupported status rows as `REVIEW`.
9. Select accepted rows from `staged_customer_orders`.
10. Select review rows from `staged_customer_orders`.
11. Count staged, accepted, and review rows.
12. Check duplicate clean `order_id` values.
13. Aggregate completed amount by date and country group.
14. Find null reporting measures.
15. Select the handoff casebook ordered by `case_id`.

## Section D: Fix the Mistake

1. A query maps statuses but drops `raw_status`.
2. A query ranks orders without documenting the ordering rule.
3. A query accepts rows with null `customer_id`.
4. A query sends review rows nowhere.
5. A query aggregates reporting before clean key validation.
6. A query uses latest `received_at` without checking event timestamp.
7. A query ignores same-timestamp ties.
8. A query has one CTE doing standardisation, deduplication, validation, and reporting.
9. A workflow has ten stages, but several do not change or validate data.
10. A clean layer contains duplicate `order_id` values.
11. A reporting table has duplicate date and country group rows.
12. A reporting output has null measure columns.
13. A handoff has no audit columns.
14. Downstream reporting remaps statuses differently from staging.
15. A reviewer compares raw row count to clean row count and expects equality without considering grain.

## Section E: Design the Workflow

For each scenario, define source grain, standardisation, key, deduplication rule, validation rules, accepted/review split, clean grain, reporting grain, checkpoints, and handoff.

1. Daily order event file.
2. Customer status file with inconsistent status spellings.
3. Product price feed with repeated product IDs.
4. Refund event file with negative amounts.
5. Website signup file with missing user IDs.
6. Campaign file with unknown channel values.
7. Monthly sales file with late-arriving previous-month rows.
8. Regional order files combined for global reporting.
9. Clean orders handed to a dashboard.
10. Reporting summary with duplicate report keys.

## Section F: Mini Case Study

Using the supplied files, design a staged workflow that:

1. standardises raw statuses
2. selects the latest order candidate
3. flags invalid rows
4. creates accepted and review outputs
5. builds clean orders
6. builds reporting summary
7. reconciles counts
8. reconciles totals
9. documents audit columns
10. writes the handoff contract

## Answer Key

### Section A Answers

1. Grain means what one row represents.
2. Standardisation gives later logic consistent values.
3. Raw values help debugging and source traceability.
4. A mapping table converts source values into standard values.
5. A staged candidate is a prepared row selected for validation.
6. `order_id`.
7. It ranks rows inside each `order_id`.
8. It follows the documented rule; people must define the rule.
9. A decision value such as `ACCEPTED` or `REVIEW`.
10. A clear explanation for the decision.
11. Null customer ID and negative amount are two examples.
12. They are evidence for investigation.
13. One row per clean order.
14. One row per report date and country group.
15. `source_file` and `received_at`.
16. The staged population.
17. Raw may contain many events per order, while clean has one row per order.
18. A record received after its business event date or period.
19. Run each stage separately and inspect counts, keys, nulls, duplicates, totals, and samples.
20. Grain, key, rules, audit columns, checks, limitations, and downstream use.

### Section B Answers

1. B, C, D, A.
2. D, B, A, C.
3. D, C, B, A.
4. D, B, A, C.
5. C, B, A.
6. C, A, B.
7. B, C, A.
8. B, A, D, C.

### Section C Sample Answers

```sql
-- 1. Status mapping.
SELECT
    r.source_event_id,
    r.raw_status,
    m.standard_status
FROM raw_customer_orders AS r
LEFT JOIN source_status_mapping AS m
    ON r.raw_status = m.source_status;
```

```sql
-- 2. Country grouping.
SELECT
    source_event_id,
    country_code,
    CASE
        WHEN country_code = 'IN' THEN 'India'
        WHEN country_code = 'UK' THEN 'Europe'
        WHEN country_code = 'US' THEN 'North America'
        ELSE 'Other'
    END AS country_group
FROM raw_customer_orders;
```

```sql
-- 3 and 4. Rank and select candidates.
WITH ranked_events AS (
    SELECT
        source_event_id,
        order_id,
        event_timestamp,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC,
                     received_at DESC,
                     source_event_id
        ) AS row_num
    FROM raw_customer_orders
)
SELECT
    source_event_id,
    order_id,
    event_timestamp,
    received_at
FROM ranked_events
WHERE row_num = 1;
```

```sql
-- 5 to 8. Validation flags.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    CASE
        WHEN order_id IS NULL THEN 'REVIEW'
        WHEN customer_id IS NULL THEN 'REVIEW'
        WHEN order_amount < 0 THEN 'REVIEW'
        WHEN standard_status IN ('UNKNOWN', 'FAILED') THEN 'REVIEW'
        ELSE 'ACCEPTED'
    END AS validation_status
FROM staged_customer_orders;
```

```sql
-- 9 and 10. Accepted and review rows.
SELECT order_id, customer_id, standard_status
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED';

SELECT order_id, validation_reason, source_file
FROM staged_customer_orders
WHERE validation_status = 'REVIEW';
```

```sql
-- 11. Count reconciliation.
SELECT
    COUNT(*) AS staged_count,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
FROM staged_customer_orders;
```

```sql
-- 12. Clean key check.
SELECT
    order_id,
    COUNT(*) AS row_count
FROM clean_customer_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

```sql
-- 13. Reporting aggregation.
SELECT
    order_date,
    country_group,
    SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END) AS completed_amount
FROM clean_customer_orders
GROUP BY order_date, country_group;
```

```sql
-- 14 and 15. Reporting nulls and handoff casebook.
SELECT report_date, country_group
FROM reporting_customer_order_summary
WHERE total_completed_amount IS NULL;

SELECT case_id, stage_name, validation_check
FROM staging_handoff_cases
ORDER BY case_id;
```

### Section D Answers

1. Keep both raw and standard status.
2. Document business key, ordering columns, and tie-breaker.
3. Send null-customer rows to review.
4. Preserve review rows in a review queue.
5. Validate clean key before reporting aggregation.
6. Compare event timestamp and received timestamp.
7. Detect ties and define a review or tie-breaker rule.
8. Split logic into focused CTEs.
9. Remove stages with no purpose or validation.
10. Add a duplicate clean-key check.
11. Add a duplicate reporting-grain check.
12. Add null measure checks.
13. Preserve audit columns.
14. Use the standard status from the clean layer.
15. Compare counts using the correct grain.

### Section E Answer Guidance

A strong answer documents grain, key, standardisation, deduplication, validation rules, accepted and review outputs, audit columns, checkpoints, and handoff limitations. Different rules can be valid if they are documented and validated.

### Section F Answer Guidance

Use `source-standardisation.sql`, `deduplication-stage.sql`, `validation-flag-stage.sql`, `accepted-review-handoff.sql`, `clean-layer-handoff.sql`, `reporting-layer-handoff.sql`, and `handoff-contract-guide.md` as the model answer path. The key is not only writing SQL, but explaining why each stage exists and how it is validated.
