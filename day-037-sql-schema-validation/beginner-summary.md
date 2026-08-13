# Beginner Summary

## What Learners Should Remember

Schema validation checks structure. It asks whether the dataset still has the columns, data types, nullability rules, and meanings that downstream consumers expect.

The most important comparison is expected schema versus observed schema. The expected schema is the documented contract. The observed schema is what the source currently exposes. If they differ, the data engineer should report the difference clearly.

Required columns matter more than optional columns. If a required column disappears, many consumers may fail. Optional columns may be absent if the contract allows it, but they should still be documented because some consumers may use them.

Unexpected columns are not automatically defects. A new audit column or descriptive field may be intentional. However, unexpected columns can still affect `SELECT *` consumers and fixed-schema exports, so they should be reviewed.

Type changes can affect downstream logic. If `order_amount` changes from `DECIMAL` to `TEXT`, numeric calculations may fail or behave differently. If `order_date` changes from `DATE` to `TIMESTAMP`, date grouping may change. Compatibility depends on platform and consumer logic.

Nullability metadata and actual null values are different checks. A schema may say a column is nullable, but the current data may have no nulls. A schema may say a column should not be nullable, but row-level validation is still needed to check actual values.

Column order is a weak contract. SQL should usually use explicit column names. Some extracts are position-sensitive, so order changes should be reviewed, but position should not be the main way to understand a schema.

Renamed columns often appear as one removed column plus one added column. SQL can highlight the possibility, but it should not automatically decide semantic equivalence. `customer_id` and `customer_identifier` may be related, but a human should confirm the meaning.

Schema drift should be detected and documented. Consumer impact matters because dashboards, reports, extracts, downstream views, and validation checks can all depend on stable structure.

Schema validation should produce exceptions, not migrations. All Day 037 SQL remains read-only. It detects and reports structural issues only.

## Mental Model

Define the expected structure, observe the actual structure, compare columns and types, review changes, assess consumers, and report anything that may break the contract.

## Final Warnings

> A schema match does not prove that the data values are correct. Schema validation checks structure, not full data quality.

> A missing, renamed, removed, or type-changed column can break downstream consumers even when the source query still runs successfully.

> An unexpected column is not automatically a defect. It may be an intentional additive change, but downstream consumers should still be reviewed.

> Schema validation should detect and report structural changes. It should not automatically alter tables, rename columns, or migrate data.

## What Comes Next

Day 038 will deepen schema-change review with more practical old-versus-new comparisons, breaking-change examples, consumer impact scenarios, and safe compatibility review while remaining non-destructive.

