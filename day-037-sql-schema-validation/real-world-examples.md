# Real-World Examples for Day 037

| # | Scenario | Validation rule | Expected | Observed | Risk | Review action |
|---|---|---|---|---|---|---|
| 1 | New audit column | Unexpected columns should be reviewed | No `source_batch_id` | `source_batch_id` appears | Low | Document if intentional |
| 2 | New business column | Additive business columns need review | No `order_currency` | `order_currency` appears | Medium | Check consumers and contract |
| 3 | Renamed customer field | Required column should keep stable name | `customer_id` | `customer_identifier` | High | Treat as possible rename only |
| 4 | Removed lineage field | Required audit column must exist | `source_file` | Missing | High | Review lineage consumers |
| 5 | Renamed order status | Status column should keep stable name | `order_status` | Similar new status field | High | Confirm meaning before mapping |
| 6 | Removed order amount | Required metric column must exist | `order_amount` | Missing | High | Reporting may break |
| 7 | Integer to decimal | Numeric widening may need review | `INTEGER` | `DECIMAL` | Medium | Check precision assumptions |
| 8 | Integer to string | Numeric logic may fail | `INTEGER` | `TEXT` | High | Review calculations and filters |
| 9 | String to integer | Non-numeric values may fail | `TEXT` | `INTEGER` | High | Check value patterns |
| 10 | Date to timestamp | Date grouping may change | `DATE` | `TIMESTAMP` | Medium | Review date filters |
| 11 | Timestamp to date | Time detail may be lost | `TIMESTAMP` | `DATE` | Medium | Review audit logic |
| 12 | Nullable change | Required column becomes nullable | `No` | `Yes` | High | Review null-handling assumptions |
| 13 | Non-nullable change | Optional column becomes non-nullable | `Yes` | `No` | Medium | Review load rules |
| 14 | Key column removed | Business key must remain present | `order_id` | Missing | High | Stop downstream trust until reviewed |
| 15 | Column order changed | Position-sensitive consumers may break | Position 4 | Position 3 | Medium | Check fixed extracts |
| 16 | `SELECT *` consumer with new column | Star queries can receive new fields | Stable output | Extra column appears | Medium | Review star consumers |
| 17 | Fixed extract with added column | Fixed exports expect exact layout | 8 columns | 9 columns | High | Review export contract |
| 18 | Possible semantic drift | Same name and type do not prove meaning | Gross amount | Net amount | High | Business review needed |
| 19 | V1 to V2 comparison | Version drift should be detected | V1 stable | V2 changed | High | Compare versions and summarise |
| 20 | No-change case | Matching contract still needs value checks | Name and type match | Name and type match | Low | Continue data-quality checks |
| 21 | Consumer-specific risk | One consumer may be more sensitive | Dashboard expects stable fields | Type changed | High | Notify owner role |
| 22 | Possible rename with uncertain meaning | SQL cannot prove equivalence | `customer_id` | `customer_identifier` | High | Keep review status until confirmed |

## Scenario Reminder

Schema validation finds structural changes. It does not prove that values are correct, and it does not automatically change the schema.

