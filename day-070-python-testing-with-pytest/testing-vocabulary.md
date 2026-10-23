# Testing Vocabulary

| Term | Plain meaning | Data Engineering example |
|---|---|---|
| Unit test | Small check of a function contract | One status normalizer input |
| Assertion | Statement of expected behavior | `assert result == "READY"` |
| Expected result | What the contract says should happen | Blank status becomes `""` |
| Actual result | What the code returned or raised | The returned cleaned string |
| Test runner | Tool that discovers and executes tests | `python -m pytest` |
| Discovery | Finding named test files/functions | `tests/test_cleaning.py` |
| Test module | Python file containing tests | `test_validation.py` |
| Test function | Discoverable `test_...` callable | `test_zero_amount_is_allowed` |
| Edge case | Boundary or unusual valid/invalid input | Zero amount, blank string |
| Regression | Behavior that worked before but later breaks | Status case normalization changes |
| PASS | All checked expectations in a test succeeded | Output matches contract |
| FAIL | An assertion or expectation failed | Actual status differs |
| ERROR | Test setup or execution could not complete as expected | Import fails during collection |
| Collection error | Pytest cannot load a test module | Missing package import |
| Independent test | Does not rely on another test | Creates its own record |
| Fixture | Reusable test setup provided by pytest | Later lesson topic, not needed today |

A collection error is not a failed assertion; pytest did not reach the intended check. A test that was not collected is not a passing test.
