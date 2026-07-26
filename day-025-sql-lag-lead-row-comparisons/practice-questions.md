# Practice Questions

## Section A: Concept Checks

1. What does `LAG` return?
2. What does `LEAD` return?
3. What is an offset?
4. What is a default value?
5. Why is the first `LAG` value often null?
6. Why is the last `LEAD` value often null?
7. What does `PARTITION BY` do?
8. What does window `ORDER BY` define?
9. Why can duplicate timestamps be risky?
10. How do you calculate a simple difference?
11. Why must percentage change avoid zero previous values?
12. What is a status-change flag?
13. What is a sequence gap?
14. What is a date gap?
15. Why should changes be validated?

## Section B: Predict the Output

For values `100, 120, 90`, previous values are `NULL, 100, 120` and next values are `120, 90, NULL`.

Predict previous value, next value, difference, and boundary rows for:

1. `10, 20, 30`
2. `50, 50, 60`
3. `PENDING, FAILED, SUCCESS`
4. Product prices `100, 110, 110, 95`
5. Event sequences `1, 2, 4`
6. Event sequences `1, 2, 2, 3`
7. Region sales `12000, 12500, 7600`
8. One-row transaction `SUCCESS`
9. Partition A `1, 2`; Partition B `1, 3`
10. Previous value is zero and current value is 50

## Section C: Complete the SQL

1. Previous payment status.
2. Next payment status.
3. Previous product price.
4. Next product price.
5. Daily sales change.
6. Safe percentage change.
7. Date-gap flag.
8. Sequence-gap flag.
9. First-row flag.
10. Last-row flag.

## Section D: Choose the Function

Choose `LAG`, `LEAD`, `ROW_NUMBER`, `RANK`, or `GROUP BY`:

1. Compare current price with previous price.
2. Compare current status with next status.
3. Select exactly one latest record.
4. Preserve all tied top products.
5. Count sales rows by region.
6. Find previous event sequence.
7. Find next workflow step.
8. Rank customers by sales.
9. Aggregate daily totals.
10. Identify first row using a sequence.

## Section E: Fix the Mistake

1. Missing window `ORDER BY`.
2. Wrong partition key.
3. Duplicate timestamp without tie-breaker.
4. Treating first-row null as an error.
5. Defaulting null to zero without review.
6. Division by zero in percentage change.
7. Comparing wrong grain.
8. Filtering window alias in same query level.
9. Using `LAG` when next row is required.
10. Ignoring null comparison values.

## Section F: Design the Workflow

For each scenario, define grain, partition, ordering, function, boundary policy, review condition, and validation checks:

1. Payment status change.
2. Product price increase.
3. Product price decrease.
4. Daily sales change.
5. Missing daily file.
6. Website event gap.
7. Duplicate event sequence.
8. Late-arriving update.

## Answer Key

Section A: `LAG` looks backward, `LEAD` looks forward, partitions create independent sequences, and ordering defines the neighbour. Boundary nulls are usually expected.

Section B: For `1, 2, 4`, previous values are `NULL, 1, 2`; sequence differences are `NULL, 1, 2`, so the third row has a gap. For one-row transactions, both previous and next values are null.

Section C sample:

```sql
WITH payment_comparison AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence
        ) AS previous_status
    FROM payment_status_history
)
SELECT *
FROM payment_comparison;
```

Safe percentage change:

```sql
CASE
    WHEN previous_value IS NULL THEN NULL
    WHEN previous_value = 0 THEN NULL
    ELSE (current_value - previous_value) * 100.0 / previous_value
END
```

Section D: use `LAG` for previous values, `LEAD` for next values, `ROW_NUMBER` for exactly one selected row, `RANK` for tied ranking, and `GROUP BY` for summaries.

Section E: fix issues by adding ordering, correcting partition keys, documenting tie-breakers, preserving boundary nulls when useful, avoiding division by zero, confirming grain, and filtering window aliases in a CTE.
