# Common Exception Reporting Mistakes

| # | Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|---|
| 1 | No exception level | The row does not say whether it is record, metric, or stage level | Reviewers cannot understand the grain | Add `exception_level` | Check all rows have a level |
| 2 | No stage name | The failed pipeline step is hidden | Ownership is unclear | Add `stage_name` such as `SOURCE`, `CLEAN`, or `REPORTING` | Summarise by stage |
| 3 | No entity key | The affected item cannot be located | Review work slows down | Add an order, group, metric, or file key | Check null entity keys |
| 4 | Vague issue category | Labels like `bad data` are too broad | Summaries become weak | Use controlled categories | Compare to the rule catalog |
| 5 | Vague issue type | The exact rule is unclear | Different issues get mixed together | Use specific issue types | Count by issue type |
| 6 | No expected value | The rule expectation is hidden | The exception is hard to judge | Add `expected_value` | Review null expected values |
| 7 | No actual value | The observed result is missing | Reviewer must rerun queries | Add `actual_value` | Review null actual values where evidence is expected |
| 8 | Wrong difference direction | Difference is calculated backward | Reviewers may misread impact | Document `actual - expected` or `expected - actual` | Compare sample calculations |
| 9 | No severity rule | Priority is personal opinion | Queue ordering is not trusted | Define severity in the rule catalog | Check severity values against rules |
| 10 | Too many severity levels | The queue has too many priorities | Review becomes confusing | Start with `HIGH_REVIEW`, `REVIEW`, and `INFO` | Count distinct severity labels |
| 11 | Random severity | Similar issues receive different severity | Reviewers lose confidence | Assign severity by issue type and impact | Compare same issue types |
| 12 | No audit context | Source lineage is missing | Investigation needs extra lookup | Include source file, date, batch, or stage | Check audit columns |
| 13 | No source file | File-based issues cannot be traced | Late or duplicate files are harder to find | Add `source_file` when available | Count missing source-file values |
| 14 | Poor review message | The next action is vague | The queue becomes a mystery list | Write a clear investigation note | Review messages manually |
| 15 | Inconsistent queue columns | `UNION ALL` branches return different meanings | Combined rows become misleading | Align column names, order, and types | Inspect every branch output |
| 16 | Incompatible `UNION ALL` types | Text, dates, and numbers are mixed carelessly | Some platforms error or convert unexpectedly | Cast evidence columns consistently | Run a small sample first |
| 17 | Using `UNION` to hide duplicates | Exact duplicate exceptions disappear | Rule overlap can be hidden | Use `UNION ALL` for review queues | Run duplicate-exception checks |
| 18 | Deduplicating different issue types together | One record with multiple issues is collapsed | Real issues are lost | Keep one row per issue type | Include issue type in duplicate checks |
| 19 | Duplicate exception rows | Same issue appears more than once | Queue counts are inflated | Define a duplicate-exception key | Count by level, stage, key, category, and type |
| 20 | Mixed grain without labels | Record and metric rows look the same | Summaries are misleading | Always include `exception_level` | Summarise by level |
| 21 | Exception rows counted as affected records | One order with two issues is counted twice | Impact is overstated | Explain row count versus affected-record count | Compare issue rows and entity keys |
| 22 | Expected exception treated as confirmed defect | Known exceptions are escalated unnecessarily | Review effort is wasted | Use documented expected-exception status | Compare to expected exception notes |
| 23 | Automatic remediation logic | The report tries to fix data | Validation loses its read-only purpose | Keep exception SQL as SELECT-only | Scan for DDL and DML |
| 24 | No exception summary | Detail rows exist but priority is unclear | Teams cannot plan review work | Add summaries by severity and category | Count issue rows by summary dimension |
| 25 | No investigation evidence | The row says something failed but not why | Reviewer must rebuild context | Include expected, actual, difference, and source context | Spot-check high-review rows |
| 26 | No review ownership concept | No one knows who should investigate | Exceptions sit unresolved | Include owner role in rule design notes | Review the rule catalog |

## Beginner Reminder

An exception report should be clear enough that a reviewer can answer three questions quickly:

1. What failed?
2. Which entity is affected?
3. What evidence should be checked next?

If the output cannot answer those questions, the exception report needs more context.
