# Notes - Running Totals, Cumulative Metrics, and Moving Averages

## What Is a Windowed Aggregate?

A normal aggregate with `GROUP BY` reduces many rows into fewer summary rows. A windowed aggregate adds a calculated value to each row while keeping row detail visible.

| Topic | `GROUP BY` | Windowed Aggregate |
| --- | --- | --- |
| Row visibility | Collapses detail | Keeps detail |
| Output grain | One row per group | Usually original row grain |
| Common use | Summary table | Metrics beside each row |
| Ordering support | Not sequence-based | Can use ordered frames |

## Running Total

A running total starts with the first row, adds each new row's value, and keeps the total so far.

```sql
SUM(total_sales) OVER (
    PARTITION BY region
    ORDER BY sale_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_sales
```

`PARTITION BY region` restarts by region. `ORDER BY sale_date` defines sequence. The frame starts at the first row and stops at the current row.

## Cumulative Count and Average

A cumulative count counts rows so far. A cumulative average averages all rows from the start of the partition through the current row.

## Cumulative Minimum and Maximum

Cumulative minimums and maximums keep the lowest or highest value observed so far visible on every row.

## Moving Sum and Moving Average

A moving sum or average uses only a limited recent set of rows.

```sql
SUM(total_sales) OVER (
    PARTITION BY region
    ORDER BY sale_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS three_row_moving_sum
```

For a three-row moving average, the first row has one available row, the second has two, and the third and later rows may have three.

## Cumulative Versus Moving

| Feature | Cumulative | Moving |
| --- | --- | --- |
| Frame start | First row | Recent row limit |
| Frame size | Grows over time | Usually fixed after early rows |
| Purpose | Total or average so far | Recent-row smoothing |
| Boundary behaviour | First row equals first value | Early rows have smaller frames |

## Window Frames

`PARTITION BY` chooses the group. `ORDER BY` defines sequence. The frame chooses which rows around the current row are included.

`UNBOUNDED PRECEDING` means start at the first row. `CURRENT ROW` means stop at the current row. `2 PRECEDING` means include up to two rows before the current row.

## Why Use Explicit ROWS?

Explicit `ROWS` frames make the intended calculation clearer. Day 026 uses row-based windows. Three rows does not necessarily mean three calendar days because missing dates and duplicate dates can change interpretation.

## Nulls, Zeroes, Missing Dates, and Duplicates

Aggregates often ignore null inputs, but learners must decide whether null means missing, zero, or unknown. Zero is a real value and should not automatically be treated as missing. Duplicate rows can double-count. Missing dates can make moving windows look smoother than calendar coverage really is.

## Validation Workflow

1. Check source grain.
2. Check partition key.
3. Check ordering columns.
4. Check duplicates.
5. Check missing dates.
6. Calculate grouped totals.
7. Compare final cumulative total with grouped total.
8. Inspect first rows.
9. Inspect moving-window row counts.
10. Investigate nulls.

## Platform Note

Window-frame syntax and default-frame behaviour can vary by platform. Use explicit `ROWS` frames for beginner clarity.
