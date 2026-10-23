# Beginner Summary

Testing turns an expectation about a function into an executable check. A status normalizer should turn `" ready "` into `"READY"`; a required-field checker should report an absent key but not treat numeric zero as missing. A test arranges a fixed input, calls the function, and asserts the expected result. This makes a documented Data Engineering contract easier to preserve when code changes.

Pytest is the test runner and an intentional **development dependency**. It is not part of Python's standard library. Keep the application functions in `pipeline_utils/` independent of pytest; keep pytest imports in `tests/`. Create a local virtual environment, install `requirements-dev.txt`, and run commands from the Day 070 folder with its selected Python. `python -m pytest --collect-only -q` shows discovered tests; `python -m pytest -q` runs the full suite. A file path, an exact `::test_function` node, or `-k amount` selects only part of the suite.

Discovery relies on names. Pytest commonly collects `test_*.py` files and `test_...` functions. A misnamed function that is not collected is not a passing test. A collection/import error means pytest could not load the test; a failed assertion means it ran and found a mismatch. The runner's failure output helps compare actual and expected values. Do not change an assertion blindly to match buggy behavior; check the contract first.

Plain `assert` handles values, Booleans, lists, dictionaries, and invariants. Test a normal example, then useful boundaries: blank text, `None` when allowed, zero, a negative amount, a missing required key, an impossible date, and an empty collection. An invalid input that the function promises to reject should be tested with `pytest.raises`. For floating-point arithmetic where exact binary equality is inappropriate, `pytest.approx` states an approximate expectation.

Independent tests create their own synthetic inputs and do not depend on run order, the current clock, a live API, or another test's mutations. Check non-mutation explicitly for a transformation that promises to return a new record. Day 069's error-handling distinctions also matter: a returned REVIEW result is not the same as a raised exception; write the expectation that matches the documented function.

> A passing test suite means the tested expectations passed. It does not prove that a pipeline has no bugs or that every real-world edge case is covered.

> Tests should be deterministic and independent. Avoid relying on live APIs, the current clock, network responses, hidden shared state, or execution order for beginner unit tests.

> Use assertions to check meaningful behaviour, not merely that a function ran. Include normal, boundary, missing-value, and invalid-input cases when the function contract calls for them.

> pytest is an external development dependency, not part of the Python standard library. Install it in an appropriate virtual environment and keep runtime application code independent of pytest.

The suite reduces regression risk; it does not prove a future production pipeline is perfect. The provisional next lesson is **Day 071 — Python Testing Practice: Fixtures, Parametrization, and Data Pipeline Edge Cases**. Its exact title may change when Day 071 is planned.
