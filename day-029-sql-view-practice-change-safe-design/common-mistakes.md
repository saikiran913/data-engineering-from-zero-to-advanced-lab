# Common Mistakes

| # | Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|---|
| 1 | Assuming query success means safe | SQL can run but logic can change | Reports may be wrong | Compare old and new outputs | Row and total checks |
| 2 | No consumer inventory | Impact is unknown | Consumers can break silently | List consumers | Consumer review |
| 3 | No dependency inventory | Source risks are hidden | Upstream changes surprise teams | List sources | Dependency review |
| 4 | Undocumented grain | Row meaning is unclear | Counts become misleading | Write output grain | Key check |
| 5 | No key validation | Duplicates go unnoticed | Grain may be broken | Check key uniqueness | Duplicate-key query |
| 6 | No null comparison | Null behaviour changes silently | Filters and groups change | Compare null counts | Null-count query |
| 7 | No total reconciliation | Metric changes are missed | Report totals shift | Compare totals | SUM checks |
| 8 | No date-boundary comparison | Date coverage changes | Period reporting shifts | Compare min and max dates | Date check |
| 9 | Renaming columns casually | Consumers reference old names | Reports fail | Review column contract | Required-column check |
| 10 | Removing columns without review | Required fields disappear | Extracts can fail | Review consumers | Impact summary |
| 11 | Filter changes without excluded-row checks | Records are added or removed | Meaning changes | List added and removed rows | Old/new comparison |
| 12 | Join changes without multiplication checks | Rows multiply | Totals inflate | Count rows per key | Duplicate-key check |
| 13 | Aggregation changes without grain review | Output grain changes | Counts differ | Document old and new grain | Grain summary |
| 14 | Adding columns without `SELECT *` review | Fixed schemas may shift | Consumers can break | Review fixed outputs | Consumer check |
| 15 | Deep dependencies | Debugging is hard | Impact spreads | Keep chains shallow | Dependency map |
| 16 | No sample checks | Totals hide row issues | Bad examples pass | Inspect records | Sample query |
| 17 | No expected-change documentation | Reviewers lack context | Good changes look suspicious | Mark expected changes | Summary status |
| 18 | Treating all differences as errors | Expected changes are blocked | Review becomes noisy | Separate expected differences | Review notes |
| 19 | Treating all differences as acceptable | Real issues pass | Trust drops | Investigate differences | Issue queue |
| 20 | No communication | Consumers are surprised | Reports break at use time | Document owner role | Consumer list |
| 21 | No real rollback planning | Production recovery is unclear | Operational risk increases | Handle outside this lesson | Team review |
| 22 | Replacement syntax without impact review | Existing interface may change | Consumers can break | Keep replacement out of beginner workflow | Platform review |
| 23 | Same alias with changed meaning | Consumers are misled | Metric meaning changes silently | Rename or document clearly | Metric review |
| 24 | Ignoring audit columns | Investigation is harder | Lineage is lost | Preserve useful audit fields | Audit check |
