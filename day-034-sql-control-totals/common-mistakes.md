# Common Control-Total Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|
| 1. No population definition | The query does not say what rows are included | Results are ambiguous | Define source and target population | Add comments and filters |
| 2. No grain definition | Row meaning is unclear | Counts can mislead | State source and target grain | Grain review |
| 3. Mismatched filters | Source and target measure different populations | Differences are unfair | Align filters | Filter review |
| 4. Mismatched date ranges | Time windows differ | Totals fail incorrectly | Align date ranges | Boundary checks |
| 5. Wrong count function | `COUNT(column)` excludes nulls | Null rows may disappear | Use `COUNT(*)` when counting rows | Null count comparison |
| 6. No distinct-key check | Duplicates are hidden | Clean grain may be broken | Compare row count and distinct count | Duplicate check |
| 7. No sum control | Amount changes are missed | Financial-style metrics may be wrong | Add `SUM` controls | Amount reconciliation |
| 8. No boundary control | Missing or future dates are missed | Date coverage may be wrong | Add `MIN` and `MAX` | Boundary control |
| 9. No grouped control | Grand totals hide shifts | Group-level errors remain hidden | Compare by group | Grouped reconciliation |
| 10. Grand total only | Only one total is checked | Offset issues can cancel out | Add grouped totals | Date and country controls |
| 11. Nulls ignored | Null impact is not reviewed | Counts and sums can mislead | Count nulls separately | Null completeness |
| 12. Accepted/review mismatch | Stage rows are not fully explained | Rows may vanish | Reconcile accepted plus review | Stage count control |
| 13. Accepted/review overlap | Same key may appear in both groups | Business decision is unclear | Check status overlap by key | Overlap query |
| 14. Source-file ignored | File-level issues are hidden | Missing files can explain gaps | Count by source file | File control |
| 15. Wrong sign interpretation | Difference direction is misunderstood | Review conclusion may be wrong | Use target minus source consistently | Difference review |
| 16. Arbitrary tolerance | Threshold is guessed | Business risk is hidden | Document approved tolerance | Rule catalogue |
| 17. Expected difference treated as failure | Valid rules look broken | Learners lose trust in controls | Document expected difference | Casebook review |
| 18. Unexplained difference accepted | Real issue is ignored | Downstream trust suffers | Send to review | Exception evidence |
| 19. Grouped dimensions misaligned | Groups do not match | Reconciliation is invalid | Use same group columns | Grouped check |
| 20. Reporting count compared to clean count | Aggregated row counts differ naturally | False failure | Compare reporting totals to clean totals | Clean-reporting control |
| 21. Duplicate reporting grain ignored | Reports can double count | Metrics inflate | Check composite key | Reporting grain check |
| 22. Wrong status filter | Completed metric includes wrong rows | Totals are wrong | Align status filters | Status filter review |
| 23. No control evidence | Result cannot be reviewed | Investigation is weak | Save summary and detail queries | Summary output |
| 24. Automatic correction | Data is modified without review | Source truth may be damaged | Keep checks read-only | Review workflow |
