# Beginner Summary

Day 060 showed how Python exceptions work. Day 069 asks a more operational question: when something goes wrong in a multi-stage pipeline, what should the pipeline **do**? The answer begins with classification, not with a generic `except` or an automatic retry. A malformed order amount, a missing required setting, a temporary source failure, and a programming defect are different problems.

An invalid business record often belongs in a validation result. Give it an explicit `PASS`, `REVIEW`, or `FAIL` label and a safe reason. Keep all processed rows accounted for. If the contract allows the other rows to continue, the run may finish PARTIAL. This is a **recoverable** situation: work continues while the bad row is held for review. Repeating the same row is not likely to change its value, so it is not retryable.

A required global setting or unusable schema should usually fail fast before processing records. The source identity cannot be fabricated just to keep the run green. A programming bug should surface so code can be corrected. A known **transient** operation fault may warrant another attempt, but only when the operation is safe to repeat. The retry loop should catch only its specific transient exception. A different error must propagate or be handled by its rightful owner.

`max_attempts` includes the first call. With a limit of three, there can be at most three total calls and two retries. Stop immediately on success; stop on a nonretryable error; report FAILED if all permitted attempts fail. A conceptual delay can increase between failed attempts and be capped, but there is no point calculating a delay after the final failure. The scripts print delay values without sleeping.

Retries can repeat side effects. A pure calculation can be repeated without changing state, but an append performed twice leaves two entries. In a real system, a timeout may leave the first operation's outcome unknown. An in-memory demonstration cannot prove exactly-once delivery for a remote write. Before a real operation is retried, its idempotency or duplicate protection must be established. This lesson makes no actual external calls or file writes.

Keep error ownership clear. A parser can raise a useful `ValueError`, a row processor can classify it, a stage controller can decide continue/abort/retry, and the top-level run can report the final status. Bare `raise` inside an `except` block preserves an exception when the current layer cannot handle it. Safe logging from Day 067 can include run ID, stage, attempt and counts; it helps diagnosis but never fixes an exception. Avoid logging raw rows, secrets, or the same error at every layer.

> Retry only failures that are reasonably transient and safe to repeat. Invalid data, missing required configuration, and code defects generally need correction—not repeated attempts.

> Every retry policy must have a clear maximum attempt count and a stopping condition. Never create unbounded retry loops.

> A retry can repeat side effects. Before retrying writes or external operations, verify that the operation is idempotent or protected against duplicate effects.

> Catch exceptions at the level where you can make a meaningful decision. Do not silently swallow failures or log an error and then claim the pipeline succeeded.

Before moving on, reconcile `PASS + REVIEW + FAIL` with processed rows and distinguish that record-level equation from the run-level `SUCCESS`, `PARTIAL`, or `FAILED` outcome. The provisional preview is **Day 070 — Python Testing Fundamentals: Assertions, unittest, and Pipeline Validation Checks**; the exact next lesson may change when it is planned.
