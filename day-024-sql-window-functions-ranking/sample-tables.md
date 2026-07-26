# Sample Tables for Day 024

Day 024 uses six small datasets for ranking practice.

| Dataset | Purpose | Business Grain | Grouping Columns | Ranking Measure |
| --- | --- | --- | --- | --- |
| `employee_performance.csv` | Employee review ranking | One employee per review period | `department`, `review_period` | `performance_score` |
| `customer_sales.csv` | Customer sales ranking | One customer per sales period | `country`, `sales_period` | `total_sales` |
| `product_sales.csv` | Product sales ranking | One product per sales period | `category`, `sales_period` | `total_sales`, `units_sold` |
| `campaign_performance.csv` | Campaign performance ranking | One campaign per date | `channel`, `country` | `conversions`, `clicks` |
| `regional_daily_sales.csv` | Regional daily ranking | One region per date | `region` | `total_sales` |
| `ranking_rule_examples.csv` | Tie-policy examples | One rule scenario | Varies by scenario | Varies by scenario |

## Validation Questions

| Question | Why It Matters |
| --- | --- |
| Are ranking measures null? | Null values can produce unclear ranks |
| Are there tied top values? | Top-per-group may return multiple rows |
| Does each group have rank 1? | Confirms every eligible partition ranked |
| Is the input grain correct? | Wrong grain produces misleading ranks |
| Is the tie policy documented? | Business users need predictable rules |

The datasets intentionally include tied scores, tied sales, zero values, null values, top and bottom records, and multi-period examples.
