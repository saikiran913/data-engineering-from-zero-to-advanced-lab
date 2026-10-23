# Troubleshooting pytest

Run from the Day 070 folder with the intended Python environment. Diagnose the first failure category before changing code.

| Symptom | Likely cause | Next step |
|---|---|---|
| `No module named pytest` | Pytest absent from selected Python | Activate `.venv`, install requirements |
| Test file not discovered | Wrong filename | Use `test_*.py` or `*_test.py` |
| Test function not discovered | Name lacks `test_` | Rename and run `--collect-only` |
| No tests collected | Naming/path problem | Inspect collected nodes and working directory |
| Wrong working directory | Commands run outside Day root | Change into Day 070 folder |
| `ModuleNotFoundError: pipeline_utils` | Package not visible | Run `python -m pytest` from Day root |
| Assertion failed | Actual differs from expected | Read values and contract |
| Collection/import error | Test module could not load | Fix import or syntax before assertions |
| Unexpected exception | Function raised outside expected contract | Check input and implementation |
| Expected exception did not occur | Function returned instead | Check `pytest.raises` and contract |
| Flaky result | Clock, network or shared state | Use fixed input and independent tests |
| `pytest.approx` misused | Tolerance inappropriate or missing | Use it for approximate float equality only |
| Only a subset ran | File, node or `-k` filter active | Finish with full `python -m pytest -q` |
| State leaks between tests | Shared mutable data | Build fresh records per test |
| Cache or venv appears in Git | Ignore convention absent/overridden | Check Day `.gitignore` and staging |

## Diagnostic Flow

1. Verify the selected Python and virtual environment.
2. Verify pytest is installed with `python -m pytest --version`.
3. Verify the current directory is the Day 070 folder.
4. Inspect `test_` file and function names.
5. Run `python -m pytest --collect-only -q`.
6. Run one relevant test file or exact node.
7. Compare actual and expected values with the documented contract.
8. Run the full suite before concluding work.

Do not treat “not collected,” a collection error, a failed assertion and a passing test as interchangeable outcomes.
