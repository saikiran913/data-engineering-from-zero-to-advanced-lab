# Metric Selection Guide

| Business Requirement | Suggested Metric | Example Frame | Main Warning |
| --- | --- | --- | --- |
| Total so far | Running total | `UNBOUNDED PRECEDING` to `CURRENT ROW` | Reconcile final value |
| Count so far | Cumulative count | `UNBOUNDED PRECEDING` to `CURRENT ROW` | Check duplicate rows |
| Average from start | Cumulative average | `UNBOUNDED PRECEDING` to `CURRENT ROW` | Nulls may affect inputs |
| Recent rows only | Moving sum or average | `2 PRECEDING` to `CURRENT ROW` | Three rows is not three days |
| Previous or next row | `LAG` or `LEAD` | Not a frame aggregate | Use Day 025 pattern |
| One summary row per group | `GROUP BY` | No window frame | Detail rows collapse |

## Rule-Documentation Template

| Field | Example |
| --- | --- |
| Business question | Running sales by region |
| Input grain | One region per sale/load row |
| Partition columns | `region` |
| Ordering columns | `sale_date`, `loaded_at` |
| Tie-breaker | `loaded_at` |
| Measure | `total_sales` |
| Function | `SUM` |
| Frame | `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Null policy | Review null sales |
| Missing-date policy | Review calendar gaps |
| Duplicate policy | Review duplicate business dates |
| Validation owner | Data quality reviewer |
