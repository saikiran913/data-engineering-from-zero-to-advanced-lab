# Real-World Review Scenarios

| # | Business Question | Source Grain | Output Grain | Aggregation Needed? | Partition | Ordering | Recommended Function | Frame | Policy | Validation |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Exactly one top customer per country | Customer-date | Country winner | Sometimes | `country` | Spend descending, customer id | `ROW_NUMBER` | None | Document tie-breaker | One row per country |
| 2 | All tied top products per category | Product-date | Product rows at top rank | Maybe | `category` | Sales descending | `RANK` | None | Preserve ties | Count rank 1 rows |
| 3 | Previous campaign conversions | Campaign-date | Campaign-date | No | `campaign_id` | Metric date | `LAG` | None | First row has null previous | Count first rows |
| 4 | Next customer status | Customer-date | Customer-date | No | `customer_id` | Activity date, load time | `LEAD` | None | Last row has null next | Count last rows |
| 5 | Cumulative regional sales | Region-date | Region-date | No | `region` | Sale date | `SUM OVER` | Cumulative rows | Include current row | Reconcile final total |
| 6 | Three-row campaign spend average | Campaign-date | Campaign-date | No | `campaign_id` | Metric date | `AVG OVER` | Two preceding rows plus current | Early rows have smaller frames | Count frame rows |
| 7 | Pipeline quality ranking | Pipeline-date | Pipeline rank per date | No | `load_date` | Issue count descending | `RANK` | None | Keep tied issue counts | Count ties |
| 8 | Cumulative rejected records | Pipeline-date | Pipeline-date | No | `pipeline_name` | Load date | `SUM OVER` | Cumulative rows | Include current row | Final total reconciliation |
| 9 | Missing sales dates | Region-date | Region-date review | No | `region` | Sale date | `LAG` | None | Date gaps need review | Inspect gaps manually |
| 10 | First and last activity per customer | Customer-date | Boundary rows | No | `customer_id` | Activity date | `ROW_NUMBER` | None | First and last are different checks | Count boundaries |
| 11 | Aggregate-before-ranking products | Product-date | Category-product total | Yes | `category` | Total sales descending | `RANK` | None | Rank grouped totals | Compare grouped totals |
| 12 | Duplicate-ordering review | Entity-date | Review rows | No | Entity id | Date and load time | `ROW_NUMBER` | None | Duplicate dates need tie-breaker | Count entity-date rows |
| 13 | Mixed campaign monitoring | Campaign-date | Campaign-date review | No | Campaign or channel-country | Date or conversions | Mixed functions | Cumulative and moving rows | Validate each metric separately | Review flags |
| 14 | Total rejected records per pipeline | Pipeline-date | One row per pipeline | Yes | None | None | `GROUP BY` | None | No window needed | Row count equals pipeline count |

Use INR in prose if currency is needed, but keep CSV values numeric.
