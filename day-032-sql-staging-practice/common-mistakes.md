# Common Day 032 Staging Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|
| 1. No source row count | The workflow starts transforming without counting input rows | Row loss may go unnoticed | Count source rows first | Compare source and standardised counts |
| 2. Standardising after complex logic | Raw values are used before mapping | Business rules may use inconsistent meanings | Map raw values first | Check mapping coverage |
| 3. Losing raw status | Only the standard status remains | Troubleshooting becomes harder | Keep `raw_status` and `standard_status` | Inspect both columns |
| 4. Losing source file | Audit context disappears | Source issues cannot be traced | Preserve `source_file` | Check missing audit columns |
| 5. Losing received timestamp | Load timing becomes invisible | Late-arriving data is hard to explain | Preserve `received_at` | Check date coverage |
| 6. Deduplication rule undocumented | The chosen row looks arbitrary | Downstream users cannot trust the logic | Document key and ordering rule | Review ranking query |
| 7. Latest received chosen blindly | Load timestamp may not equal business event timestamp | A late file can overwrite a newer event | Compare event and received timestamps | Inspect late-arriving records |
| 8. Same-timestamp tie ignored | Two records may be equally latest | The chosen candidate may be unstable | Add tie review or tie-breaker | Count same-timestamp ties |
| 9. Accepted rows have null keys | Invalid records move forward | Clean layer cannot guarantee uniqueness | Send null keys to review | Null-key check |
| 10. Negative amount accepted silently | Invalid or special business case is unclear | Reporting totals may be wrong | Review or document negative amounts | Amount check |
| 11. Zero amount accepted without context | Zero may be valid or suspicious | Business meaning is ambiguous | Flag zero amount for review when needed | Zero-amount check |
| 12. Unsupported status accepted | Unknown source values reach reporting | Reporting categories become unreliable | Use mapping support flags | Unsupported-status check |
| 13. Review rows removed silently | Problems disappear from visibility | Investigation becomes impossible | Preserve a review queue | Count review reasons |
| 14. Audit columns dropped | Rows cannot be traced to source | Debugging slows down | Carry source event and file fields | Audit presence check |
| 15. Stage grain undocumented | Nobody knows what one row means | Counts become misleading | Write input and output grain | Grain review |
| 16. Clean grain not unique | Clean output has duplicate business keys | Reporting may double count | Validate clean key uniqueness | `GROUP BY order_id HAVING COUNT(*) > 1` |
| 17. Reporting grain not unique | Reports have duplicate date and group rows | Dashboards may double count | Validate report keys | Duplicate reporting-grain check |
| 18. Totals not reconciled | Aggregates are trusted without checks | Financial or operational totals may be wrong | Compare clean totals to reporting totals | Total reconciliation |
| 19. Date boundaries not checked | Missing or late data is hidden | Reports may be incomplete | Check earliest and latest dates | Date coverage check |
| 20. One giant unreadable query | Every step is mixed together | Debugging is difficult | Use named CTE stages | Run each stage separately |
| 21. Too many unnecessary stages | Simple logic becomes hard to maintain | More names do not mean safer logic | Keep each stage purposeful | Stage-purpose review |
| 22. Inconsistent stage names | Names do not explain the workflow | Readers get lost | Use stable, descriptive names | Naming review |
| 23. No handoff contract | Downstream users guess the rules | Different consumers may apply different rules | Document the contract | Contract checklist |
| 24. Downstream status reinterpretation | Reporting applies a second status rule | Metrics disagree across teams | Use standard status from clean layer | Compare definitions |
| 25. No sample inspection | Only aggregate checks are reviewed | Row-level issues can be missed | Inspect sample accepted and review rows | Sample query review |
