# Day 037 Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Added column | A column that appears in observed schema but not before | `order_currency` appears in V2 |
| Additive change | A structural change that adds something | A new audit column appears |
| Breaking change | A change likely to break consumers | `customer_id` disappears |
| Column contract | The expected rule for one column | `order_amount` should be `DECIMAL` |
| Column order | The position of a column in the dataset | `order_date` is expected at position 4 |
| Consumer impact | Effect on downstream users | A dashboard query fails |
| Consumer sensitivity | How risky schema drift is for a consumer | Fixed exports are high sensitivity |
| Data type | The kind of value a column stores | `DATE`, `TEXT`, `DECIMAL` |
| Expected schema | The documented structure | The contract says eight columns exist |
| Key column | A column used to identify or group records | `order_id` |
| Missing column | Expected column not found in observed schema | `source_file` is missing |
| Non-nullable | Metadata says nulls are not allowed | `order_id` should not be null |
| Nullable | Metadata says nulls are allowed | Optional notes may allow nulls |
| Nullability | Whether a column may contain nulls | `order_status` changes to nullable |
| Observed position | Current column position in observed schema | `order_date` appears at position 3 |
| Observed schema | The structure currently found | V2 schema from the source |
| Optional column | Column that may be absent if documented | An optional description field |
| Possible rename | A missing column and new similar column need review | `customer_id` and `customer_identifier` |
| Removed column | A previous or expected column is gone | `source_file` disappears |
| Required column | Column that must be present | `order_id` |
| Schema | Dataset structure | Column names and types |
| Schema contract | Agreed expected schema | Clean order schema contract |
| Schema drift | Difference between expected and observed structure | Type changes in V2 |
| Schema exception | Review row for structural issue | Missing required column exception |
| Schema summary | Aggregated schema validation result | Count of type mismatches |
| Schema version | Label for a schema snapshot | V1 or V2 |
| Semantic drift | Business meaning changes while structure may look same | amount changes from gross to net |
| Source metadata | Information describing source structure | observed type and position |
| Structural validation | Checking dataset shape | Compare columns and types |
| Type compatibility | Whether type changes are likely safe | `DATE` to `TIMESTAMP` needs review |
| Type mismatch | Expected and observed types differ | `DECIMAL` versus `TEXT` |
| Unexpected column | Observed column not in expected contract | `audit_loaded_by` |

