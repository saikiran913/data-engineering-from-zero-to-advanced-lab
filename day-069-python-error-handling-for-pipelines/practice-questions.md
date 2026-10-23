# Practice Questions

Use this lesson's policy: isolated invalid rows are classified, a required global setting fails fast, and only a known repeat-safe transient stage is retried. `max_attempts` includes the initial call. Try each section before consulting its aligned answer key.

## Section 1: Concepts (25)

1. Why classify a failure before reacting?
2. What is a validation outcome?
3. How can a record be recoverable but not retryable?
4. What is a transient failure?
5. What is a permanent input failure?
6. Why fail fast on missing required configuration?
7. What does `raise ValueError("amount must be numeric")` do?
8. When is bare `raise` valid?
9. What does `raise ... from exc` preserve?
10. Why catch a specific exception type?
11. What is the scope of a record processor?
12. What does a stage controller decide?
13. What does a top-level run report?
14. Name the three record outcomes.
15. Name the three run outcomes.
16. Does a logged ERROR repair a stage?
17. What does `max_attempts=3` count?
18. How many retries can three total attempts contain?
19. When should a retry loop stop?
20. Why not retry malformed input?
21. What is idempotency?
22. Why can a timeout make a retry risky in a real system?
23. When does a computed backoff delay apply?
24. Why not log every bad row?
25. What equation should record outcome counts satisfy?

## Section 2: Classify the Error (12)

Choose data validation, transient technical, permanent input, configuration, programming, or stage/resource; explain in a few words.

1. One row has `amount="invalid"`.
2. A synthetic source call fails once, then succeeds.
3. Required `source_name` is blank.
4. A function accesses the wrong variable name.
5. A whole batch lacks a required schema column.
6. One row lacks a mandatory field.
7. A simulated required source remains unavailable.
8. One row has an unsupported status.
9. A known conversion raises `ValueError` for a row.
10. A stage raises an unexpected `TypeError` from its logic.
11. An optional note field is absent by policy.
12. Three simulated transient source calls all fail.

## Section 3: Continue, Fail, or Retry? (10)

Choose CONTINUE/REVIEW, FAIL, or RETRY and say why.

1. One numeric value is malformed; other rows are valid.
2. Required global config is missing.
3. A repeat-safe synthetic source fails on its first call with a known transient error.
4. A stage raises a programming error.
5. The source fails after the final allowed attempt.
6. A valid record passes.
7. An optional note is absent under the contract.
8. A repeated append could duplicate output.
9. One row has an unsupported status and review is allowed.
10. Global schema does not match the contract.

## Section 4: Count the Attempts (10)

1. With `max_attempts=3`, what is the maximum number of calls?
2. With `max_attempts=3`, what is the maximum number of retries?
3. Failure on attempt 1 then success on 2: total calls?
4. Same sequence: retries performed?
5. Success on attempt 1: retries performed?
6. Three failures under limit 3: total calls?
7. Same exhaustion: should there be a delay after call 3?
8. Nonretryable error on first call: total calls?
9. What should happen if `max_attempts=0`?
10. With `max_attempts=4` and success on call 3, how many calls and retries?

## Section 5: Find the Unsafe Retry or Code (10)

Identify the flaw and fix.

1. `while True: try_again()` with no enforced bound.
2. `except Exception: continue` around all stages.
3. Retry a malformed amount three times.
4. Retry missing `source_name` three times.
5. Compute a delay after attempt 3 of 3.
6. Keep retrying after the operation returns success.
7. Append output before raising, then retry append.
8. Catch a programming `TypeError` as if it were transient.
9. On exhaustion, return `{"run_status": "SUCCESS"}`.
10. Log the same exception and re-raise in each helper.

## Section 6: Choose a Useful Message or Log (8)

For each pair, choose the safer and more actionable choice.

1. `"bad"` or `"amount must be numeric"`.
2. `"row=<full raw record>"` or `"stage=VALIDATE fail_count=1"`.
3. `logger.exception` outside `except` or inside a specific handler.
4. Log `"token=<value>"` or `"source stage unavailable"`.
5. Log every failed row or one validation summary.
6. `run_status=SUCCESS` after exhaustion or `run_status=FAILED attempts=3`.
7. `logger.warning("attempt=1 transient_failure")` or silent retry.
8. Log and re-raise at every layer or log once at the responsible boundary.

## Section 7: Integrated Mini Case

An in-memory pipeline has `source_name="demo_orders"`, `max_attempts=3`, and four rows. The synthetic source fails once with `TransientOperationError`, then returns: a valid amount, one row missing required `amount`, one nonnumeric amount, and another valid amount. Policy: missing amount is FAIL; nonnumeric amount is REVIEW. The source simulation is repeat-safe. A variant raises nonretryable `ValueError` on its first call.

1. Does global config pass validation?
2. How many source calls occur in the recovery case?
3. How many retries occur?
4. What are PASS, REVIEW, FAIL, and processed counts?
5. What is the final run status under this lesson's policy?
6. Why is retrying the source simulation acceptable here?
7. Should either invalid row be retried?
8. What is the safe final summary?
9. In the nonretryable variant, how many calls occur?
10. What is that variant's run status?
11. If all three transient calls fail, how many attempts and what outcome?
12. What changes if the source operation appends output before failing?

## Answer Key

### Section 1

1. Different causes need different policies. 2. A business classification for one record. 3. It can be reviewed while other work continues, but repeating its unchanged value will not help. 4. A temporary fault that may clear. 5. Input needing correction, not immediate retry. 6. The run cannot be trusted without it. 7. Raises a clear exception. 8. Inside an active `except` to propagate the same exception. 9. The original cause. 10. To avoid misclassifying unrelated failures. 11. One record's result and reason. 12. Continue, abort, or safe bounded retry. 13. SUCCESS, PARTIAL, or FAILED with counts. 14. PASS, REVIEW, FAIL. 15. SUCCESS, PARTIAL, FAILED. 16. No. 17. Up to three total calls including first. 18. Two. 19. On success, nonretryable failure, or exhaustion. 20. Repeating unchanged bad data does not correct it. 21. Repetition without unintended extra effects. 22. The first attempt may have succeeded before the timeout. 23. Only after a retryable failure when another attempt remains. 24. Noise and possible data exposure. 25. `processed = PASS + REVIEW + FAIL`.

### Section 2

1. Data validation; bad row value. 2. Transient technical; temporary simulator fault. 3. Configuration; required setting absent. 4. Programming; code defect. 5. Permanent input or stage contract; global schema broken. 6. Permanent row input; required field missing. 7. Stage/resource; required source unavailable. 8. Data validation; unsupported choice. 9. Data validation; known conversion of one row. 10. Programming; unexpected logic error. 11. No error if optional by contract. 12. Transient technical at first, then exhausted stage failure; stop.

### Section 3

1. REVIEW/continue; isolate bad row. 2. FAIL fast; config cannot be invented. 3. RETRY within bound; known and repeat-safe. 4. FAIL; fix code. 5. FAIL; attempts exhausted. 6. CONTINUE; valid. 7. CONTINUE; optional. 8. FAIL or redesign before retry; duplicate effect risk. 9. REVIEW/continue under stated policy. 10. FAIL; global stage assumption broken.

### Section 4

1. Three. 2. Two. 3. Two. 4. One. 5. Zero. 6. Three. 7. No. 8. One. 9. Reject policy before calling. 10. Three calls and two retries.

### Section 5

1. Could loop forever; use validated `max_attempts` and a bounded range. 2. Silently hides all failures; catch only known exceptions at a decision boundary. 3. Same bad value; classify REVIEW/FAIL. 4. Configuration needs correction; fail fast. 5. No next call; stop without delay. 6. Duplicate work; return immediately. 7. Side effect repeats; isolate repeat-safe operation or provide duplicate protection. 8. Programming bug needs fix; do not catch as transient. 9. False status; report FAILED. 10. Duplicate logs; one owner logs and higher layers decide.

### Section 6

1. `amount must be numeric`. 2. Stage and fail count. 3. Inside a specific handler. 4. Safe stage failure without token. 5. One summary. 6. FAILED with attempts. 7. Bounded warning with attempt. 8. Log once at responsible boundary.

### Section 7

1. Yes: nonblank source and positive integer limit. 2. Two. 3. One. 4. PASS=2, REVIEW=1, FAIL=1, processed=4. 5. PARTIAL because some rows need review or failed validation. 6. It is a fixed in-memory source simulator with no side effects. 7. No; classify them. 8. For example `run_id=RUN-001 source=demo_orders run_status=PARTIAL processed=4 pass=2 review=1 fail=1 retries=1`. 9. One; `ValueError` is not caught by the transient retry handler. 10. FAILED. 11. Three attempts, then FAILED with exhaustion reported. 12. Repeating it could duplicate output; do not retry until the effect is made safe or reconciled.
