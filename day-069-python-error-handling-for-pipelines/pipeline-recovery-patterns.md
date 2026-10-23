# Pipeline Recovery Patterns

## A. Continue With Review

Validate rows independently. Return an explicit PASS/REVIEW/FAIL result for each, retain reasons in memory, and count all processed rows. Under the lesson's policy, any REVIEW/FAIL makes the run PARTIAL, not a hidden full success.

## B. Fail Fast

Check required configuration and global schema before processing. If `source_name` is blank, report FAILED and zero processed rows. Do not invent a fallback or retry the same invalid setting.

## C. Safe Bounded Retry

For a deterministic source simulator that raises `TransientOperationError` once, call it at most three times. It succeeds on attempt 2, so retries attempted = 1. If it fails on all three calls, report FAILED. A different exception propagates immediately. No script waits or contacts a real source.

```text
validate global settings
→ attempt safe source stage (bounded)
→ classify each received row
→ reconcile PASS + REVIEW + FAIL = processed
→ report attempts, retries, reasons, and run status
```

A useful final summary includes processed count, three outcome counts, retry count, stage, and `SUCCESS`, `PARTIAL`, or `FAILED`. Recovery is a deliberate policy, never “catch everything and keep going.” An exhausted source stage has no valid batch to summarize as success.
