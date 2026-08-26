# Real-World Examples for Day 038

| # | Business rule | Table | Grain | Constraint concept | Columns | Expected condition | Validation query idea | Likely issue | Review action |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Customer ID identifies one customer | customers | One row per customer | Primary key | `customer_id` | Non-null and unique | Null and duplicate checks | duplicate or null ID | Review customer source |
| 2 | Order ID identifies one order | orders | One row per order | Primary key | `order_id` | Non-null and unique | Null and duplicate checks | duplicate order | Review clean grain |
| 3 | Payment ID identifies one payment | payments | One row per payment | Primary key | `payment_id` | Non-null and unique | Null and duplicate checks | duplicate payment | Review payment feed |
| 4 | Order line identity needs two fields | order lines | One row per order line | Composite key | `order_id`, `line_number` | Combination unique | Group by both fields | wrong grain | Review line model |
| 5 | Report date and country identify group | report | One row per date-country | Composite key | `report_date`, `country_group` | Combination unique | Group by both fields | duplicate report grain | Review aggregation |
| 6 | Orders reference customers | orders | One row per order | Foreign key | `customer_id` | Customer exists | Left join to customers | orphan order | Review customer load |
| 7 | Payments reference orders | payments | One row per payment | Foreign key | `order_id` | Order exists | Left join to orders | orphan payment | Review payment timing |
| 8 | Product code should be unique | products | One row per product | Unique | `product_code` | Non-null code unique | Group by product_code | duplicate code | Review product catalog |
| 9 | Email uniqueness is optional conceptually | customers | One row per customer | Validation-only | email | Depends on rules | Group by email if required | shared email | Confirm requirement |
| 10 | Order status allowed list | orders | One row per order | Check | `order_status` | In allowed list | WHERE NOT IN | unsupported status | Review status mapping |
| 11 | Payment status allowed list | payments | One row per payment | Check | `payment_status` | In allowed list | WHERE NOT IN | unsupported status | Review payment source |
| 12 | Order amount range | orders | One row per order | Check | `order_amount` | Amount >= 0 | Range check | negative amount | Review business context |
| 13 | Product price range | products | One row per product | Check | `unit_price` | Price > 0 | Range check | zero or negative price | Review catalog data |
| 14 | Order date required | orders | One row per order | Not null | `order_date` | Non-null | IS NULL | missing date | Review source file |
| 15 | Product code required | products | One row per product | Not null | `product_code` | Non-null | IS NULL | missing code | Review product setup |
| 16 | Orphan order | orders | One row per order | Foreign key | `customer_id` | Parent customer exists | Left join | missing parent | Report for review |
| 17 | Orphan payment | payments | One row per payment | Foreign key | `order_id` | Parent order exists | Left join | missing parent | Report for review |
| 18 | Customer with no orders | customers | One row per customer | Validation-only | `customer_id` | Depends on business rule | Left join to orders | no child rows | Review context |
| 19 | Order with no payment | orders | One row per order | Validation-only | `order_id` | Depends on status | Left join to payments | no payment | Review lifecycle |
| 20 | Warehouse rule not enforced | any | Depends | Documented rule | key columns | Validate anyway | Read-only checks | false confidence | Keep checks in pipeline |
| 21 | Business key versus surrogate key | customers | One row per customer | Key design | customer and internal IDs | Meaning documented | Compare grain | wrong identity | Document key role |
| 22 | Optional field null | customers | One row per customer | No constraint needed | `country` | May be null | Null review only if required | false failure | Confirm optionality |
| 23 | Multiple violations on one row | orders | One row per order | Multiple | status, amount, key | Each rule checked | Exception queue | several issue rows | Keep one row per issue |
| 24 | No-constraint-needed case | products | One row per product | No constraint needed | optional description | Optional text | No rule | over-constraining | Avoid unnecessary rule |

