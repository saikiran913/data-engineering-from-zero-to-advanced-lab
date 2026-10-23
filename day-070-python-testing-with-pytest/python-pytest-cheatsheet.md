# Python pytest Cheatsheet

Run from the Day 070 folder with the selected virtual environment active (or its Python path):

| Goal | Command |
|---|---|
| Install dev dependency | `python -m pip install -r requirements-dev.txt` |
| Check version | `python -m pytest --version` |
| List collected tests | `python -m pytest --collect-only -q` |
| Run full suite | `python -m pytest -q` |
| More detail | `python -m pytest -v` |
| One file | `python -m pytest -q tests/test_cleaning.py` |
| One function | `python -m pytest -q tests/test_cleaning.py::test_normalize_status_trims_and_uppercases` |
| Name filter | `python -m pytest -q -k amount` |

```python
assert normalize_status(" ready ") == "READY"

with pytest.raises(ValueError):
    parse_amount("bad")

assert 0.1 + 0.2 == pytest.approx(0.3)
```

Files should match `test_*.py` or `*_test.py`; functions start `test_`. Use normal, boundary, missing, invalid, and non-mutation cases from the contract. A test with no meaningful assertion may pass without checking behavior. Pytest is a development dependency only; core helpers stay standard-library-only. A green suite reduces risk but cannot prove every future case.
