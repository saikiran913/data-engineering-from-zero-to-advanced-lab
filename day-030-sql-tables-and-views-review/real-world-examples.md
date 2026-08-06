# Real-World Examples

| # | Business Question | Source Grain | Output Grain | Persistence | Reuse | History | Freshness | Consumer | Recommended Interface | Main Risk | Validation |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Preserve raw event history | event delivery | event delivery | Yes | Yes | Yes | batch | pipeline | raw table | losing audit trail | row count |
| 2 | Latest customer profile | customer history | customer | No | Yes | No | current | application report | current-state view | duplicate keys | key check |
| 3 | Clean customer master | customer source | customer | Yes | Yes | Some | daily | extract | clean table | hidden rules | null and key checks |
| 4 | Valid-order interface | order version | valid order | No | Yes | No | current | reports | view | filter confusion | excluded rows |
| 5 | Customer sales summary | order | customer | Maybe | Yes | Some | daily | dashboard | reporting view or table | grain mismatch | totals |
| 6 | Daily regional dashboard | region-date | region-date | Maybe | Yes | Some | daily | dashboard | reporting table or view | duplicate dates | key check |
| 7 | Monthly stored history | region-date | region-month | Yes | Yes | Yes | monthly | scheduled extract | reporting table | refresh confusion | totals |
| 8 | Duplicate investigation | event delivery | event_id count | No | No | No | one-time | analyst | CTE/simple query | overbuilding | duplicate count |
| 9 | Source-target validation | source rows | check row | No | No | No | one-time | validation report | CTE | missing detail | summary checks |
| 10 | Payment exception report | order version | issue row | No | Yes | No | current | data quality | exception view | hidden invalid rows | issue count |
| 11 | Latest campaign delivery | delivery load | latest delivery | No | Yes | No | current | analyst | current-state view | tie-breaker | key check |
| 12 | Campaign reporting | delivery load | campaign-date | Maybe | Yes | Some | daily | dashboard | reporting view | corrected loads | totals |
| 13 | Stable dashboard columns | report source | report row | Maybe | Yes | Some | daily | dashboard | reporting interface | schema changes | consumer review |
| 14 | Analyst one-time calculation | order | selected order | No | No | No | one-time | analyst | subquery | unreadable logic | sample check |
| 15 | Audit replay requirement | event delivery | event delivery | Yes | Yes | Yes | batch | pipeline | raw table | missing audit columns | audit check |
| 16 | Simple customer lookup | customer | customer | No | No | No | one-time | analyst | no new interface | unnecessary object | row count |
