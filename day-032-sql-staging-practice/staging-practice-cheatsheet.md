# Day 032 SQL Staging Practice Cheatsheet

## Mental Model

Prepare, standardise, deduplicate, validate, separate, clean, aggregate, reconcile, and hand off.

## Source Standardisation Pattern

```sql
SELECT
    r.source_event_id,
    r.raw_status,
    m.standard_status,
    r.source_file,
    r.received_at
FROM raw_customer_orders AS r
LEFT JOIN source_status_mapping AS m
    ON r.raw_status = m.source_status;
```

Meaning: keep the raw value and add the standard value.

## Country Group Pattern

```sql
CASE
    WHEN country_code = 'IN' THEN 'India'
    WHEN country_code = 'UK' THEN 'Europe'
    WHEN country_code = 'US' THEN 'North America'
    ELSE 'Other'
END AS country_group
```

Meaning: create a simple reporting-friendly group.

## Deduplication Candidate Pattern

```sql
ROW_NUMBER() OVER (
    PARTITION BY order_id
    ORDER BY event_timestamp DESC,
             received_at DESC,
             source_event_id
) AS row_num
```

Meaning: rank events for each order using a documented rule.

## Validation Status Pattern

```sql
CASE
    WHEN order_id IS NULL THEN 'REVIEW'
    WHEN customer_id IS NULL THEN 'REVIEW'
    WHEN order_amount IS NULL THEN 'REVIEW'
    WHEN order_amount < 0 THEN 'REVIEW'
    ELSE 'ACCEPTED'
END AS validation_status
```

Meaning: make the decision visible.

## Validation Reason Pattern

```sql
CASE
    WHEN order_id IS NULL THEN 'NULL_ORDER_ID'
    WHEN customer_id IS NULL THEN 'NULL_CUSTOMER_ID'
    WHEN order_amount IS NULL THEN 'NULL_ORDER_AMOUNT'
    WHEN order_amount < 0 THEN 'NEGATIVE_ORDER_AMOUNT'
    ELSE 'READY_FOR_CLEAN'
END AS validation_reason
```

Meaning: explain why the row is accepted or sent to review.

## Accepted Output Pattern

```sql
SELECT
    order_id,
    customer_id,
    standard_status,
    order_amount,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED';
```

Meaning: pass only documented accepted rows forward.

## Review Output Pattern

```sql
SELECT
    order_id,
    validation_reason,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'REVIEW';
```

Meaning: preserve suspicious rows for investigation.

## Reconciliation Pattern

```sql
SELECT
    COUNT(*) AS staged_count,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
FROM staged_customer_orders;
```

Meaning: accepted plus review should explain the staged population.

## Reporting Aggregation Pattern

```sql
SELECT
    order_date AS report_date,
    country_group,
    SUM(CASE WHEN order_status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_order_count,
    SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END) AS total_completed_amount
FROM clean_customer_orders
GROUP BY
    order_date,
    country_group;
```

Meaning: aggregate after clean grain is established.

## Beginner Best Practices

- standardise before complex business logic
- preserve original source values
- preserve audit columns
- define grain at every stage
- deduplicate with a documented rule
- keep review rows
- reconcile accepted plus review to staged population
- validate clean key uniqueness
- validate reporting grain uniqueness
- reconcile counts and totals
- document every handoff
- keep each stage focused
- keep all learning SQL read-only
