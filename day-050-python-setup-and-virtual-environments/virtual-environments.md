# Virtual Environments

## What Is a Virtual Environment?

A virtual environment is an isolated Python environment for one project.

## Why Use One?

- isolate packages
- reduce conflicts
- support reproducibility
- keep setup project-specific

## Create

Linux/macOS:

```bash
python3 -m venv .venv
```

If `python` is Python 3:

```bash
python -m venv .venv
```

## Activate - Linux/macOS

```bash
source .venv/bin/activate
```

## Activate - PowerShell

```powershell
.venv\Scripts\Activate.ps1
```

## Activate - Command Prompt

```text
.venv\Scripts\activate.bat
```

## Confirm Active Interpreter

```bash
python --version
python -m pip --version
```

Python:

```python
import sys
print(sys.executable)
```

## Deactivate

```bash
deactivate
```

## Do Not Commit `.venv`

`.venv` is machine-specific, can be large, and should be reproducible from documented dependencies.

## Recreate Environment Conceptually

```text
recreate locally when appropriate
→ install documented dependencies
```

Day 050 does not teach environment deletion commands.

## Activation Is Shell-Session Specific

If you close the terminal, activation usually ends. Activate again in the next terminal session.
