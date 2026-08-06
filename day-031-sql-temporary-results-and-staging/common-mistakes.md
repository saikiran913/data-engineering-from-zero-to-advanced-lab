# Common Mistakes

| # | Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|---|
| 1 | Staging without purpose | Stage exists but does not clarify work | Adds confusion | Define stage purpose | Purpose review |
| 2 | Copying raw data without documentation | Stage becomes raw clone | Trust is unclear | Document rules | Handoff checklist |
| 3 | Losing audit columns | Lineage disappears | Issues are harder to investigate | Preserve audit fields | Audit check |
| 4 | Silently removing suspicious rows | Review records vanish | Data issues are hidden | Create review output | Review count |
| 5 | No stage grain | Row meaning is unclear | Counts cannot be trusted | Define grain | Key check |
| 6 | No business key | Duplicate checks are weak | Grain breaks silently | Define key | Duplicate check |
| 7 | No accepted/review split | All rows look equal | Bad rows continue | Classify rows | Status count |
| 8 | No validation checkpoint | Handoff is untested | Errors move downstream | Add checkpoint | Summary query |
| 9 | Rules too early | Source detail is hidden | Investigation becomes harder | Preserve raw first | Audit review |
| 10 | Rules too late | Bad rows affect calculations | Reporting can be wrong | Validate before aggregation | Review queue |
| 11 | Aggregating before deduplication | Totals inflate | Duplicate rows counted | Deduplicate first | Key check |
| 12 | Joining before standardisation | Join mismatch | Rows disappear or multiply | Standardise keys first | Join count |
| 13 | Row multiplication | Extra rows between stages | Totals inflate | Validate grain | Duplicate-key check |
| 14 | Comparing different grains | Counts do not align | False alarms occur | Compare aligned grain | Grain notes |
| 15 | No total reconciliation | Amount changes unnoticed | Reports drift | Reconcile totals | SUM check |
| 16 | Vague names | Purpose hidden | Maintenance harder | Use clear names | Name review |
| 17 | Too many tiny stages | Workflow noisy | Debugging slows | Combine trivial steps | Stage review |
| 18 | One giant stage | Logic unreadable | Errors hide | Split meaningful steps | CTE review |
| 19 | Assuming staged data is clean | Stage may still contain issues | Bad handoff | Validate stage | Accepted check |
| 20 | Clean data is assumed reporting-ready | Aggregation can still fail | Reports mislead | Validate reporting grain | Reporting check |
| 21 | No handoff definition | Next step unclear | Ownership gaps | Define contract | Handoff review |
| 22 | No ownership or lifecycle thinking | Stage becomes unmanaged | Long-term confusion | Document owner | Design guide |
| 23 | Platform-specific temp syntax without notes | Portability suffers | Learners get confused | Keep conceptual | Platform note |
| 24 | Confusing temporary result with staging table | Persistence misunderstood | Wrong design choice | Explain differences | Method comparison |
