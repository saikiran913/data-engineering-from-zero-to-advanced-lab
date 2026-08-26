# Sample Tables for Day 042

Day 042 uses six CSV files to practise safe performance habits with generic order, customer, item, and query-review examples.

## File Overview

| File | Purpose | Grain | Key | Performance role |
|---|---|---|---|---|
| `orders_performance_sample.csv` | Order-level business events | One row per order | `order_id` | Projection, filters, joins, sorting, aggregation |
| `customers_performance_sample.csv` | Customer attributes | One row per customer | `customer_id` | Join necessity and customer filters |
| `order_items_performance_sample.csv` | Item-level order detail | One row per order line | `order_id`, `line_number` | Row multiplication and pre-aggregation |
| `query_pattern_catalog.csv` | Query pattern reference | One row per query pattern | `query_id` | Reviews required columns, filters, joins, and risks |
| `performance_casebook.csv` | Performance habit scenarios | One row per case | `case_id` | Debugging and rewrite decisions |
| `query_comparison_catalog.csv` | Naive-versus-improved comparisons | One row per comparison | `comparison_id` | Equivalence and risk review |

## Orders

| Column | Meaning |
|---|---|
| `order_id` | Unique order identifier |
| `customer_id` | Customer connected to the order |
| `order_date` | Business date |
| `order_status` | Status such as completed, pending, failed, or cancelled |
| `country_group` | Region grouping |
| `order_amount` | Order value |
| `channel` | Acquisition or order channel |
| `source_file` | File lineage label |
| `loaded_at` | Load timestamp |

Common patterns: exact lookup, monthly report, status dashboard, channel report, country report, and top-N order report.

Validation questions:

- Does the filter use the true business date?
- Are only required columns selected?
- Is sorting required by the consumer?

## Customers

| Column | Meaning |
|---|---|
| `customer_id` | Unique customer identifier |
| `customer_status` | Active or inactive status |
| `country_group` | Region grouping |
| `customer_segment` | Customer segment |
| `signup_date` | Signup date |
| `preferred_channel` | Preferred communication or sales channel |
| `loaded_at` | Load timestamp |

Common patterns: segment enrichment, active customer filters, and optional customer attributes.

Validation questions:

- Does the query really need customer columns?
- Does the join apply a hidden business rule?
- Are customer keys unique?

## Order Items

| Column | Meaning |
|---|---|
| `order_id` | Parent order |
| `line_number` | Item line inside the order |
| `product_code` | Generic product code |
| `quantity` | Quantity ordered |
| `unit_price` | Unit price |
| `line_amount` | Line value |
| `category` | Product category |

Common patterns: item revenue, item total by order, order-to-item join, and row multiplication review.

Validation questions:

- Is the output order-level or item-level?
- Is pre-aggregation to order level valid?
- Does the join multiply rows as expected?

## Metadata Files

| File | Columns | Use |
|---|---|---|
| `query_pattern_catalog.csv` | query details, columns, filters, joins, sorts, aggregation grain, risk | Plan query reviews |
| `performance_casebook.csv` | business question, current pattern, unnecessary work, safer habit, risk, validation | Classify rewrite candidates |
| `query_comparison_catalog.csv` | version A, version B, differences, expected relationship, review note | Compare equivalent and non-equivalent rewrites |

