# Real-World Examples

| # | Business Question | Input Layer | Input Grain | Intermediate Method | Stage Grain | Accepted Rule | Review Rule | Audit Fields | Validation | Downstream Handoff |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Raw events to latest order state | raw | event delivery | CTE stage | order candidate | latest valid event | null or invalid values | source_file, received_at | duplicate order check | clean orders |
| 2 | Duplicate event review | raw | event delivery | simple query | event issue | none | repeated event_id | source_file | duplicate count | review queue |
| 3 | Null customer review | stage | order candidate | review output | issue row | customer present | customer missing | source_file | null count | review queue |
| 4 | Invalid amount review | stage | order candidate | review output | issue row | amount positive | amount missing or invalid | received_at | amount check | review queue |
| 5 | Late-arriving event review | raw | event delivery | CTE | timing issue | valid timing | received before event time | received_at | date check | investigation |
| 6 | Source-file standardisation | raw | event delivery | CTE | event delivery | known file pattern | unknown file | source_file | file distribution | stage |
| 7 | Status standardisation | stage | order candidate | CTE | order candidate | supported status | unsupported status | source_file | status count | clean |
| 8 | Stage to clean orders | stage | order candidate | accepted split | clean order | accepted status | review status | received_at | key uniqueness | clean layer |
| 9 | Clean to daily reporting | clean | clean order | aggregation | date-group row | clean rows | null metrics | cleaned_at | total reconciliation | reporting |
| 10 | Reporting total reconciliation | reporting | date-group row | validation query | check row | totals match | difference found | loaded time | SUM check | dashboard |
| 11 | Customer-level staging | raw | event | CTE | customer-day | valid key | null key | source_file | key check | aggregation |
| 12 | Campaign delivery staging concept | raw | delivery | stage concept | campaign-date | latest delivery | duplicate load | loaded time | duplicate check | reporting |
| 13 | Payment status staging concept | raw | payment attempt | stage concept | payment attempt | supported status | failed or null | source_file | status count | exception output |
| 14 | No extra stage needed | clean | clean order | simple query | check row | one-time need | none | none | count check | analyst |
| 15 | Too many stages case | stage | mixed | reduce stages | clear stage | combine trivial steps | unclear purpose | audit fields | readability review | pipeline |
| 16 | Review-queue handoff | stage | issue row | UNION ALL | issue row | accepted excluded | review included | source_file | issue count | data quality review |
