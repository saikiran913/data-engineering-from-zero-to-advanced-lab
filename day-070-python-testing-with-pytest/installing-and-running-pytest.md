# Installing and Running pytest

Run commands **from `day-070-python-testing-with-pytest/`**. Use Python 3.10 or newer. Pytest is a development dependency, not part of the standard library; the application package and stand-alone demos do not import it.

```bash
python --version
python -m venv .venv
```

Activate the local environment:

| Shell | Activation command |
|---|---|
| Windows PowerShell | `.\.venv\Scripts\Activate.ps1` |
| macOS/Linux sh or bash | `source .venv/bin/activate` |

Activation is optional: run `.\.venv\Scripts\python.exe` on Windows or `.venv/bin/python` on macOS/Linux directly. After activation, use the selected environment's Python for both install and test commands:

```bash
python -m pip install -r requirements-dev.txt
python -m pytest --version
python -m pytest --collect-only -q
python -m pytest -q
python -m pytest -v
python -m pytest -q tests/test_cleaning.py
python -m pytest -q tests/test_cleaning.py::test_normalize_status_trims_and_uppercases
python -m pytest -q -k amount
```

`python -m pytest` uses the selected Python environment. `--collect-only` lists found tests without executing them; `-q` is quieter; `-v` gives more detail. A file path, exact `::test_function` node, or `-k` expression runs a **subset**. Finish with `python -m pytest -q` to check the whole suite. Avoid mixing a global pytest installation with a virtual environment's Python. The local `.venv/`, `.pytest_cache/`, and `__pycache__/` are ignored by this lesson's `.gitignore`.
