# Common Schema Validation Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | No expected schema | There is nothing to compare against | Drift cannot be judged | Document the contract |
| 2 | Only inspecting observed columns | Missing columns are invisible | Required removals may be missed | Compare expected to observed |
| 3 | No required/optional distinction | All columns look equally important | Severity becomes unclear | Add `required_flag` |
| 4 | Treating every extra column as failure | Additive changes may be intentional | Valid changes may be blocked | Mark as review first |
| 5 | Ignoring unexpected columns | New fields may affect consumers | `SELECT *` users may break | Review and document additions |
| 6 | Assuming a rename automatically | Similar names may not mean same meaning | Incorrect mapping can spread | Use possible-rename review |
| 7 | Ignoring removed columns | Downstream SQL may fail | Consumers lose expected fields | Flag removed required columns |
| 8 | Assuming type change is safe | Consumers may calculate or filter differently | Reports may change silently | Review type compatibility |
| 9 | Comparing raw type strings only | Platform labels can differ | False mismatches may appear | Normalise types conceptually |
| 10 | Confusing nullability and null values | Metadata is not row-level quality | Completeness checks are separate | Validate both separately |
| 11 | Relying on column order | Position changes can mislead exports | Fragile consumers break | Use explicit column names |
| 12 | Ignoring position-sensitive exports | Some files still depend on order | Fixed extracts can change shape | Review observed positions |
| 13 | Ignoring semantic drift | Same name and type may hide meaning changes | Reports may be wrong | Include business review |
| 14 | Ignoring consumer impact | Drift is found but no user is reviewed | Breakage reaches reports | Maintain consumer catalog |
| 15 | No severity labels | Review queue has no priority | Work is harder to triage | Assign documented severity |
| 16 | Vague review messages | Reviewers do not know next steps | Investigation slows down | Write clear messages |
| 17 | Mixing validation with migration | The check changes objects | Review becomes unsafe | Keep SQL read-only |
| 18 | Using DDL examples as practice | Learners may run structural changes | Public lesson becomes risky | Use SELECT-only examples |
| 19 | Ignoring schema versions | Changes cannot be traced | Drift history is unclear | Include observed version |
| 20 | No rule catalog | Logic becomes inconsistent | Severity and category drift | Document validation rules |
| 21 | No exception output | Findings are scattered | Review is harder | Create schema exceptions |
| 22 | No summary | Volume and priority are unclear | Teams cannot plan review | Summarise by category and severity |
| 23 | Forgetting key columns | Business grain may break | Joins and grouping can fail | Identify key roles |
| 24 | Assuming schema match means data quality | Values may still be wrong | False confidence appears | Run row-level validation too |
| 25 | Treating optional as unused | Optional columns can still have consumers | Reports may depend on them | Review consumer usage |

