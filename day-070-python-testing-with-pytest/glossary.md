# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| Actual result | What code really returns or raises | `"READY"` |
| Arrange/Act/Assert | Prepare, call, check | Create row; clean; compare |
| Assertion | Statement of expected behavior | `assert result == 2` |
| Assertion introspection | Pytest's detail for a failed comparison | Actual versus expected |
| Collection | Finding test items before execution | `--collect-only` |
| Collection error | Test module could not be loaded | Import failure |
| Deterministic test | Same input gives same result | Fixed 2024 date |
| Development dependency | Tool needed to develop/test, not run helpers | pytest |
| Discovery | Naming-based search for tests | `test_*.py` |
| Edge case | Boundary or unusual input | Zero or blank string |
| Expected exception | Error the contract promises for invalid input | `ValueError` |
| Expected result | Behavior the contract specifies | `None` stays `None` |
| Fixture | Reusable pytest setup, taught later | Shared sample input concept |
| Import error | Python could not load a module | Wrong working directory |
| Independent test | Does not rely on another test | Fresh dict per case |
| pytest | Third-party Python test runner | `python -m pytest` |
| Regression | Previously correct behavior breaks | Status cleaning changes |
| Test case | One input and expectation | Zero is non-negative |
| Test function | Named callable containing checks | `test_zero_amount_is_allowed` |
| Test module | File holding tests | `test_validation.py` |
| Test runner | Tool executing discovered tests | pytest |
| Test suite | Group of tests | All six modules |
| Unit test | Small test of a function contract | Parse one amount |
| Virtual environment | Isolated Python package environment | Local `.venv` |

The terms are ordered alphabetically. Passing discovery is not proof of behavior: the tests still need meaningful assertions and execution.
