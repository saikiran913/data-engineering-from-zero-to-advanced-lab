# Sample Tables for Day 030

Day 030 uses six CSV files to practise data-interface decisions.

| File | Purpose | Grain | Key | Likely Interface | Consumer Needs | Validation Questions | Dependency Notes |
|---|---|---|---|---|---|---|---|
| `raw_customer_events.csv` | Source-aligned customer events | one row per delivered event | `event_id`, `received_at` | raw table | audit replay and history | duplicate events, null values, out-of-order receives | downstream clean logic depends on event meaning |
| `clean_customers.csv` | Clean customer master | one row per customer | `customer_id` | clean table or clean view | stable customer profile | duplicate IDs, null country | reports depend on stable grain |
| `order_transactions.csv` | Order source versions | one row per order version | `order_id`, `updated_at` | raw or clean order interface | valid-order rules | invalid amounts, null customer, repeated order | sales summaries depend on filters |
| `daily_sales_reporting.csv` | Reporting-ready sales data | one row per region-date | `report_date`, `region` | reporting table or view | dashboard-ready metrics | duplicate region-date, null totals, date gaps | dashboard depends on stable grain |
| `interface_consumers.csv` | Consumer requirements | one row per consumer-interface need | `consumer_id` | documentation table | impact review | high sensitivity, history needs | links consumers to interface choices |
| `interface_decision_cases.csv` | Interface decision cases | one row per decision case | `case_id` | decision guide | learning scenarios | mismatched needs and interface choices | maps business question to interface |

Raw tables are useful when history, replay, and audit fields matter. Clean customer data has a clearly documented one-row-per-customer grain. Daily sales reporting has a one-row-per-region-date grain and includes duplicate and null examples for validation.
