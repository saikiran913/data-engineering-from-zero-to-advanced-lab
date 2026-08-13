# Sample Tables for Day 037

Day 037 uses schema-catalog CSV files. These files describe expected and observed structures instead of storing order transactions.

## Sample Files

| File | Purpose | Important learning use |
|---|---|---|
| `expected_order_schema.csv` | The documented order schema contract | Defines expected columns, types, required flags, nullability, meaning, and position |
| `observed_order_schema_v1.csv` | First observed source schema | Mostly matches expected schema and includes a mild additive column |
| `observed_order_schema_v2.csv` | Later observed source schema | Contains missing, unexpected, type, nullability, rename, and position-change examples |
| `schema_consumer_catalog.csv` | Downstream consumer list | Shows who may be affected by schema drift |
| `schema_change_cases.csv` | Educational change-case catalog | Documents common schema-change scenarios and risk |
| `schema_validation_rules.csv` | Rule catalog for schema checks | Shows validation types, severity, issue categories, and review messages |

## Expected Order Schema

Columns:

| Column | Meaning |
|---|---|
| `column_name` | Expected column name |
| `expected_data_type` | Generic expected type |
| `required_flag` | Whether the column must exist |
| `nullable_flag` | Expected nullability metadata |
| `business_meaning` | Plain-language meaning |
| `key_role` | Whether the column is a key, date key, audit field, or reporting group |
| `consumer_sensitivity` | How sensitive consumers are to changes |
| `expected_position` | Documented column order for review |

## Observed Schemas

`observed_order_schema_v1.csv` mostly matches the contract and includes `source_batch_id` as a mild additive case.

`observed_order_schema_v2.csv` includes:

- `customer_id` missing
- `customer_identifier` as a possible rename candidate
- `source_file` missing
- `order_amount` changing from `DECIMAL` to `TEXT`
- `order_date` changing from `DATE` to `TIMESTAMP`
- `loaded_at` changing from `TIMESTAMP` to `DATE`
- `order_status` becoming nullable
- added columns such as `order_currency`, `audit_loaded_by`, and `source_system`
- column position changes

## Consumer Catalog

The consumer catalog includes dashboards, reporting queries, analyst extracts, downstream views, application reports, and validation reports.

Important fields:

| Column | Meaning |
|---|---|
| `required_columns` | Columns the consumer expects |
| `expected_types` | Consumer type expectations |
| `select_star_usage` | Whether the consumer may be sensitive to added or reordered columns |
| `change_sensitivity` | Review priority if schema drift appears |
| `owner_role` | Team or role that should review impact |

## Schema Compatibility Map

| Comparison | Key | Main question |
|---|---|---|
| Expected to V1 | `column_name` | Does V1 match the contract? |
| Expected to V2 | `column_name` | What contract differences exist in V2? |
| V1 to V2 | `column_name` | What changed between observed versions? |
| Schema changes to consumers | Consumer metadata | Which downstream users may be affected? |

## Important Learning Issues

- missing required columns
- unexpected columns
- possible renamed columns
- removed audit columns
- data-type mismatch
- nullability mismatch
- position-only change
- additive audit fields
- `SELECT *` consumer risk
- semantic drift that SQL cannot prove automatically

