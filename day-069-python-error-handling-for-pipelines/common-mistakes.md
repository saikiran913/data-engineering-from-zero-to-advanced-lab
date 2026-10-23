# Common Error-Handling Mistakes

| # | What went wrong | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Catching everything silently | Hides failure | Catch specific types; report outcome |
| 2 | Retrying an invalid amount | Same data stays invalid | REVIEW/FAIL with reason |
| 3 | Retrying missing config | Repetition cannot supply it | Fail fast |
| 4 | Treating a code bug as transient | Masks defect | Surface and fix code |
| 5 | Unbounded `while True` | May never stop | Enforce positive max attempts |
| 6 | Allowing zero max attempts | Operation never runs ambiguously | Validate `>= 1` |
| 7 | Calling three retries “three attempts” | Off-by-one behavior | Include initial call in max attempts |
| 8 | Delaying after final failure | No next attempt exists | Stop and report exhausted |
| 9 | Retrying after success | Duplicate work | Return immediately |
| 10 | Retrying unsafe side effects | May duplicate output | Verify idempotency/protection |
| 11 | Appending on each attempt | Duplicate entries | Isolate repeat-safe part |
| 12 | Claiming toy code proves exactly-once | Real outcomes can be unknown | Treat it as an illustration only |
| 13 | Ignoring unknown outcome after timeout | Earlier effect may have happened | Do not blindly replay writes |
| 14 | Logging secrets | Leaks sensitive values | Log safe stage/reason only |
| 15 | Logging each invalid record | Noisy and risky | Summarize counts |
| 16 | Treating a log as recovery | Log does not handle error | Return, raise, or retry explicitly |
| 17 | Logging and re-raising at every layer | Duplicate diagnostics | One owning boundary logs |
| 18 | Raising `ValueError("bad")` | No actionable context | Name field and rule |
| 19 | Broad `try` around whole pipeline | Wrong failure may be caught | Narrow the risky call |
| 20 | Converting unexpected error to PASS | False success | Propagate unexpected failure |
| 21 | Discarding REVIEW result | Row disappears | Retain result and reason |
| 22 | Calling partial run SUCCESS | Misleads downstream users | Report PARTIAL |
| 23 | Omitting failed-row totals | Cannot reconcile | Count PASS/REVIEW/FAIL |
| 24 | Catching wrong exception type | Unexpected failure is hidden or uncaught | Catch exact known type |
| 25 | Inventing required fallback | Masks broken config | Fail fast |
| 26 | Retrying entire job for one stage | Duplicates unrelated work | Retry safe narrow stage |
| 27 | Computing backoff after attempt 3 of 3 | Wait with no next call | Delay only between attempts |
| 28 | Real sleeping in a beginner demo | Slow, nondeterministic run | Compute delay without waiting |
| 29 | No owner for error policy | Helpers make inconsistent decisions | Define row/stage/run boundaries |
| 30 | Undocumented abort threshold | Surprising partial/failed status | State threshold in contract |
| 31 | Hidden mutable attempt counter | Hard to verify attempts | Expose count in result/test |
| 32 | Random simulator fault | Results vary each run | Use fixed failure count |
| 33 | Retrying every exception | Programmer errors get repeated | Catch only transient exception |
| 34 | Logging COMPLETE after exhaustion | False final state | Report FAILED |
| 35 | Missing record reason | Review cannot act | Keep safe reason in result |
| 36 | Using a record ID as a secret in logs | Can expose private data | Keep only synthetic/safe identifiers |

The correct policy depends on the documented stage contract. The scripts make those contracts explicit so an observed error leads to a predictable decision.
