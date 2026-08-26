# Day 039 Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Atomic change | Related changes treated as one unit | decrease one balance and increase another |
| Atomicity | All-or-nothing transaction thinking | both steps succeed or neither is accepted |
| Autocommit | Automatic commit of individual statements | tool commits each update separately |
| Before state | Data before a conceptual change | account balances before transfer |
| Begin transaction | Conceptual start of a transaction | start controlled work |
| Commit | Accept uncommitted changes | make validated changes accepted |
| Commit condition | Evidence required before commit | totals match and row count is correct |
| Consistency | Related data remains aligned | balances still reconcile |
| Control total | Summary used to catch unintended changes | total account balance |
| Expected affected rows | Planned number of rows to change | exactly two accounts |
| Expected after state | Planned result after a change | expected balances after transfer |
| Failure path | Planned response when checks fail | rollback thinking |
| Multi-step change | Change needing more than one step | update status and review flag |
| Partial change | Some related steps happen but not all | source decreases but target not increased |
| Post-change validation | Checks after conceptual change | compare expected after totals |
| Pre-change validation | Checks before change | confirm target keys exist |
| Read-only validation | SELECT-based checks only | before/after comparison query |
| Rollback | Abandon uncommitted changes within supported scope | undo before commit conceptually |
| Rollback condition | Situation where rollback is needed | unexpected affected rows |
| Safe change | Planned and validated change | exact keys and checks documented |
| Transaction | Logical unit of database work | related status updates |
| Transaction boundary | Start and end of controlled work | begin, validate, commit or rollback |
| Transaction review | Evidence gathered before acceptance | row counts and totals |
| Transaction scope | Work included in transaction | two related rows only |
| Uncommitted change | Change not yet accepted | pending update before commit |
| Validation checkpoint | Evidence check before moving on | target row count check |

