# Common Completeness Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|
| No expected population | The query does not define what should exist | Gaps cannot be judged | Use an expectation list | Expected-record check |
| No required-field definition | Requiredness is assumed | Nulls may be mislabelled | Document required fields | Rule catalogue |
| Treating all nulls as errors | Some fields may be optional | False failures | Decide by business rule | Required-field check |
| Ignoring blank strings | Blank text may bypass null checks | Missing values remain hidden | Check null and blank values | Blank check |
| Comparing different grains | Source rows and report rows differ | Counts mislead | Align grain | Grain review |
| Duplicate expected records | Expected count is inflated | Percentages are wrong | Deduplicate expectations | Duplicate expectation check |
| Duplicate actual records | Coverage appears higher than reality | Percentages inflate | Use distinct keys | Distinct-key check |
| No key completeness check | Missing business records are hidden | Data loss may pass | Compare expected keys | Missing-key check |
| Min/max dates only | Middle dates can be missing | Date gaps are missed | Check listed dates | Expected-date check |
| No category coverage | Missing groups are hidden | Reports incomplete | Check expected groups | Category coverage |
| No status coverage | Status changes are missed | Rules may break | Check expected statuses | Status coverage |
| No source-file coverage | Missing files are missed | Whole input can be absent | Check expected files | File coverage |
| Percentage without issue list | Summary lacks evidence | Review is hard | Keep exceptions | Exception report |
| Divide-by-zero | Empty expected population breaks logic | Query may fail | Use `CASE` denominator guard | Percentage check |
| Expected exclusions treated as missing | Valid filters look broken | False alarms | Document exclusions | Rule review |
| Unexplained gaps accepted | Real issues pass through | Trust suffers | Send to review | Summary status |
| Unexpected extra records ignored | Target-only records remain hidden | Bad data can enter output | Check target-only keys | Extra-record check |
| Generating missing rows | Completeness check fabricates data | Source truth is damaged | Report gaps only | Read-only workflow |
| No exception evidence | Review cannot reproduce issue | Investigation slows | Preserve entity keys | Exception queue |
| No review ownership | Nobody follows up | Issues linger | Assign review role conceptually | Rule design |
