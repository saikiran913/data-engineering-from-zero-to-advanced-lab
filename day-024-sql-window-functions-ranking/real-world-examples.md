# Real-World Examples

| Scenario | Input Grain | Partition | Ordering Measure | Function | Tie Policy | Validation |
| --- | --- | --- | --- | --- | --- | --- |
| Top product per category | Product per period | `category` | `total_sales DESC` | `RANK` | Preserve all tied products | Check tied top rows |
| All tied top products | Product per period | `category` | `total_sales DESC` | `RANK` | Return every tied winner | Count output rows |
| Highest-value customer per country | Customer per period | `country` | `total_sales DESC` | `ROW_NUMBER` | Tie-break with orders and ID | Review tie-breaker |
| Top three customer levels | Customer per period | `country` | `total_sales DESC` | `DENSE_RANK` | Keep levels | Count rows per level |
| Best campaign by channel and country | Campaign per date | `channel`, `country` | `conversions DESC` | `RANK` | Preserve tied campaigns | Review zero conversions |
| Highest-sales day per region | Region per date | `region` | `total_sales DESC` | `RANK` | Keep tied days | Check null sales |
| Lowest employee score per department | Employee per period | `department` | `performance_score ASC` | `RANK` | Preserve tied lows | Review score quality |
| Data-quality issue priority | Issue per group | dataset or rule | `issue_count DESC` | `DENSE_RANK` | Dense priority levels | Confirm counts |
| One current record per business key | Record versions | business key | timestamp descending | `ROW_NUMBER` | Approved tie-breaker | Check duplicates |
| Multi-period ranking | Entity per period | group and period | measure descending | `DENSE_RANK` | Restart per period | Validate period groups |
