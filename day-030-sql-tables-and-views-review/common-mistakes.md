# Common Mistakes

| # | Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|---|
| 1 | View when history must be stored | View logic may not preserve stored history | Audit needs fail | Use stored raw/history table | Row count and audit check |
| 2 | Table for one temporary calculation | Too much structure | Adds unnecessary maintenance | Use CTE or simple query | Confirm reuse need |
| 3 | CTE for many consumers | CTE is one statement only | Logic gets copied | Use view or table | Consumer count |
| 4 | Deep subqueries | Hard to read | Hard to validate | Use CTEs | Step validation |
| 5 | Exposing raw tables directly | Raw grain may confuse consumers | Reports may misuse data | Build clean interface | Grain review |
| 6 | Clean name means clean data | Name is not proof | Trust is misplaced | Validate rules | Null and key checks |
| 7 | Undocumented grain | Row meaning is unclear | Counts may be wrong | Document grain | Key uniqueness |
| 8 | No consumer analysis | Needs are unknown | Interface may not fit | List consumers | Consumer review |
| 9 | No dependency analysis | Upstream risk hidden | Changes surprise users | List sources | Dependency review |
| 10 | Current state vs history confusion | Wrong rows selected | Audit gaps appear | Separate interfaces | History check |
| 11 | Views always current and fast | Platform behaviour varies | Bad assumptions | Document freshness | Source comparison |
| 12 | Tables automatically trusted | Stored rows can still be wrong | Reports mislead | Validate tables | Reconciliation |
| 13 | No audit fields | Investigation is harder | Lineage is lost | Preserve audit fields | Audit-column check |
| 14 | Duplicated report logic | Rules drift | Different totals appear | Reusable interface | Compare reports |
| 15 | Deep view chains | Debugging is hard | Dependency risk grows | Limit chains | Dependency map |
| 16 | No validation | Issues stay hidden | Trust drops | Add checks | Summary query |
| 17 | No freshness definition | Consumers expect wrong timing | Reports conflict | Document freshness | Date/load check |
| 18 | No history requirement | Storage choice is weak | Wrong interface chosen | Ask history question | History review |
| 19 | No key definition | Grain is untestable | Duplicates hide | Define business key | Duplicate-key check |
| 20 | No exception output | Bad rows vanish | Issues are hidden | Create review queue | Issue count |
| 21 | New interface when simple query is enough | Overbuilding | More maintenance | Use simple query | Reuse review |
| 22 | Technology before requirements | Tool drives design | Bad fit | Start with question | Decision template |
| 23 | Treating reporting tables and views as interchangeable | Persistence differs | Freshness assumptions fail | Document trade-offs | Freshness validation |
| 24 | Ignoring change sensitivity | Consumers may break | Business impact increases | Review consumers | Sensitivity check |
