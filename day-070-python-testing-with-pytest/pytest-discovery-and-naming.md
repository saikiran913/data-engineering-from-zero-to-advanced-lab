# Pytest Discovery and Naming

From the Day 070 folder, `python -m pytest --collect-only -q` lists discovered tests. By default pytest looks for files named `test_*.py` or `*_test.py`, and functions beginning `test_`. A test class can start with `Test` and should not define a custom `__init__`, but this beginner lesson uses plain functions.

| File/function | Collected? | Why |
|---|---|---|
| `tests/test_cleaning.py::test_normalize_status_trims_and_uppercases` | Yes | Both names match |
| `tests/cleaning_examples.py::test_status` | No by default | File name does not match |
| `tests/test_cleaning.py::check_status` | No | Function name does not match |

Misnamed examples are shown only here; the actual [`test_discovery.py`](tests/test_discovery.py) contains two real passing tests. **No tests collected** is not the same as **tests passed**. A failed assertion means a collected test ran and found a mismatch. A collection/import error means pytest could not load a module or function, so fix the import or path first. Keep the Day folder as working directory so `pipeline_utils` is importable without `sys.path` hacks.
