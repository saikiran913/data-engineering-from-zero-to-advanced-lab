# Glossary

| Term | Meaning |
| --- | --- |
| CASE | A SQL expression that returns different results based on conditions. |
| WHEN | The part of a `CASE` expression that defines a condition to check. |
| THEN | The part of a `CASE` expression that defines the result when a condition is true. |
| ELSE | The fallback result used when no `WHEN` condition matches. |
| END | The keyword that closes a `CASE` expression. |
| CASE Expression | The full `CASE ... WHEN ... THEN ... ELSE ... END` structure. |
| Condition | A rule SQL checks, such as `order_amount >= 500`. |
| Result | The value returned when a condition matches. |
| Fallback Value | The value returned by `ELSE` when no condition matches. |
| Derived Column | A new output column created from existing data. |
| Business-Ready Output | A query result that is clear enough for reporting or review. |
| Business Rule | A decision rule based on business meaning, such as what counts as a high-value order. |
| Cleaning Rule | A rule that turns messy raw values into consistent clean values. |
| Mapping Rule | A rule that converts one or more source values into a chosen output value. |
| Standardisation | Making different versions of a value consistent. |
| Status Standardisation | Cleaning status values such as `active`, `Active`, and `ACTIVE`. |
| Country Standardisation | Cleaning country values such as `UK`, `U.K.`, and `United Kingdom`. |
| Channel Standardisation | Cleaning marketing channel values such as `social` and ` Social `. |
| Boolean Standardisation | Turning values such as `yes`, `Y`, and `true` into one consistent output. |
| Amount Band | A label that groups numeric amounts into ranges. |
| Price Band | A label that groups product prices into ranges. |
| Budget Band | A label that groups campaign budgets into ranges. |
| Performance Label | A business label that describes results, such as `Profitable` or `Needs Review`. |
| Conversion Label | A label that groups conversion counts into readable categories. |
| Health Label | A label that shows whether a row looks healthy or needs review. |
| Raw Column | A column exactly as it appears in the source data. |
| Clean Column | A column with standardised or clearer values. |
| Business Column | A derived column that adds business meaning. |
| Dashboard-Ready Field | A column designed to be easy to use in a dashboard. |
| Rule Documentation | Notes or comments that explain how a cleaning or business rule works. |
| Business Context | The reason a rule exists and how people will use it. |
| Unknown Label | A clear label for missing, unexpected, or unrecognised values. |
| Fallback Label | Another name for the output returned by `ELSE`. |
| SELECT-Based Transformation | A transformation that returns a cleaned result set without modifying the source table. |
