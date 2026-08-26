# Common Transaction Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | Assuming autocommit is disabled | Tool behaviour may differ | Changes may commit immediately | Verify platform settings |
| 2 | No pre-change validation | Starting state is unknown | Wrong rows may be targeted | Preview and count rows |
| 3 | No post-change validation | Result is not checked | Bad changes may be accepted | Validate before commit |
| 4 | No expected affected-row count | Target population is vague | Broad changes can slip through | Define expected rows |
| 5 | Wrong key | Filter targets wrong rows | Data becomes inconsistent | Use exact business keys |
| 6 | Broad filter | Too many rows match | Unintended changes occur | Narrow the `WHERE` condition |
| 7 | Unrelated statements together | Scope is unclear | One failure blocks unrelated work | Keep scope focused |
| 8 | Commit before validation | Bad results may become accepted | Recovery is harder | Validate first |
| 9 | Rollback assumed after commit | Rollback usually helps before commit | False safety | Understand transaction scope |
| 10 | Rollback treated as backup | It is not recovery planning | Committed errors need other controls | Keep backups and audit history |
| 11 | Atomicity treated as correctness | Wrong logic can commit atomically | Data can still be wrong | Validate business logic |
| 12 | Transaction scope too broad | Too much work grouped together | Operational risk grows | Split unrelated work |
| 13 | Transaction open too long | Resources and users may be affected | Concurrency risk grows | Keep transactions focused |
| 14 | Platform syntax assumed universal | SQL platforms differ | Syntax may fail | Verify platform behaviour |
| 15 | Behaviour assumed universal | Isolation and support differ | Results can surprise learners | Read platform docs |
| 16 | Write examples left executable | Learners may modify data | Unsafe repository | Comment conceptual writes |
| 17 | No control total | Totals cannot be checked | Unintended movement may hide | Capture before and after totals |
| 18 | No unchanged-row check | Extra changes may hide | Side effects are missed | Compare unrelated rows |
| 19 | No failure path | Team does not know when to rollback | Decisions are rushed | Define rollback conditions |
| 20 | No audit evidence | Review cannot be traced | Accountability is weak | Record validation evidence |
| 21 | No business rule | Change purpose is unclear | Wrong logic may pass syntax | Define purpose first |
| 22 | No duplicate-key check | Target keys may not be unique | More rows change than expected | Check key uniqueness |
| 23 | Transactions for read-only work unnecessarily | Complexity adds little value | Mental overhead increases | Use simple SELECTs |
| 24 | Assuming every pipeline supports transactions equally | Pipeline systems differ | Design may be unsafe | Validate platform capability |

