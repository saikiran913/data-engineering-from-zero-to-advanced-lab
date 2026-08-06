# Real-World Examples

| # | Current View Purpose | Proposed Change | Upstream Dependency | Downstream Consumer | Expected Benefit | Main Risk | Required Validation | Breaking Change Possible | Communication |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Customer directory | Add country name column | customers source | dashboard | More context | fixed schema change | column review | Yes | notify consumers |
| 2 | Sales summary | Rename revenue column | orders source | finance extract | clearer name | report failure | required-column check | Yes | agree naming |
| 3 | Customer export | Remove email column | customers source | scheduled extract | less exposed data | extract failure | consumer inventory | Yes | confirm need |
| 4 | Active customer view | Change active filter | customers source | analyst query | broader view | count changes | status distribution | Yes | explain rule |
| 5 | Order detail | Add payments join | orders and payments | order report | payment status | row multiplication | duplicate order check | Yes | document grain |
| 6 | Order detail | Inner to left join | customers source | dashboard | retain unmatched rows | null fields | unmatched review | Yes | explain retained rows |
| 7 | Campaign reporting | Daily to monthly grain | campaign metrics | campaign dashboard | monthly reporting | grain change | row count and totals | Yes | create new view if needed |
| 8 | Revenue summary | All orders to completed only | orders source | sales dashboard | cleaner metric | total changes | total reconciliation | Yes | define metric |
| 9 | Customer country | Null to `UNKNOWN` | customers source | country report | clearer grouping | distribution changes | null counts | Yes | document null rule |
| 10 | Order amount | Numeric type change | orders source | finance extract | display formatting | calculations fail | type contract review | Yes | keep numeric view |
| 11 | Current customer view | Deduplicate first | customers source | downstream view | one row per customer | tie-breaker risk | uniqueness check | Yes | approve rule |
| 12 | Reporting layer | New downstream view | existing view | analyst query | reuse logic | dependency chain | dependency map | Yes | document chain |
| 13 | Campaign latest load | Change latest-load rule | campaign source | marketing report | better corrections | changed metrics | old/new sample | Yes | explain tie-breaker |
| 14 | Valid orders | Add audit column | orders source | quality report | investigation support | fixed schema shift | consumer review | Yes | notify schema users |
| 15 | Order status | Change standardisation rule | orders source | refund report | clearer statuses | changed meaning | status distribution | Yes | explain business rule |
