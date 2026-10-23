# Build a Safe, Bounded Error-Recovery Flow for Python Pipelines

From `day-069-python-error-handling-for-pipelines/`, check `python --version` (or `py --version` on Windows) for Python 3.10 or newer. All examples are deterministic, synthetic, standard-library-only, in memory, and make no real calls or waits.

```bash
python scripts/01_clear_errors_and_exceptions.py
python scripts/02_fail_fast_vs_continue.py
python scripts/03_recoverable_record_errors.py
python scripts/04_bounded_retry_simulation.py
python scripts/05_retry_safety_and_backoff.py
python scripts/06_data_engineering_recovery_workflow.py
```

| Script | Observe | Check your reasoning |
|---|---|---|
| 01 | A caught `ValueError`, a REVIEW result, and a bare re-raise caught by caller | Which layer owns the decision? |
| 02 | Blank global config fails; isolated rows continue | Why is the second run PARTIAL? |
| 03 | Six in-memory outcomes and reasons | Verify PASS 2 + REVIEW 3 + FAIL 1 = 6 |
| 04 | Success on attempt 2, exhaustion at 3, permanent error after 1 | Which errors did the retry loop catch? |
| 05 | Computed delays 2, 3, then none; append count 2 | Why is there no wait after attempt 3? |
| 06 | Transient source recovers; two invalid rows are classified | Verify PASS 2 + REVIEW 1 + FAIL 1 = 4 and retries=1 |

## Try Small Changes

1. In script 04, set the exhausted simulator's `failures_before_success` to 2. Predict its success attempt before running; restore 3 afterward.
2. In script 04, try `max_attempts=1` in the success case. Catch the expected `TransientOperationError` at the caller so the script still exits cleanly; restore 3 afterward.
3. In script 05, calculate delays for base 1 and cap 2 without adding `sleep()`.
4. In script 06, change the simulated failure count to 3 and catch exhaustion at the existing top-level boundary. Do not claim COMPLETE after failure; restore 1 afterward.
5. Explain why a missing amount is a row-level FAIL but a missing `source_name` is a run-level FAILED.

No real endpoint, database, queue, file, credential, random fault, or actual pause is needed. Avoid adding side effects to the retry simulator. A safe in-memory counter is enough to see the retry risk.

## Completion Check

- I can name the exact exception type a retry loop catches.
- I can distinguish attempt count from retry count.
- I can stop on success, exhaustion, and nonretryable failure.
- I can explain why duplicate appends make retries unsafe.
- I can report a partial run with reconciled record outcomes.
