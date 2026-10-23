# Troubleshooting Pipeline Recovery

| Symptom | Inspect | Corrective direction |
|---|---|---|
| Infinite retry loop | Is there an enforced positive limit? | Use `range(1, max_attempts + 1)` |
| Retry never occurs | Is expected transient type caught? | Catch specific known type |
| Permanent error retried | Catch too broad? | Let nonretryable type propagate |
| Success after retry reported FAILED | Did code return immediately on success? | Return result and attempt |
| Exhaustion reported SUCCESS | Is final exception swallowed? | Report FAILED |
| Off-by-one attempt count | Does first call count? | Include initial call in limit |
| Real delay slows demonstration | `sleep()` added? | Calculate only |
| Traceback disappears | Exception translated without cause or swallowed? | Use `raise ... from exc` or bare `raise` |
| Cause/context missing | Vague message? | Name safe field, stage, rule |
| PARTIAL called SUCCESS | Row outcomes omitted? | Reconcile and derive run status |
| Raw row silently skipped | No result per record? | Return REVIEW/FAIL with reason |
| Duplicate logger messages | Multiple handlers or layered logs? | Configure once; one owner logs |
| Retry repeats side effect | Mutable output changes per call? | Do not repeat until idempotency/protection established |
| `raise` used outside proper scope | Bare re-raise without active handler? | Use it only inside `except` |
| Unexpected exception swallowed | Broad catch returns default? | Propagate or explicitly fail |
| Counts mismatch | A record got zero or multiple outcomes? | Count each processed row once |
| Final stage marked complete after abort | Control flow continues after failure? | Stop and report FAILED |

## Diagnostic Flow

1. Identify failure scope: record, stage, or whole run.
2. Identify the exact exception or validation reason; avoid raw sensitive values.
3. Classify the failure as retryable or not under the stage contract.
4. Confirm repeating the operation is safe and side effects are understood.
5. Check positive maximum attempts and all stop conditions.
6. Inspect the actual result, attempt count, and PASS/REVIEW/FAIL totals.
7. Verify the run status and diagnostics accurately describe SUCCESS, PARTIAL, or FAILED.

An error log alone does not establish a failed or successful result. Check the returned outcomes and control flow.
