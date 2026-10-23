# Practice Questions

Answer before reading the key. Assume a synthetic, in-memory order batch and one console logging configuration in `main`.

## Section 1: Concepts

1. What problem does logging solve in a pipeline?
2. What does `logging.getLogger(__name__)` return?
3. What is a logger name useful for?
4. What does a handler do?
5. What does a formatter do?
6. What does `basicConfig` configure in a simple script?
7. Where should `basicConfig` normally be called?
8. Which stream normally receives basic console logs?
9. Which stream normally receives `print` output?
10. What happens to DEBUG events at an INFO threshold?
11. Name all five built-in severity levels in increasing order.
12. What is logger propagation?
13. Why can child and root handlers create duplicate lines?
14. What is a run ID?
15. Name three safe context fields.
16. Why use `logger.info("count=%s", count)`?
17. Are key=value messages automatically JSON logs?
18. Why log a validation count instead of each row?
19. Does an ERROR log handle an exception?
20. Where should `logger.exception` be called?
21. What extra information does `logger.exception` include?
22. Is a business FAIL automatically an operational ERROR?
23. What should a COMPLETE log mean?
24. Name two things logs cannot replace.
25. What count equation holds when every input has one validation outcome?

## Section 2: Select the Level

Choose DEBUG, INFO, WARNING, ERROR, or CRITICAL.

1. A normal run begins.
2. A detailed safe input count is useful only while investigating.
3. Two records require manual review, but the stage completed.
4. A stage unexpectedly raises and cannot finish.
5. The whole pipeline cannot start because its core configuration is unusable.
6. Normalisation completed with six rows.
7. A bounded filter count is needed during debugging.
8. The batch is empty and an operator should check the source.
9. The run completed successfully.
10. A retry will occur after a handled transient condition.
11. All input rows were classified, including one business FAIL.
12. A reconciliation assertion fails and processing stops.

## Section 3: Find the Bad Logging Choice

For each, identify the issue and a safer change.

1. `logger.info("password=%s", password)`
2. `logger.info("row=%s", order)` for every row.
3. A helper calls `logging.basicConfig()` on every function call.
4. A module adds a handler while the root already has one.
5. `logger.exception("invalid amount")` outside an `except` block.
6. `logger.error("failed")` then the function returns success without handling anything.
7. `logger.debug(f"records={expensive_render(records)}")` at INFO threshold.
8. `logger.info("count=%s stage=%s", count)` with one argument.
9. A run logs START and no later stage or completion events.
10. A team treats `validation_status=FAIL` as proof that Python crashed.

## Section 4: Improve the Message

Rewrite each as a short, safe key=value event. Use a fixed `RUN-001` and counts where appropriate; never add raw rows.

1. `started`
2. `read some orders`
3. `cleaned data`
4. `validation done`
5. `there are issues`
6. `done`
7. `source failed` (an unexpected exception is active)
8. `debugging filter`
9. `empty`
10. `summary generated`

## Section 5: Exception or Validation?

For each, decide whether to classify/summarise an expected outcome or log an unexpected exception; name a reasonable level.

1. One amount is text and the validator is designed to reject it.
2. A normalisation function unexpectedly raises `RuntimeError`.
3. One order has a zero amount and policy marks it REVIEW.
4. A known conversion `ValueError` is handled and counted.
5. A stage fails after all rows are loaded and cannot continue.
6. A validator finishes with two PASS and one FAIL.
7. A caught exception is logged then deliberately re-raised to stop the run.
8. A caller logs the same re-raised exception again with no new information.

## Section 6: Integrated Case

An in-memory batch has six synthetic amounts: `12`, `0`, `8`, `"invalid"`, `5`, `21`. The pipeline stages are NORMALISE, VALIDATE, and SUMMARISE. Positive numeric amounts are PASS, zero is REVIEW, and other values are FAIL.

1. Choose a safe fixed run ID and source label.
2. What are the PASS, REVIEW, FAIL, and total counts?
3. Which stage summaries would you log from START through COMPLETE?
4. Show one INFO validation summary using deferred `%s` arguments.
5. Should the invalid amount create a traceback? Why?
6. Should the whole record appear in a log? Why?
7. Which event could reasonably be WARNING?
8. What should happen if SUMMARISE unexpectedly raises `RuntimeError`?
9. What does the equation for reconciliation look like?
10. What evidence beyond logs would you use to check correctness?

## Answer Key

### Section 1

1. It makes important execution events diagnosable. 2. A named logger for this module. 3. It locates event origin. 4. It delivers log records. 5. It formats their display. 6. A basic handler, threshold, and format. 7. In the application entry point. 8. Usually `stderr`. 9. Usually `stdout`. 10. They are filtered. 11. DEBUG, INFO, WARNING, ERROR, CRITICAL. 12. A child passes events to ancestors. 13. Both handlers may emit the same event. 14. A label connecting one run's events. 15. `run_id`, `source`, `stage` (counts also work). 16. Logging defers string interpolation. 17. No; they are readable text. 18. It is safer and less noisy. 19. No. 20. Inside an `except` handler. 21. The traceback. 22. No. 23. The intended work really finished. 24. Any two of validation outputs, tests, metrics, alerting. 25. `input_count = pass_count + review_count + fail_count`.

### Section 2

1. INFO. 2. DEBUG. 3. WARNING. 4. ERROR. 5. CRITICAL. 6. INFO. 7. DEBUG. 8. WARNING. 9. INFO. 10. WARNING. 11. INFO for a summary; FAIL is a business status. 12. ERROR.

### Section 3

1. Secret leak; omit the password. 2. Raw, noisy records; log aggregate counts. 3. Repeated configuration; configure once in `main`. 4. Propagation can duplicate output; use one handler. 5. No active exception; use it only inside `except`. 6. Logging does not handle failure; stop, recover, or propagate explicitly. 7. Eager expensive formatting; pass safe `%s` arguments and avoid rendering records. 8. Two placeholders need two arguments. 9. Add meaningful stage and completion/failure events. 10. A business status is not an operational crash; check actual control flow.

### Section 4

Many answers work. Examples:

1. `run_id=RUN-001 stage=START source=orders_batch`
2. `run_id=RUN-001 stage=READ record_count=6`
3. `run_id=RUN-001 stage=NORMALISE record_count=6`
4. `run_id=RUN-001 stage=VALIDATE pass_count=4 review_count=1 fail_count=1`
5. `run_id=RUN-001 stage=VALIDATE review_count=1` (WARNING if action needed)
6. `run_id=RUN-001 stage=COMPLETE accepted_count=4`
7. `run_id=RUN-001 stage=READ failed` via `logger.exception` inside the handler
8. `run_id=RUN-001 stage=FILTER input_count=6 output_count=4` at DEBUG
9. `run_id=RUN-001 stage=READ record_count=0` at WARNING if unexpected
10. `run_id=RUN-001 stage=SUMMARISE record_count=6`

### Section 5

1. Expected validation FAIL; aggregate at INFO (WARNING only if action needed). 2. Operational ERROR; catch specifically and use `logger.exception` if this layer owns diagnosis. 3. Expected REVIEW; summary INFO, optionally WARNING for action. 4. Expected validation outcome; count it without traceback. 5. ERROR, and do not log COMPLETE. 6. INFO summary, not automatic ERROR. 7. One useful exception log at the responsible layer; re-raise intentionally. 8. Avoid the duplicate log unless adding distinct, necessary context.

### Section 6

1. `RUN-001`, `orders_batch`. 2. PASS=4, REVIEW=1, FAIL=1, total=6. 3. START, READ with six, NORMALISE with six, VALIDATE with counts, SUMMARISE with six, COMPLETE with four accepted. 4. `logger.info("run_id=%s stage=VALIDATE pass_count=%s review_count=%s fail_count=%s", "RUN-001", 4, 1, 1)`. 5. No; invalid text is an expected validation outcome. 6. No; it is unnecessary and could expose data. 7. Review count if it needs attention. 8. Catch specifically at an owning boundary, log an exception once, and stop or explicitly recover; do not claim completion. 9. `6 = 4 + 1 + 1`. 10. Inspect validation results and tests; metrics or alerts may also matter in a real pipeline.
