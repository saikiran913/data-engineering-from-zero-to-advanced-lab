# Revision Notes

```text
function contract
→ arrange input
→ call function
→ assert expected result
→ pytest collects test
→ pass/fail diagnosis
```

A **test case** is one specific input and expectation. An **assertion** compares actual behavior with the expected behavior. A **suite** is a collection of tests; **discovery** is how pytest finds `test_*.py` modules and `test_...` functions. One focused test should communicate one clear behavior, such as `normalize_status(" completed ") == "COMPLETED"`.

Use deterministic fixed values: a 2024 leap date, a synthetic record, or a known amount. Do not depend on the current clock, a live source, another test having run first, or hidden shared state. Each test should be independent and repeatable. A returned REVIEW classification and a raised `ValueError` are different contracts; assert the former as a value and the latter with `pytest.raises`.

The test runner reports passing expectations, failed assertions, and collection/import errors differently. A test function with no meaningful assertion can pass without checking the intended rule. `--collect-only` confirms what pytest found, not whether behavior is correct. `-q`, `-v`, a file path, a node ID, and `-k` help inspect subsets; always finish with the full suite.

Tests do not replace type hints, runtime validation, logging, or safe error handling. They make chosen contracts executable, reducing regression risk without proving all future inputs are covered. Keep application code in `pipeline_utils/` free of pytest imports, and keep pytest-only helpers in `tests/`.
