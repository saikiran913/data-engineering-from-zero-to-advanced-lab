# Assertions and Expected Results

An assertion compares what the function **actually** did with what its contract says it **should** do.

```python
actual = " ready ".strip().upper()
assert actual == "READY"
assert 0 >= 0
assert {"READY": 2} == {"READY": 2}
assert ["source", "amount"] == ["source", "amount"]
assert 2 + 2 == 4, "the count should include both pairs"
```

For a function, prefer `assert normalize_status(" ready ") == "READY"` to `assert normalize_status(" ready ")` because the latter only checks truthiness. Also test false results deliberately: `assert is_non_negative_amount(-1) is False`. Dictionaries and lists can be compared directly, including order when list order is part of the contract.

Floating-point arithmetic is approximate in binary. In a pytest test, `assert 0.1 + 0.2 == pytest.approx(0.3)` communicates a tolerance-based expectation. Use this only where approximate numeric equality fits the contract; do not use it to excuse a large calculation error.

This **intentional failure is documentation only**, not part of the passing test suite:

```python
assert normalize_status(" ready ") == "completed"
```

Pytest would show the actual `"READY"` versus expected `"completed"` near the assertion line. Read both sides and the contract before changing code or a test. A passing test with no meaningful expectation proves little.
