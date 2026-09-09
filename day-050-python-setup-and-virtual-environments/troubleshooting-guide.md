# Troubleshooting Guide

## Troubleshooting Flow

```text
1. pwd
2. python --version / python3 --version
3. inspect sys.executable
4. check activation
5. python -m pip --version
6. inspect script path
7. inspect .gitignore
8. rerun simple environment check
```

## `python: command not found`

Python may not be installed, the command may be `python3`, or PATH may not include Python. Follow operating-system or organisation installation guidance.

## Wrong Python Version

Use whichever command points to Python 3 on your system.

## `python3` Works but `python` Does Not

This is normal on some systems. Use `python3` consistently for Day 050 commands.

## venv Creation Fails

Possible reasons include missing venv support in the Python installation or organisation restrictions. Follow platform guidance. Day 050 does not provide package-manager install commands.

## Activation Command Not Found

You may be using the wrong operating-system syntax. Use the cross-platform setup table.

## PowerShell Blocks Activation

This may be an execution policy or security setting. Do not weaken policy casually. Follow approved guidance.

## `pip` Not Found

Use:

```bash
python -m pip --version
```

## pip Belongs to Wrong Interpreter

Check:

```bash
python -m pip --version
python -c "import sys; print(sys.executable)"
```

## Script Not Found

Check current directory and script path.

## Wrong Working Directory

Use `pwd` and `ls` before running scripts.

## Module Not Found

This usually means dependency or environment mismatch. Day 050 scripts use only the standard library.

## `.venv` Appears in Git Status

Check `.gitignore`. `.venv/` should not normally be committed.

## Python Executable Unchanged After Activation

Activation may have failed, or the shell may not be using the environment. Recheck activation syntax.

## Terminal Reopened and venv No Longer Active

Activation is session-specific. Activate again in the new terminal.

## IDE Uses Different Interpreter

Configure the IDE to use the intended project interpreter. Exact IDE steps are outside Day 050.
