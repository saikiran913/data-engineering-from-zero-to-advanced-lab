# Function Selection Guide

| Business Requirement | Suggested Approach | Main Warning |
| --- | --- | --- |
| Need the previous row | `LAG` | Ordering defines previous |
| Need the next row | `LEAD` | Last row boundary is expected |
| Need a position | Ranking function from Day 024 | Choose tie policy |
| Need an aggregate summary | `GROUP BY` | Rows are collapsed |
| Need first or last row | `LAG`, `LEAD`, `ROW_NUMBER`, or aggregate | Depends on the question |
| Need status-change detection | `LAG` | Change does not explain cause |
| Need next expected state | `LEAD` | Sequence must be validated |

## Rule-Documentation Template

| Field | Example |
| --- | --- |
| Business question | Detect payment status changes |
| Input grain | One status row per transaction sequence |
| Partition key | `transaction_id` |
| Ordering columns | `status_sequence`, `status_timestamp` |
| Tie-breaker | Document duplicate sequence rule |
| Function | `LAG` |
| Offset | 1 |
| Default value | Preserve `NULL` |
| Null-boundary policy | Label first status |
| Change calculation | Current status compared to previous |
| Review rule | Status changed or sequence gap |
| Validation owner | Data quality reviewer |
