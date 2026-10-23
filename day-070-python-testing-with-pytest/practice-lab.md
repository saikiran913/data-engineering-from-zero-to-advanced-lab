# Write and Run Your First Data Engineering Tests with pytest

Run every command from `day-070-python-testing-with-pytest/`. Check `python --version` for Python 3.10+ (or `py --version` on Windows). The core code and demos are standard-library-only; pytest is needed for the test suite.

1. Create an isolated environment with `python -m venv .venv`. Activate it using the [shell-specific instructions](installing-and-running-pytest.md), or use its Python path directly.
2. Run `python -m pip install -r requirements-dev.txt`, then `python -m pytest --version`.
3. Inspect [`pipeline_utils/`](pipeline_utils/) to see the contracts; inspect [`tests/`](tests/) to see their expectations.
4. Run `python -m pytest --collect-only -q`. Expect six test modules and dozens of named tests, not “no tests collected.”
5. Run `python -m pytest -q` for the full suite. All committed tests should pass.
6. Run `python -m pytest -q tests/test_cleaning.py` for one file.
7. Run `python -m pytest -q tests/test_cleaning.py::test_normalize_status_trims_and_uppercases` for one test.
8. Run `python -m pytest -q -k amount` for related tests. This does not run the full suite.
9. Read the **illustrative failure** below. Do not leave it in a committed test file.
10. Optionally add a local `test_...` case for a blank status, run it, then restore a clean passing suite.
11. Re-run `python -m pytest -q` and confirm no test depends on another's mutations.

```python
# Illustration only: this would fail because the actual value is "READY".
assert normalize_status(" ready ") == "COMPLETED"
```

The failure is a learning signal: compare actual, expected and contract. Do not delete a correct assertion just to make the suite green. Stand-alone scripts can be run with `python scripts/01_assertion_basics.py` through `python scripts/06_data_engineering_testing_workflow.py` without pytest. On Windows, `py` may replace `python` when configured that way.

## Completion Check

- I can explain why the application package does not import pytest.
- I can list collected tests and distinguish collection from execution.
- I can run the full suite, one file, one function and a name filter.
- I can test a normal result, an edge case, an expected exception and non-mutation.
- I can keep tests independent, synthetic and free of network or file operations.
- I can ensure `.venv/`, `.pytest_cache/`, and `__pycache__/` are ignored by Git.
