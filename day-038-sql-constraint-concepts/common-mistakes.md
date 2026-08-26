# Common Constraint Validation Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | Assuming every ID is a primary key | Some IDs may not identify the table grain | Wrong key checks | Document grain first |
| 2 | Checking uniqueness without nulls | Null keys may be missed | Key rule is incomplete | Check nulls and duplicates |
| 3 | Checking nulls without uniqueness | Duplicate keys may be missed | Row identity is not protected | Run duplicate checks |
| 4 | Wrong key grain | Key does not match one row | False validation | Define table grain |
| 5 | Incorrect composite key | Missing part of the key | Duplicates may hide | Group by all key columns |
| 6 | Foreign key checked with inner join only | Orphans disappear | Violations are hidden | Use left join from child |
| 7 | Parent duplicates ignored | Parent key is not stable | Relationship check is weaker | Validate parent key first |
| 8 | Orphans deleted automatically | Evidence is lost | Business review is skipped | Report orphan rows |
| 9 | Unique confused with primary key | Unique rules may be separate | Requiredness may differ | Explain the concept |
| 10 | UNIQUE null behaviour assumed universal | Databases differ | Bad portability | Avoid universal claims |
| 11 | Check rule not documented | Rule may be arbitrary | Reviewers cannot trust it | Document business logic |
| 12 | Range rule universalised | Some negatives may be valid | False defects | Use lesson-specific rules |
| 13 | Status list incomplete | Valid statuses may be flagged | Bad exceptions | Confirm allowed list |
| 14 | NOT NULL applied to optional field | Optional data is over-constrained | False failures | Use business requiredness |
| 15 | Blank string confused with null | Blank and null may differ | Missing values may hide | Check both when needed |
| 16 | Declared constraint assumed enforced | Some systems may not enforce | False confidence | Run validation queries |
| 17 | Warehouse enforcement assumptions | Platforms differ | Portability issues | Add platform caveat |
| 18 | Business key confused with surrogate key | Identity is misunderstood | Wrong joins | Document key role |
| 19 | No exception output | Violations are scattered | Review is hard | Build a queue |
| 20 | No audit context | Source cannot be traced | Investigation slows down | Include file and load time |
| 21 | No severity rule | Priority is unclear | Review is harder | Assign documented severity |
| 22 | Cross-table rule treated as simple CHECK | Relationship logic is different | Wrong validation design | Use relationship checks |
| 23 | Non-portable composite distinct syntax | Syntax varies | Queries may fail | Use grouped duplicate checks |
| 24 | Destructive DDL used in validation lesson | It changes objects | Unsafe learning | Keep SQL read-only |
| 25 | No grain documentation | Key choice is unclear | Validation may be wrong | State grain in comments |

