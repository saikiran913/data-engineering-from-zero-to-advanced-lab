# Common Pipeline Validation Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|
| 1. Relying only on row count | Counts can match while values differ | False confidence | Add keys, totals, and completeness checks | Compare control totals |
| 2. Comparing different grains | Source events are compared directly to report rows | Counts become meaningless | Define grain first | Write source and target grain |
| 3. No expected-difference rule | Any difference is treated as failure | Valid business rules look broken | Document expected exclusions | Review stage rules |
| 4. No distinct-key check | Duplicate keys can hide inside row counts | Clean output may double count | Count distinct keys | Row count versus distinct key |
| 5. No duplicate check | Grain violations go unnoticed | Reports may be inflated | Use `GROUP BY` and `HAVING` | Duplicate-key query |
| 6. No numeric control totals | Amount changes may be missed | Metrics can be wrong | Compare sums and counts | Control-total query |
| 7. No grouped reconciliation | Grand totals can hide group issues | One group may be missing | Reconcile by date and group | Grouped totals |
| 8. No date coverage | Missing reporting dates remain hidden | Reports become incomplete | Check min, max, and expected dates | Date completeness |
| 9. No category coverage | Missing statuses or groups are missed | Metrics omit categories | Count categories | Category coverage |
| 10. No file coverage | Missing source files are missed | Entire inputs may be absent | Compare expected and received files | File completeness |
| 11. Treating all nulls as failures | Some nulls may be allowed | Rules become too strict | Decide by business meaning | Null completeness by column |
| 12. Ignoring target-only rows | Target may contain unexplained records | Trust is reduced | Run target-only key checks | Left join from target |
| 13. Ignoring source-only rows | Missing target rows are not reviewed | Data loss may be hidden | Run source-only key checks | Left join from source |
| 14. Arbitrary tolerance | SQL guesses business risk | Results become subjective | Document tolerance rules | Rule catalogue |
| 15. Hiding exceptions in totals | Aggregate checks do not show records | Investigation is hard | Produce exception rows | Exception report |
| 16. Trusting a zero-row query blindly | The query may be wrong | False pass | Inspect query logic and samples | Debugging lab |
| 17. Incomplete source population | Validation starts from the wrong input | Results are misleading | Define filters and population | Source population check |
| 18. Different date ranges | Source and target windows differ | Reconciliation fails unfairly | Align date filters | Date coverage check |
| 19. No evidence retained | Review cannot reproduce the result | Auditability suffers | Keep summary and exceptions | Validation summary |
| 20. Automatic correction | Data is changed without investigation | Source truth may be damaged | Send failures to review | Exception queue |
