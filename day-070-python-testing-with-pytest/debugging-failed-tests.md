# Debugging Failed Tests

Start with the first useful failure report. A **FAIL** from `assert actual == expected` shows the comparison and location; pytest's assertion introspection often displays both sides. An **ERROR during collection** means a test module could not be loaded, perhaps because `pipeline_utils` was not importable from the chosen working directory. Fix collection before reasoning about assertions.

1. Confirm you are in the Day 070 folder and using its selected Python environment.
2. Run `python -m pytest --collect-only -q` to check discovery.
3. Read the failing file, function, and exact assertion line.
4. Compare actual output, expected output, and the documented function contract.
5. Isolate one file or node, for example `python -m pytest -q tests/test_cleaning.py::test_normalize_status_trims_and_uppercases`.
6. Use `-k amount` for related tests, then rerun the whole suite.

If `python -m pytest` says the module is missing, install pytest in the **selected virtual environment**. Do not remove an assertion merely to make red output green; decide whether code or expectation is wrong. A printed value is not an assertion. Passing a filtered subset does not show that other tests pass.
