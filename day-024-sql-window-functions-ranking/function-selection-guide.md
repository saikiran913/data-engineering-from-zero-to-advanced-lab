# Function Selection Guide

Choose the ranking function based on the business question, especially the tie policy.

| Business Requirement | Suggested Function | Main Warning |
| --- | --- | --- |
| Exactly one record per group | `ROW_NUMBER` | Tie-breaker must be documented |
| Preserve all tied winners | `RANK` | Rank numbers may skip |
| Dense leaderboard levels | `DENSE_RANK` | Multiple rows can share a level |
| Top three ranks with ties | `RANK` | May return more than three rows |
| Top three performance levels | `DENSE_RANK` | May return many rows |
| Lowest value per group | `RANK` or `ROW_NUMBER` with `ASC` | Confirm low value is really best or worst |
| One current record per key | `ROW_NUMBER` | Requires meaningful ordering |

## Rule-Documentation Template

| Field | Example |
| --- | --- |
| Business question | Highest-value customer per country |
| Input grain | One row per customer per period |
| Partition columns | `country` |
| Ordering columns | `total_sales DESC, total_orders DESC` |
| Direction | Highest first |
| Tie policy | Choose one using approved tie-breaker |
| Null policy | Exclude and review null sales |
| Function | `ROW_NUMBER` |
| Filter | `row_num = 1` |
| Validation owner | Data quality reviewer |
