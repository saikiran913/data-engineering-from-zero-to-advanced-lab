# Real-World Examples for Day 034

| # | Scenario | Control Question | Source Stage | Target Stage | Control Type | Source Population | Target Population | Expected Relationship | Expected Difference | Evidence | Main Risk |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Source file row count | Did the file contain rows? | Source | Source | row count | all source rows | none | count > 0 | none | source row count | empty file |
| 2 | Source distinct order count | How many unique orders arrived? | Source | Source | distinct-key | source orders | none | reviewed count | duplicates possible | distinct order count | repeated records hidden |
| 3 | Deduplication count difference | Did duplicates reduce expected rows? | Source | Stage | distinct-key | source records | staged candidates | explained reduction | duplicate source rows | row and key counts | wrong deduplication |
| 4 | Accepted-review reconciliation | Did all staged rows get classified? | Stage | Stage | accepted-review | staged rows | accepted plus review | exact match | none | unexplained difference | hidden row loss |
| 5 | Accepted-clean count | Did accepted rows reach clean? | Stage | Clean | row count | accepted rows | clean rows | exact match if one-to-one | documented exclusions | count difference | missing clean rows |
| 6 | Accepted-clean amount | Did amounts remain stable? | Stage | Clean | sum | accepted amounts | clean amounts | exact match | documented changes | amount difference | changed measures |
| 7 | Completed amount | Does reporting match clean completed sales? | Clean | Reporting | sum | clean completed | report completed | exact match | none unless documented | completed amount diff | wrong KPI |
| 8 | Refund amount | Do refunds reconcile? | Clean | Reporting | sum | clean refunded | report refunds | exact match | none unless documented | refund amount diff | refund mismatch |
| 9 | Pending count | Do pending counts reconcile? | Clean | Reporting | count | clean pending | report pending | exact match | aggregation | pending count diff | missing pending rows |
| 10 | Minimum date | Did earliest date shift? | Source | Clean | min | source dates | clean dates | explained boundary | review exclusions | min date comparison | missing early data |
| 11 | Maximum date | Did latest date shift? | Source | Clean | max | source dates | clean dates | explained boundary | target-only future row | max date comparison | future data leak |
| 12 | Minimum amount | Is the lowest amount expected? | Clean | Clean | min | clean amounts | none | reviewed boundary | none | min amount row | abnormal value |
| 13 | Maximum amount | Is the highest amount expected? | Clean | Clean | max | clean amounts | none | reviewed boundary | target-only row may inflate | max amount row | outlier |
| 14 | Country-group count | Are groups represented? | Clean | Reporting | grouped count | clean groups | report groups | groups align | zero groups may be absent | group counts | missing group |
| 15 | Status count | Did status distribution change? | Source | Stage | grouped count | raw statuses | standard statuses | explained mapping | standardisation | status counts | hidden status change |
| 16 | Source-file count | Did file counts look complete? | Source | Source | grouped count | rows by file | none | expected files present | late file possible | file counts | missing file |
| 17 | Grouped completed amount | Do completed amounts match by group? | Clean | Reporting | grouped sum | clean completed by date/group | reporting completed by date/group | exact match | none unless documented | grouped amount diff | hidden mismatch |
| 18 | Grouped refund amount | Do refunds match by group? | Clean | Reporting | grouped sum | clean refunds | report refunds | exact match | none unless documented | grouped refund diff | refund error |
| 19 | Reporting duplicate key | Is reporting grain unique? | Reporting | Reporting | grouped count | report rows | report key groups | one row per key | none | duplicate keys | double counting |
| 20 | Missing country group | Is every clean group reported? | Clean | Reporting | grouped count | clean country groups | report country groups | groups represented | documented zero group | missing group row | incomplete dashboard |
| 21 | Source-only order | Which source order is not clean? | Source | Clean | key comparison | source orders | clean orders | explained missing keys | review exclusions | source-only list | data loss |
| 22 | Target-only order | Which clean order lacks source? | Source | Clean | key comparison | source orders | clean orders | none expected | documented manual review only | target-only list | unexplained target data |
