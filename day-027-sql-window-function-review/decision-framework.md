# Decision Framework for Window Functions

Use this page before writing a window-function query.

## Question 1: Do you need one summary row per group?

Use `GROUP BY`. A window function may not be needed.

## Question 2: Do you need a position?

Choose a ranking function:

- `ROW_NUMBER` for exactly one sequence number per row.
- `RANK` when ties should share a rank and gaps are acceptable.
- `DENSE_RANK` when ties should share a rank without gaps.

## Question 3: Do you need a previous or next row?

Choose `LAG` for previous rows and `LEAD` for next rows.

## Question 4: Do you need a total or average so far?

Choose a cumulative window, such as `SUM OVER` or `AVG OVER`, with:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

## Question 5: Do you need only recent rows?

Choose a moving frame, such as:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

## Question 6: Must ties remain?

Choose `RANK` or `DENSE_RANK`.

## Question 7: Must exactly one row be selected?

Use `ROW_NUMBER` with a documented ordering rule and tie-breaker.

## Question 8: Is the source already at the correct grain?

Aggregate or prepare the data first if the source is more detailed than the question.

## Decision Table

| Business requirement | Function or approach | Required policy | Main validation |
|---|---|---|---|
| One total per pipeline | `GROUP BY` | No window needed | One output row per pipeline |
| One top customer per country | `ROW_NUMBER` | Tie-breaker required | Selected count equals country count |
| All tied top products | `RANK` | Preserve ties | Review count of rank 1 rows |
| Dense performance levels | `DENSE_RANK` | No rank gaps | Inspect rank sequence |
| Previous conversions | `LAG` | First row boundary is expected | Count first rows |
| Next status | `LEAD` | Last row boundary is expected | Count last rows |
| Running sales | `SUM OVER` | Cumulative frame | Final value reconciles to total |
| Three-row average | `AVG OVER` | Moving frame | Early frames may have fewer rows |

## Reusable Design Template

| Design Item | Your Answer |
|---|---|
| Business question |  |
| Source grain |  |
| Output grain |  |
| Partition |  |
| Ordering |  |
| Tie-breaker |  |
| Function |  |
| Frame |  |
| Tie policy |  |
| Boundary policy |  |
| Null policy |  |
| Duplicate policy |  |
| Validation owner |  |
