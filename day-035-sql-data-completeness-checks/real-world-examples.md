# Real-World Examples for Day 035

| # | Scenario | Completeness Question | Expected Population | Actual Population | Grain | Type | Missing Condition | Expected Exclusion | Evidence | Severity | Review Action |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Required order ID | Is every order keyed? | source rows | source rows | one source row | field | null `order_id` | none | source row ID | high | review source |
| 2 | Required customer ID | Is customer present? | source rows | source rows | one source row | field | null `customer_id` | documented guest checkout | order ID | high | review rule |
| 3 | Required order date | Is order date present? | source rows | source rows | one source row | field | null `order_date` | none | source file | high | review source |
| 4 | Required source file | Is lineage present? | stage rows | stage rows | one staged row | field | null file | none | stage record | medium | review load |
| 5 | Missing stage order | Did source reach stage? | source order IDs | stage order IDs | one order | key | source-only key | review exclusion | order ID | high | investigate |
| 6 | Missing clean order | Did accepted reach clean? | accepted stage keys | clean keys | one order | record | accepted-only key | documented exclusion | order ID | high | investigate |
| 7 | Clean-only order | Is target unexpected? | stage keys | clean keys | one order | record | target-only key | documented manual review | order ID | high | investigate |
| 8 | Expected report date | Is date present? | expected dates | report dates | one date | date | expected date absent | non-business day | date | high | review |
| 9 | Missing middle date | Did min/max hide a gap? | expected dates | report dates | one date | date | middle date absent | none | date list | high | review |
| 10 | Missing country group | Is group reported? | expected date-group | report date-group | one group per date | category | expected group absent | zero activity rule | date group | medium | review |
| 11 | Unexpected country group | Did new group appear? | expected groups | actual groups | one group | category | target-only group | documented new market | group | medium | review |
| 12 | Expected status | Is status represented? | expected statuses | source statuses | one status | status | status absent | no activity expected | status | medium | review |
| 13 | Unexpected status | Did source send new status? | expected statuses | source statuses | one status | status | unexpected status | none | status count | medium | map status |
| 14 | Expected source file | Did file arrive? | expected files | actual files | one file | file | file absent | late delivery | file name | high | review delivery |
| 15 | Duplicate file name | Was file loaded twice? | expected files | actual files | one file | file | duplicate count | reload documented | file count | medium | review |
| 16 | Accepted-clean coverage | Did accepted rows reach clean? | accepted rows | clean rows | one order | stage | accepted missing | review exclusion | order ID | high | investigate |
| 17 | Source-file-stage coverage | Did lineage persist? | source files | stage files | one file | file | missing stage file | file skipped by rule | file count | medium | review |
| 18 | Date-country reporting | Is report grid complete? | expected date groups | reporting groups | one date-group | category | group missing | zero activity rule | date group | high | review |
| 19 | Null reporting metric | Are metrics populated? | report rows | report rows | one report row | field | null metric | none | report key | high | review |
| 20 | Expected exclusion | Is missing row valid? | source rows | clean rows | one order | record | source-only key | review row excluded | validation reason | medium | document |
| 21 | Unexplained missing record | Is accepted key absent? | accepted stage | clean | one order | key | accepted-only key | none | order ID | high | investigate |
| 22 | 100 percent caution | Are values correct? | required fields | actual fields | one row | field | no missing fields | not applicable | field count | low | run correctness checks |
