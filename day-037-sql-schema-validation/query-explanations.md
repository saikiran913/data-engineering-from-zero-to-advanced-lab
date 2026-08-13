# Day 037 Query Explanations

Day 037 uses supplied schema-catalog CSV files so learners can practise schema validation without relying on platform-specific metadata tables.

## Expected Versus Observed Columns

Business purpose: compare the documented contract with what the source currently exposes.

Schema grain: one row per column.

Comparison key: `column_name`.

Evidence: expected type, observed type, required flag, expected position, and observed position.

Common risk: inspecting only the observed schema and never checking it against a contract.

## Required Column Validation

Business purpose: find expected required columns missing from an observed schema.

Schema grain: one row per expected column.

Issue category: `MISSING_COLUMN`.

Severity: missing required columns are usually `HIGH_REVIEW`.

Common risk: treating optional and required columns the same.

## Unexpected Column Review

Business purpose: identify columns present in the observed schema but absent from the contract.

Schema grain: one row per unexpected observed column.

Issue category: `UNEXPECTED_COLUMN`.

Severity: often `REVIEW`; audit-like additions may be `INFO` in this educational sample.

Common risk: calling every extra column a defect. It may be an intentional additive change.

## Data-Type Validation

Business purpose: compare expected and observed type labels.

Schema grain: one row per matched column.

Evidence: `expected_data_type` and `observed_data_type`.

Common risk: assuming all type changes are safe or unsafe without reviewing consumers.

## Nullability Contract Validation

Business purpose: compare expected nullability metadata with observed metadata.

Schema grain: one row per matched column.

Evidence: expected nullable flag and observed nullable flag.

Common risk: confusing nullability metadata with actual row-level null values.

## Renamed and Removed Column Review

Business purpose: review missing expected columns and unexpected observed columns that may indicate rename or removal.

Schema grain: one row per missing or unexpected column.

Evidence: missing expected column, unexpected observed column, type, and review message.

Common risk: automatically deciding that two similar names are equivalent.

## Additive Change Review

Business purpose: review new columns that were not in the contract.

Schema grain: one row per added-looking column.

Evidence: observed type, nullability, position, and consumer impact.

Common risk: ignoring `SELECT *` consumers.

## Schema Change Detection

Business purpose: compare observed V1 and observed V2.

Schema grain: one row per distinct observed column name across both versions.

Operation: `UNION` creates a distinct list of column names for comparison.

Common risk: using version comparison without also comparing to the expected contract.

## Consumer Impact Review

Business purpose: identify reports, extracts, views, and dashboards that may break.

Schema grain: one row per consumer.

Evidence: required columns, expected types, `select_star_usage`, sensitivity, and owner role.

Common risk: finding schema drift but not checking who depends on the changed fields.

## Schema Exception Reporting

Business purpose: convert schema findings into review-queue rows.

Schema grain: one row per schema issue.

Output shape: exception level, scope, entity key, category, issue type, expected value, actual value, severity, sensitivity, and review message.

Common risk: creating vague exceptions that do not explain expected and actual structure.

## Integrated Workflow

The integrated workflow:

1. finds missing required columns
2. finds unexpected columns
3. finds type mismatches
4. finds nullability mismatches
5. combines them with `UNION ALL`
6. summarises change cases by risk
7. lists consumers to review first

`UNION ALL` is used for the exception queue because each issue row should be preserved.

## Line-by-Line Queue Pattern

| Query part | Meaning |
|---|---|
| `WITH missing_required AS (...)` | Creates a rule-family result for missing required columns |
| `unexpected_columns AS (...)` | Creates a result for observed columns outside the contract |
| `type_mismatch AS (...)` | Creates a result for type differences |
| `nullability_mismatch AS (...)` | Creates a result for nullability differences |
| Matching selected columns | Makes the rule outputs stack safely |
| `UNION ALL` | Preserves every schema exception row |
| `entity_key` | Uses the affected column name |
| `expected_value` and `actual_value` | Show what the contract expected and what was observed |
| `severity` | Supports review priority |
| `review_message` | Explains the investigation action |

## Platform Note

Real databases expose metadata in different catalog views and with different type names. Day 037 keeps the lesson portable by storing schema metadata in CSV files.

