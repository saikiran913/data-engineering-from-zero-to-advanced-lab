# View Design Guide

## Start With the Consumer

Ask:

- Who will query the view?
- What business question does it support?
- What grain do they need?
- Which columns do they need?
- Which columns should not be exposed?

## Define Source and Output Grain

Source grain describes the input rows. Output grain describes view rows. A join or aggregation can change grain, so document it clearly.

## Choose Columns Explicitly

Avoid `SELECT *` in reusable views. Explicit columns make the interface easier to understand and safer for consumers.

## Choose Stable Aliases

Business-facing views should use stable, readable names such as `completed_order_amount` instead of unclear abbreviations.

## Document Business Rules

Filters, joins, calculations, and status mappings are business rules. Write them down near the view definition.

## Preserve Auditability

Keep audit columns such as `updated_at`, `loaded_at`, and `source_file` when they help investigation.

## Separate Clean and Exception Outputs

A clean view exposes accepted rows. A review view exposes suspicious rows. Both can be useful.

## Limit Dependency Depth

Avoid long chains of views over views. They are harder to debug when something changes upstream.

## Validate Before Sharing

Check row counts, uniqueness, nulls, duplicate keys, totals, join multiplication, and source dependencies.

## Version and Change Thinking

Changing a view's columns or meanings may break consumers. Treat business-facing view changes with care.

## View-Definition Template

| Item | Notes |
|---|---|
| View name |  |
| Business purpose |  |
| Intended consumers |  |
| Source objects |  |
| Source grain |  |
| Output grain |  |
| Key columns |  |
| Exposed columns |  |
| Excluded columns |  |
| Filters |  |
| Joins |  |
| Derived columns |  |
| Null policy |  |
| Audit columns |  |
| Dependencies |  |
| Validation checks |  |
| Known limitations |  |
| Owner |  |
| Last reviewed date |  |
