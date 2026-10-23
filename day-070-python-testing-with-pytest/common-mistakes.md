# Common Testing Mistakes

| # | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Assuming pytest is standard library | Import fails without install | Install as dev dependency |
| 2 | Installing into another Python | Runner still missing | Use selected `python -m pip` |
| 3 | Installing globally by habit | Mixes project dependencies | Use a local virtual environment |
| 4 | Assuming any `tests.py` is collected | Naming rules matter | Use `tests/test_*.py` |
| 5 | Misnamed test file | Pytest may skip it | Use `test_*.py` or `*_test.py` |
| 6 | Misnamed function | It is not collected | Start name with `test_` |
| 7 | Reading “no tests collected” as pass | No expectation ran | Run `--collect-only` and fix names |
| 8 | Calling import error an assertion failure | Test never ran | Fix import/working directory |
| 9 | No meaningful assertion | Passing says little | Compare actual to expected |
| 10 | Only `assert True` | Does not exercise behavior | Assert function result |
| 11 | Only happy-path tests | Boundaries can regress | Add edge and invalid cases |
| 12 | Omitting missing/blank cases | Required-field rule untested | Include both |
| 13 | Exact float comparison for calculation | Binary rounding can differ | Use `pytest.approx` when appropriate |
| 14 | Not testing documented exception | Invalid path unverified | Use `pytest.raises` |
| 15 | Catching bad input inside core function and returning success | Contract becomes misleading | Raise or return explicit outcome |
| 16 | Tests share a mutable dict | Order affects results | Create fresh input in each test |
| 17 | Test B relies on test A | Suite order may change | Make each independent |
| 18 | Using current date in a unit test | Result changes with time | Use fixed date |
| 19 | Calling a live service | Flaky and slow | Use in-memory synthetic input |
| 20 | Mutating source record unexpectedly | Can corrupt upstream data | Assert original unchanged |
| 21 | Adding `sys.path` hacks | Hides structure problem | Run from Day root with package |
| 22 | Testing implementation details | Safe refactors break tests | Assert public contract |
| 23 | Copying buggy output as expected | Test blesses defect | Derive expected result from rule |
| 24 | Changing assertion to match bug | Green but wrong | Review documented contract first |
| 25 | Committing deliberate failed demo | Full suite stays red | Show failure in Markdown only |
| 26 | Running only one selected test | Other failures remain unknown | Run full suite before completion |
| 27 | Name `test_it_works` | Hard to locate behavior | State rule in test name |
| 28 | Printing instead of asserting | Runner cannot judge correctness | Assert values |
| 29 | Importing pytest into runtime helpers | Adds dev dependency to app | Keep pytest in `tests/` only |
| 30 | Broad skip/xfail to hide failures | Reduces trust | Fix cause or document narrow reason |
| 31 | Assuming a green suite proves production safety | Coverage is limited | Combine tests with validation and review |
| 32 | Running from wrong directory | Package import may fail | Run from Day 070 folder |

The best next test is chosen from a documented rule or a bug risk, not from a desire for a larger test count.
