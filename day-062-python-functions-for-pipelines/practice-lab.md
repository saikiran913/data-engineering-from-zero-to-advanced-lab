# Build Reusable Functions for a Small Data Pipeline

1. Verify Python with `python --version`.
2. Run `python scripts/01_parameter_design.py`.
3. Run `python scripts/02_return_value_patterns.py`.
4. Run `python scripts/03_pure_transformations.py`.
5. Run `python scripts/04_validation_functions.py`.
6. Run `python scripts/05_function_composition.py`.
7. Run `python scripts/06_pipeline_function_workflow.py`.
8. Inspect `mini_pipeline/pipeline_utils/` and name each module responsibility.
9. Run `python mini_pipeline/app.py`.
10. Add `UNKNOWN` to `allowed_statuses` and observe the classification change.
11. Change `minimum_amount` to `10` and observe configuration-driven behaviour.
12. Add a record with `amount: "bad"`.
13. Add a record with an invalid event date.
14. Confirm parsing returns `None` instead of crashing.
15. Confirm raw records remain unchanged after normalization.
16. Explain the parameters, output, and side effects for `validate_record`.

Completion check: every validation result has `status` and `reason`; results total equals PASS plus REVIEW plus FAIL; no helper performs file I/O or changes input records.
