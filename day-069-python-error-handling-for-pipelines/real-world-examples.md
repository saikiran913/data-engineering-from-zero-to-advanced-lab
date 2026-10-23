# Real-World Error-Handling Examples

These generic situations use synthetic labels only. The report column names what an operator or caller should learn; it does not imply a real service is contacted.

| # | Scenario | Classification | Action | Why | Report |
|---|---|---|---|---|---|
| 1 | Amount is text | Data validation | REVIEW | Same value will not self-correct | Reason and review count |
| 2 | Required amount missing on one row | Permanent row input | FAIL | Isolatable row | Missing-field count |
| 3 | Optional note missing | Allowed data | CONTINUE | Contract permits it | PASS count |
| 4 | Status outside allowed set | Data validation | REVIEW | Needs clarification | Unsupported-status count |
| 5 | Date cannot be parsed | Data validation | REVIEW | Repeating parse will not help | Invalid-date count |
| 6 | Required source name absent | Configuration | FAIL | Global run cannot start | FAILED before processing |
| 7 | Global schema mismatches contract | Permanent stage input | FAIL | All rows may be misread | Stage and reason |
| 8 | Empty input unexpectedly arrives | Stage/input policy | FAIL or REVIEW | Contract decides if empty is allowed | Zero count and run status |
| 9 | Simulated timeout once | Transient technical | RETRY | Could clear safely | Attempt and final outcome |
| 10 | Intermittent source fault concept | Transient technical | RETRY only if safe | Repetition may recover | Bounded attempt count |
| 11 | Source stays unavailable | Persistent stage failure | FAIL after bound | No more attempts | Exhausted attempts |
| 12 | Unexpected `TypeError` from code | Programming | FAIL | Needs code fix | Safe exception context |
| 13 | One row flagged for review | Recoverable record | REVIEW | Other rows can proceed | PARTIAL and reason |
| 14 | Critical required stage fails | Stage failure | FAIL | Cannot produce result | FAILED, stage |
| 15 | Partial load concept | Unknown side effect | FAIL or reconcile | Replaying may duplicate | Explicit partial/unknown state |
| 16 | Append repeated on retry | Non-idempotent effect | FAIL/reassess | Duplicates entries | Effect count in toy demo |
| 17 | Three transient calls fail | Retry exhausted | FAIL | Limit reached | attempts=3 |
| 18 | Attempt 1 fails, 2 succeeds | Transient recovery | CONTINUE | Safe repeat worked | attempts=2, retries=1 |
| 19 | First call succeeds | Normal | CONTINUE | No retry needed | attempts=1 |
| 20 | Several runs interleave | Diagnostic context | CONTINUE | Need correlation | Safe run ID |
| 21 | Stage raises expected transient | Retryable stage | RETRY | Handler owns stage | Stage label, attempt |
| 22 | Same exception logged twice | Diagnostic duplication | CONTINUE/FAIL per original | Logs are misleading | One owned log |
| 23 | Backoff after failure 1 | Retry policy | RETRY | Avoid immediate repeat | Computed delay, no sleep here |
| 24 | Output replay after timeout | Idempotency risk | FAIL/reconcile | First outcome may be unknown | Explicit risk |
| 25 | Fail count exceeds allowed threshold | Policy failure | FAIL | Contract requires abort | Threshold and count |
| 26 | All rows pass | Complete result | CONTINUE | No partial outcome | SUCCESS and totals |
| 27 | Some rows reviewed | Partial result | CONTINUE with review | Work completed partly | PARTIAL and totals |
| 28 | Invalid global config before source | Configuration | FAIL | Retrying source cannot help | FAILED, zero processed |
| 29 | A row has zero amount under review rule | Business rule | REVIEW | Needs business decision | Review count |
| 30 | Result counts disagree | Programming/logic | FAIL | Cannot trust summary | FAILED and safe stage context |

No row above authorizes blind retries of writes or external actions. A stage's safety and failure policy must be documented before repetition.
