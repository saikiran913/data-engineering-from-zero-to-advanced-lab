# Practice Questions

Use the contracts in [`pipeline_utils/`](pipeline_utils/) and work from the Day 070 folder. Answer each section before looking at its matching key. These are reasoning exercises; do not leave deliberately failing tests in the repository.

## Section 1: Concepts (28)

1. What is a unit test?
2. What is an assertion?
3. What are actual and expected results?
4. What is a test suite?
5. What does pytest discovery do?
6. Name the usual test-file prefix.
7. Name the test-function prefix.
8. Is pytest part of the standard library?
9. Why use a virtual environment?
10. Why run `python -m pytest` rather than relying on a possibly different `pytest` executable?
11. What does `--collect-only` do?
12. What does `-q` change?
13. What does `-v` change?
14. What does `-k amount` select?
15. How do you select one test function?
16. Does one selected passing test prove the suite passes?
17. What is a boundary case for non-negative amounts?
18. Why test blank status text?
19. How is `None` different from blank text in `normalize_status`?
20. How do you check an expected exception?
21. Why use `pytest.approx` for `0.1 + 0.2`?
22. What is a collection error?
23. What does an assertion failure tell you?
24. Why assert the original record remains unchanged?
25. Why should tests be independent?
26. Is `print(result)` a sufficient expectation?
27. Does a green suite prove no production bugs exist?
28. Where should pytest imports live in this lesson?

## Section 2: Predict PASS or FAIL (12)

Assume each line is inside a collected pytest test and required imports exist. Decide whether it passes or fails, and why.

1. `assert normalize_status(" ready ") == "READY"`
2. `assert normalize_status(None) == ""`
3. `assert normalize_status("   ") == ""`
4. `assert parse_amount("0") == 0.0`
5. `assert parse_amount("-2") == 2.0`
6. `assert is_non_negative_amount(0) is True`
7. `assert is_non_negative_amount(-1) is True`
8. `assert missing_required_fields({"amount": 0}, ("amount",)) == []`
9. `assert build_clean_record({"status": " ready "}) == {"status": "READY"}`
10. `assert count_statuses([]) == {}`
11. `assert parse_iso_date("2024-02-29") == date(2024, 2, 29)`
12. `assert 0.1 + 0.2 == pytest.approx(0.3)`

## Section 3: Choose the Expected Result (12)

Write the expected value or expected exception.

1. `normalize_status(" completed ")`
2. `normalize_status("READY")`
3. `normalize_country_code(" uk ")`
4. `normalize_status(None)`
5. `parse_amount(" 12.5 ")`
6. `parse_amount("invalid")`
7. `parse_amount("-4")`
8. `parse_iso_date("2023-02-29")`
9. `is_non_negative_amount(-0.01)`
10. `missing_required_fields({"a": 0, "b": False}, ("a", "b"))`
11. `build_clean_record({"amount": 5})`
12. `count_statuses([{"status": "READY"}, {"status": "READY"}])`

## Section 4: Discovery Naming (10)

For each, say whether pytest normally collects it as a test from the Day root. Assume no custom config.

1. `tests/test_cleaning.py` containing `def test_status(): ...`
2. `tests/cleaning.py` containing `def test_status(): ...`
3. `tests/test_cleaning.py` containing `def check_status(): ...`
4. `tests/cleaning_test.py` containing `def test_status(): ...`
5. `tests/test_validation.py` containing `def test_zero_amount_is_allowed(): ...`
6. `tests/test_validation.py` containing `def status_test(): ...`
7. `tests/test_discovery.py` containing `def test_discovery_collects_meaningful_cleaning_check(): ...`
8. `scripts/01_assertion_basics.py` containing `def main(): ...`
9. `tests/test_parsing.py` containing `def test_parse_amount_zero(): ...`
10. `tests/test_parsing.py` containing `def example_amount(): ...`

## Section 5: What Makes This Test Weak? (10)

Identify the issue and a stronger approach.

1. `def test_status(): assert True`
2. `def test_status(): print(normalize_status(" ready "))`
3. Only tests `parse_amount("5")`.
4. Tests `date.today()` against a fixed day.
5. Calls a live API to obtain a test record.
6. Second test assumes first test changed a global list.
7. `assert parse_amount("bad") == 0` despite documented exception.
8. Removes a failed assertion without reading the contract.
9. Only runs `-k amount` before calling the entire suite green.
10. Adds `sys.path` edits to hide a wrong working directory.

## Section 6: Choose Cases (10)

Choose one useful normal, boundary, or invalid case as requested, with the expected behavior.

1. Normal case for status normalization.
2. Already-clean case for status normalization.
3. Blank boundary for status normalization.
4. Optional missing case for status normalization.
5. Zero boundary for non-negative validation.
6. Negative case for non-negative validation.
7. Missing key for required-field checker.
8. Invalid numeric text for parser.
9. Invalid calendar date for ISO parser.
10. Empty input for status aggregation.

## Section 7: Integrated Test Design

A synthetic order has `status=" ready "`, `amount="10"`, and required key `order_id="REC-001"`. Use the package functions, not a live pipeline.

1. Write a specific normalizer test input and expected output.
2. State the parser's expected value for `"10"`.
3. State the parser's expected behavior for `"invalid"` and the pytest construct to check it.
4. Check that `order_id` is not missing.
5. What should `missing_required_fields({}, ("order_id", "amount"))` return?
6. What should `build_clean_record` return for the order?
7. How do you assert the source dictionary was not mutated?
8. Give a zero boundary test for amount validation.
9. Give a useful assertion for two READY records and one COMPLETED record.
10. Which full-suite command must run after testing one selected function?

## Answer Key

### Section 1

1. Small check of one function contract. 2. Executable expectation. 3. Actual is observed behavior; expected is the contract's result. 4. Group of tests. 5. Finds named tests. 6. `test_` in `test_*.py` (or `*_test.py`). 7. `test_`. 8. No. 9. Isolate development packages. 10. It uses the selected Python environment. 11. Lists collected tests without running them. 12. Quieter output. 13. More detail. 14. Tests whose names match the expression. 15. `python -m pytest -q tests/test_cleaning.py::test_normalize_status_trims_and_uppercases`. 16. No. 17. Zero. 18. It checks the empty-string rule. 19. `None` stays `None`; blank text becomes `""`. 20. `with pytest.raises(ExpectedType): ...`. 21. Binary floating-point rounding. 22. Test module cannot be loaded/collected. 23. Actual behavior did not match an expectation. 24. Non-mutation is part of the contract. 25. Execution order must not affect results. 26. No, assert an expectation. 27. No. 28. In `tests/`, not `pipeline_utils/`.

### Section 2

1. PASS. 2. FAIL: actual is `None`. 3. PASS. 4. PASS. 5. FAIL: actual is `-2.0`. 6. PASS. 7. FAIL: actual is False. 8. PASS. 9. PASS. 10. PASS. 11. PASS. 12. PASS because approximation is intended.

### Section 3

1. `"COMPLETED"`. 2. `"READY"`. 3. `"UK"`. 4. `None`. 5. `12.5`. 6. `ValueError`. 7. `-4.0`; parsing does not reject negative values. 8. `ValueError`. 9. False. 10. `[]`. 11. `{"amount": 5}` in a new dictionary. 12. `{"READY": 2}`.

### Section 4

1. Yes. 2. No: filename. 3. No: function name. 4. Yes: `*_test.py` matches. 5. Yes. 6. No: function name. 7. Yes. 8. No: not a test filename/function. 9. Yes. 10. No: function name.

### Section 5

1. Does not test behavior; compare actual normalized value. 2. Print is not an expectation; assert result equals `"READY"`. 3. Only happy path; add blank and invalid input. 4. Time changes; use a fixed date. 5. Network dependence; use synthetic in-memory input. 6. Hidden shared state; each test creates its own list. 7. Contract says raise; use `pytest.raises(ValueError)`. 8. Review actual result and contract first. 9. A subset cannot prove full suite; run `python -m pytest -q`. 10. Run from Day root and keep package imports straightforward.

### Section 6

1. `" ready "` → `"READY"`. 2. `"READY"` → `"READY"`. 3. `"   "` → `""`. 4. `None` → `None`. 5. `0` → True. 6. `-0.01` → False. 7. `{}` with `("order_id",)` → `["order_id"]`. 8. `"bad"` → `ValueError`. 9. `"2023-02-29"` → `ValueError`. 10. `[]` → `{}`.

### Section 7

1. `assert normalize_status(" ready ") == "READY"`. 2. `10.0`. 3. `ValueError`; `with pytest.raises(ValueError): parse_amount("invalid")`. 4. `assert missing_required_fields(order, ("order_id",)) == []`. 5. `["order_id", "amount"]` in that order. 6. `{"status": "READY", "amount": "10", "order_id": "REC-001"}`; the transform only normalizes status. 7. Keep a copy or known literal and assert `order == {"status": " ready ", "amount": "10", "order_id": "REC-001"}` afterward. 8. `assert is_non_negative_amount(0) is True`. 9. `assert count_statuses([{"status": "READY"}, {"status": "READY"}, {"status": "COMPLETED"}]) == {"READY": 2, "COMPLETED": 1}`. 10. `python -m pytest -q` from Day 070 root.
