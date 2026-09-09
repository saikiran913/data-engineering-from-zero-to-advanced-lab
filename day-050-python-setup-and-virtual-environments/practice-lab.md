# Create a Safe Python Project Environment

All activity should remain inside Day 050 or a learner-created disposable project copy.

## Part 1 - Verify Location

```bash
pwd
ls
```

## Part 2 - Check Python

Try:

```bash
python --version
```

If not Python 3 or unavailable, try:

```bash
python3 --version
```

Identify the correct Python 3 command for your system.

## Part 3 - Run First Script

```bash
python scripts/01_hello_python.py
```

or use your Python 3 command:

```bash
python3 scripts/01_hello_python.py
```

## Part 4 - Run Python Info

```bash
python scripts/02_python_info.py
```

## Part 5 - Create venv

```bash
python -m venv .venv
```

Use the correct interpreter command for your system.

## Part 6 - Activate

Linux/macOS:

```bash
source .venv/bin/activate
```

Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Windows Command Prompt:

```text
.venv\Scripts\activate.bat
```

## Part 7 - Verify Interpreter Changed

```bash
python -c "import sys; print(sys.executable)"
```

## Part 8 - Inspect pip

```bash
python -m pip --version
python -m pip list
```

## Part 9 - Run Environment Check

```bash
python scripts/04_environment_check.py
```

## Part 10 - Run Entry-Point Script

```bash
python scripts/03_script_entry_point.py
```

## Part 11 - Inspect Project Template

Review:

- `project-template/README.md`
- `project-template/requirements.txt`
- `project-template/.gitignore`
- `project-template/src/main.py`

## Part 12 - Run Project Template

```bash
python project-template/src/main.py
```

## Part 13 - Deactivate

```bash
deactivate
```

## Part 14 - Recheck Interpreter

Run:

```bash
python -c "import sys; print(sys.executable)"
```

It should return to the previous environment.

## Part 15 - Git Awareness

If running inside a repository:

```bash
git status
```

Confirm `.venv` should not be staged or tracked.

No internet package installation is required for Day 050.

## Lab Checklist

- You know your Python 3 command.
- You can run a script.
- You can create a virtual environment.
- You can activate and deactivate.
- You can inspect the executable.
- You can inspect pip.
- You understand `.venv`.
- You understand the requirements concept.
- Source files remain unchanged.
