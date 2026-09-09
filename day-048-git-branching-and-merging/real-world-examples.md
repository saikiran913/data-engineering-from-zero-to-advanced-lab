# Real-World Examples

| # | Situation | Branch purpose | Likely files | Merge consideration | Validation | Conflict risk |
|---|---|---|---|---|---|---|
| 1 | New SQL validation query | Add validation | `sql/` | Compare SQL before merge | Read/run query safely | Medium |
| 2 | Fix SQL join | Correct logic | `sql/` | Same query may change elsewhere | Check row grain | High |
| 3 | Update Bash validation script | Improve local check | `scripts/` | Script behaviour may change | Run on sample data | Medium |
| 4 | Add schema documentation | Explain columns | `docs/` | Docs should match SQL | Read docs | Low |
| 5 | Update data-quality rules | Change business rule | `docs/`, `sql/` | SQL and docs should align | Review both | Medium |
| 6 | Change accepted status list | Update status logic | `docs/validation-notes.md` | Same line may be edited | Confirm final statuses | High |
| 7 | Add new sample data | Improve examples | `sample-data/` | Avoid large raw data | Parse CSV | Low |
| 8 | Refactor notes only | Improve wording | `docs/` | Keep separate from SQL logic | Read rendered text | Low |
| 9 | Two people edit same SQL WHERE clause | Overlapping logic | `sql/daily_orders.sql` | Conflict likely | Confirm filter meaning | High |
| 10 | Two branches edit different files | Parallel work | `sql/`, `docs/` | Auto merge likely | Validate both files | Low |
| 11 | Branch changes SQL and docs | Related feature | `sql/`, `docs/` | Commit together if one purpose | Query and notes align | Medium |
| 12 | Main changes README while feature changes SQL | Separate areas | README and SQL | Auto merge likely | Review both | Low |
| 13 | Conflict in config text | Same setting changed | config file | Human decision needed | Check intended value | High |
| 14 | Conflict in documentation | Same sentence edited | docs | Combine meaning carefully | Read final text | Medium |
| 15 | Feature branch with unrelated formatting | Mixed purpose | many files | Harder review | Split conceptually next time | Medium |
| 16 | Long-running feature branch | Old branch | many files | More drift | Compare often | High |
| 17 | Fast-forward case | Feature ahead only | focused files | Simple pointer move | Validate anyway | Low |
| 18 | Merge-commit case | Histories diverged | multiple files | Merge commit records combine | Inspect graph | Medium |
| 19 | Automatic merge but logical regression | Text merged cleanly | SQL/config | Git cannot know logic | Run checks | Medium |
| 20 | Conflict markers left in SQL | Bad resolution | SQL | File invalid | Search markers | High |
| 21 | Clean merge followed by validation | Good habit | any | Merge not final proof | Run checks | Low |
| 22 | Branch created from wrong base | Wrong starting point | many files | Unexpected diff | Inspect graph | High |
| 23 | No-branch-needed tiny local exploration | Quick read-only check | none | No commit needed | Status clean | Low |
| 24 | Remote review future concept | Collaboration later | branch work | Out of scope today | Local review first | Medium |
