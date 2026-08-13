# Day 033 Glossary

| Term | Simple Meaning | Beginner Example |
|---|---|---|
| Accepted population | Rows allowed to move forward | Stage rows marked `ACCEPTED` |
| Business key | Column used to identify a business record | `order_id` |
| Category completeness | Check that expected categories exist | expected order statuses are present |
| Checkpoint validation | Validation at a stage boundary | source-to-stage count check |
| Completeness | Whether required data is present | no null order IDs |
| Control total | Numeric total used for validation | sum of completed order amount |
| Data completeness | Overall presence of required data | keys, dates, files, and categories exist |
| Date completeness | Check expected dates are present | no missing order date |
| Distinct-key count | Count of unique keys | unique `order_id` count |
| Duplicate key | Key appearing more often than expected | two clean rows for one order |
| Exception | Something that needs investigation | target-only clean order |
| Exception report | Output listing validation issues | duplicate-key issue queue |
| Expected difference | Documented mismatch caused by rules | review rows excluded from clean |
| File completeness | Check expected files arrived | missing daily source file |
| Grouped control total | Numeric total by group | completed amount by date |
| Grouped reconciliation | Comparing grouped metrics | clean versus reporting by country |
| Issue count | Number of validation problems | duplicate key count |
| Key completeness | Whether required keys are present | no null `order_id` |
| Metric mismatch | Numeric values do not reconcile | reporting amount differs from clean |
| Null completeness | Check required fields are not null | null metric count |
| Pipeline validation | Checks that data moved correctly | source-to-clean reconciliation |
| Reconciliation | Comparing expected and actual data | accepted plus review equals staged |
| Reporting grain | What one report row represents | date and country group |
| Representative evidence | Sample rows proving an issue | one target-only order row |
| Review queue | Rows needing investigation | exception output |
| Row-count validation | Comparing row totals | source count versus stage count |
| Source-only key | Key in source but not target | source order missing from clean |
| Source population | Input rows being validated | source extract rows |
| Target-only key | Key in target but not source | clean order with no source order |
| Target population | Output rows being validated | clean order rows |
| Tolerance | Documented allowed difference | allowed rounding difference |
| Unexplained difference | Mismatch with no documented reason | target-only order |
| Validation evidence | Query output supporting a conclusion | count summary and exception rows |
| Validation rule | Documented condition to check | no duplicate clean order IDs |
| Validation status | Result label for a check | `PASS` or `REVIEW` |
