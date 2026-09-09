# Beginner Summary

## What Learners Should Remember

Python is common in Data Engineering because it is useful for automation, validation, files, APIs, pipeline utilities, and orchestration. The interpreter runs Python code, so learners should verify Python 3 before starting.

The REPL is useful for quick experiments. `.py` files are reusable scripts that can be version-controlled. Current working directory and script paths matter when running scripts from a terminal.

Packages are reusable external code. Dependencies belong to projects. `python -m pip` helps align pip with the intended interpreter, which reduces confusion when more than one Python exists.

Virtual environments isolate project dependencies. `.venv` is a common project-local environment name. Activation syntax differs by operating system, and activation affects only the current shell session. Check `sys.executable` when environment confusion occurs.

Virtual environments are local artifacts, not source code. Do not commit `.venv`. Document dependencies in files such as `requirements.txt` instead.

Day 050 uses the Python standard library only. Python language fundamentals begin next.

## Mental Model

```text
Choose interpreter
→ Create environment
→ Activate
→ Verify
→ Run script
→ Document setup
→ Deactivate
```

## Required Warnings

> Use Python 3 and verify which interpreter is active before installing packages or running project scripts.

> Prefer a project-specific virtual environment instead of installing learning dependencies globally.

> Do not commit `.venv/`, credentials, API keys, local secrets, or machine-specific configuration into Git.

> Dependency commands and activation syntax differ across operating systems. Verify your active interpreter and environment before installing or running packages.

## Next Day Preview

**Day 051 — Python Basics for Data Engineers: Variables, Data Types, Operators, and Simple Expressions**

Day 051 will begin Python language fundamentals now that the environment is ready.
