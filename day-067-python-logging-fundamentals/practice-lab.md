# Practice Lab

Run these commands from `day-067-python-logging-fundamentals/`. Use Python 3.9+; no packages, files, or services are needed. Console logs normally appear on `stderr`, while the deliberate `print` in script 01 appears on `stdout`.

First run `python --version` (or `py --version` on Windows) and confirm Python 3.9 or newer.

```text
python scripts/01_logging_basics.py
python scripts/02_logging_levels.py
python scripts/03_context_rich_messages.py
python scripts/04_logging_exceptions.py
python scripts/05_validation_diagnostics.py
python scripts/06_data_engineering_logging_workflow.py
```

| Script | Observe | Explain afterward |
|---|---|---|
| 01 | START and COMPLETE logs plus a printed result | Which lines are diagnostics versus output? |
| 02 | DEBUG absent at INFO, present after threshold change | Why did other messages appear twice in this deliberate demonstration? |
| 03 | Same run ID and source across stages | Which fields let you connect events? |
| 04 | No traceback for expected invalid data; traceback for synthetic stage failure | Where is `logger.exception` called? |
| 05 | PASS, REVIEW, FAIL totals | Do totals equal input count? Is FAIL an ERROR log? |
| 06 | START through COMPLETE | Does every stage carry safe context without raw rows? |

## Try It

1. In script 02, change the initial threshold to WARNING. Predict which lines remain in the first group; run it and compare. Restore INFO afterward.
2. In script 03, change only the synthetic run ID. Check that every stage still uses the same ID.
3. In script 05, add one positive amount in memory. Predict the PASS and input counts before running.
4. In script 06, change one positive amount to zero. Predict the new PASS and REVIEW counts. Confirm the total still reconciles.
5. In script 06, identify where configuration happens. Explain why moving `basicConfig` into `normalise` would be confusing.

Do not add row dumps, file handlers, or real identifiers. After experimenting, restore the example data so the lesson stays deterministic. The [questions](practice-questions.md) include further reasoning and complete answers.

## Self-Check

- I can distinguish INFO from DEBUG output and find the logger name.
- I can add a fixed run ID and stage without logging a raw record.
- I can explain why an expected validation FAIL has no traceback.
- I can identify the intentional exception traceback in script 04.
- I can reconcile the workflow's PASS, REVIEW, and FAIL totals and locate COMPLETE.
