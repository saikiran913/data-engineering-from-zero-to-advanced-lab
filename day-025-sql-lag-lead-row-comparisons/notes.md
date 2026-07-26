# Notes - LAG, LEAD, and Row-to-Row Comparisons

## What Is a Row-to-Row Comparison?

Row-to-row comparison means comparing the current row with another row in the same logical sequence. Examples include today's sales versus yesterday's sales, current payment status versus previous payment status, current price versus previous price, and current event number versus previous event number.

## What Does LAG Do?

`LAG` returns a value from a previous row. It uses the sequence defined inside `OVER` and does not remove rows.

```sql
LAG(total_sales) OVER (
    PARTITION BY product_id
    ORDER BY sale_date
) AS previous_sales
```

The first row usually has no previous row, so the result is normally `NULL`.

## What Does LEAD Do?

`LEAD` returns a value from a following row. The last row normally has no next row, so the result is normally `NULL`.

## Offset

The default offset is usually 1. Offset 2 means two rows back for `LAG` or two rows forward for `LEAD`. Day 025 mainly uses offset 1.

## Default Value

```sql
LAG(total_sales, 1, 0)
```

This can replace a missing previous value with zero. Be careful: replacing missing history with zero may be misleading. Preserving `NULL` is often safer for validation.

## PARTITION BY

`PARTITION BY` creates independent sequences, such as one sequence per customer, product, transaction, or website user.

## ORDER BY

Window `ORDER BY` defines what previous and next mean. Common ordering columns include event timestamp, update timestamp, sale date, and sequence number.

## Duplicate Ordering Values

Equal timestamps can make sequence order ambiguous. Use a meaningful secondary ordering column such as `event_sequence`, `loaded_at`, `version_number`, or `event_id`. Do not use arbitrary tie-breakers without documentation.

## Boundary Rows

The first row with `LAG` returns `NULL`. The last row with `LEAD` returns `NULL`. This is usually expected and can be labelled using `CASE`.

## Difference and Percentage Change

Current minus previous shows a difference:

```sql
current_value - previous_value
```

Safe percentage change should avoid nulls and division by zero:

```sql
CASE
    WHEN previous_value IS NULL THEN NULL
    WHEN previous_value = 0 THEN NULL
    ELSE (current_value - previous_value) * 100.0 / previous_value
END
```

## Status-Change Detection

```sql
CASE
    WHEN previous_status IS NULL THEN 'FIRST_STATUS'
    WHEN current_status <> previous_status THEN 'STATUS_CHANGED'
    ELSE 'NO_CHANGE'
END
```

## Date and Sequence Gaps

Date-gap detection compares current date with previous date. Date-difference syntax varies across platforms. Sequence-gap detection can use numeric subtraction:

```sql
event_sequence - previous_event_sequence
```

The expected difference is often 1.

## LAG Versus LEAD

| Function | Looks Where? | Boundary With No Neighbour |
| --- | --- | --- |
| `LAG` | Previous rows | First row |
| `LEAD` | Next rows | Last row |

## LAG/LEAD Versus Self-Join

Self-joins can compare rows, but `LAG` and `LEAD` are often clearer for ordered sequences. Both approaches may be valid.

## Common Mistakes

- No ordering rule.
- Wrong ordering column.
- Missing `PARTITION BY`.
- Duplicate timestamps without a tie-breaker.
- Assuming table display order controls `LAG`.
- Treating first-row null as an error.
- Replacing null with zero without thought.
- Division by zero.
- Comparing the wrong grain.
- Using text dates that are not properly typed.
- Detecting changes before deduplication.
- Treating a change flag as proof of business cause.
- Forgetting late-arriving data may change the sequence.

## Platform Note

Date syntax and small window-function details can vary by SQL platform.
