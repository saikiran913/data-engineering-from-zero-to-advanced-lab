# Day 070 — Python Testing Fundamentals with pytest: Assertions, Discovery, and Test Structure

## Learning Goal

Learn to turn a documented Python function contract into repeatable tests. Data Engineers test cleaning, parsing, validation, and transformations so ordinary inputs and important boundaries behave as intended. Day 060 introduced exceptions; Day 062 organised functions; Day 066 documented contracts; Day 067 added diagnostics; and Day 069 distinguished recoverable data errors from stage failures. Today you check those decisions with executable expectations.

Application functions live in [`pipeline_utils/`](pipeline_utils/) and use only Python's standard library. Test functions live in [`tests/`](tests/) and use **pytest**, an intentional third-party development dependency. The six [`scripts/`](scripts/) demos are standard-library-only and runnable independently.

```text
business rule / function contract
→ choose inputs and expected outputs
→ write test_... function
→ use assert
→ let pytest discover and run tests
→ interpret PASS / FAIL / ERROR
→ fix code or test as appropriate
→ rerun the suite
```

## Safety and Accuracy

> A passing test suite means the tested expectations passed. It does not prove that a pipeline has no bugs or that every real-world edge case is covered.

> Tests should be deterministic and independent. Avoid relying on live APIs, the current clock, network responses, hidden shared state, or execution order for beginner unit tests.

> Use assertions to check meaningful behaviour, not merely that a function ran. Include normal, boundary, missing-value, and invalid-input cases when the function contract calls for them.

> pytest is an external development dependency, not part of the Python standard library. Install it in an appropriate virtual environment and keep runtime application code independent of pytest.

These examples use synthetic in-memory values only. No network, database, cloud, or file operations are performed by the application functions, tests, or demos. Deliberately failing assertions are shown in Markdown for learning; the committed test suite is intended to pass.

## Quickstart

Run commands **from this Day 070 folder**. Python 3.10+ is used for the example annotations. Create a local virtual environment:

```bash
python -m venv .venv
```

Activate it before running the following commands, or call its Python directly. See [setup instructions](installing-and-running-pytest.md) for Windows and macOS/Linux activation commands.

```bash
python -m pip install -r requirements-dev.txt
python -m pytest --version
python -m pytest --collect-only -q
python -m pytest -q
```

The Day 070 [ignore file](.gitignore) excludes local environments and caches from Git.

## Learning Map

| Resource | Purpose |
|---|---|
| [Revision notes](notes.md) | Contract-to-test mental model |
| [Testing vocabulary](testing-vocabulary.md) | Essential terms |
| [Install and run pytest](installing-and-running-pytest.md) | Isolated setup and commands |
| [Assertions](assertions-and-expected-results.md) | Expected versus actual |
| [Discovery and naming](pytest-discovery-and-naming.md) | What pytest collects |
| [Test structure](test-structure-and-organisation.md) | Package and tests separation |
| [Normal and edge cases](testing-normal-and-edge-cases.md) | Boundary design |
| [Exceptions](testing-exceptions.md) | `pytest.raises` |
| [Failed tests](debugging-failed-tests.md) | Read and repair output |
| [Data Engineering use](pytest-for-data-engineering.md) | Pipeline utility contracts |
| [Cheatsheet](python-pytest-cheatsheet.md) | Commands and patterns |
| [Common mistakes](common-mistakes.md) | Pitfalls and fixes |
| [Real-world examples](real-world-examples.md) | Synthetic test scenarios |
| [Beginner summary](beginner-summary.md) | Recap |
| [Glossary](glossary.md) | Alphabetical reference |
| [Practice questions](practice-questions.md) | Exercises and complete answers |
| [Practice lab](practice-lab.md) | Guided local work |
| [Troubleshooting](troubleshooting-guide.md) | Diagnostic flow |
| [Application package](pipeline_utils/) | Pure functions under test |
| [Test suite](tests/) | Six discoverable pytest modules |
| [Demo scripts](scripts/) | Six stand-alone examples |

Read the guides, inspect the application and tests, run collection and the full suite, then complete the lab. Test selection is useful for diagnosis but a selected subset does not establish the rest passed.

## Navigation

- Previous Day: [Day 069 — Python Error Handling for Pipelines](../day-069-python-error-handling-for-pipelines/)
- Next Day: Day 071 — Python Testing Practice: Fixtures, Parametrization, and Data Pipeline Edge Cases — Coming Soon (provisional)
- [Back to Main Learning Path](../README.md)
