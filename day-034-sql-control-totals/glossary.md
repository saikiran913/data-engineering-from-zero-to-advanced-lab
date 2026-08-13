# Day 034 Glossary

| Term | Simple Meaning | Beginner Example |
|---|---|---|
| Accepted population | Rows allowed to move forward | staged rows marked `ACCEPTED` |
| Boundary control | Minimum or maximum check | min and max order date |
| Composite key | Key made from multiple columns | report date plus country group |
| Control summary | Compact list of control results | pass/review rows by control ID |
| Control total | Simple validation metric | row count or amount sum |
| Count control | Control based on row count | source row count |
| Date boundary | Earliest or latest date | minimum order date |
| Distinct count | Number of unique values | unique order IDs |
| Distinct-key control | Unique business-key check | distinct `order_id` count |
| Exact match | Controls should be equal | accepted count equals clean count |
| Expected difference | Documented difference | reporting count lower due to aggregation |
| Expected relationship | How controls should compare | target equals source |
| Grand total | Overall total across all rows | total completed amount |
| Grouped control | Control calculated by group | completed amount by country |
| Grouped count | Count by a dimension | orders by status |
| Grouped sum | Sum by a dimension | amount by date |
| Maximum boundary | Highest value | latest order date |
| Minimum boundary | Lowest value | earliest order date |
| Null-aware count | Count that considers null behaviour | `COUNT(column)` ignores nulls |
| Population | Rows included in a control | accepted staged rows |
| Reconciliation | Comparing controls | clean amount versus reporting amount |
| Reconciliation difference | Target minus source | reporting total minus clean total |
| Review population | Rows needing investigation | staged rows marked `REVIEW` |
| Row count | Number of rows | `COUNT(*)` result |
| Source population | Input rows in comparison | source sales extract |
| Stage pair | Two stages being compared | stage to clean |
| Stage reconciliation | Comparing pipeline stages | accepted stage to clean |
| Sum control | Numeric total check | `SUM(order_amount)` |
| Target population | Output rows in comparison | reporting summary |
| Unexplained difference | Difference without documented reason | target-only clean order |
| Validation evidence | Query result used for review | control summary row |
| Value boundary | Minimum or maximum numeric value | max order amount |
