# Day 050 Notes - Python Setup and Virtual Environments

## What Is Python?

Python is a readable general-purpose programming language. Data Engineers use it to automate tasks, validate data, work with files, connect tools, and build pipeline utilities.

## Python in Data Engineering

Python can support automation, files, APIs, data pipelines, validation, orchestration, database integration, and cloud integration. Day 050 prepares the environment before those topics become practical.

## Interpreter

```text
Python source code
→ Python interpreter
→ program execution
```

The interpreter is the program that runs Python code.

## Python Version

```bash
python --version
```

or:

```bash
python3 --version
```

Some systems use `python`; others use `python3`. Use whichever command points to the intended Python 3 interpreter.

## REPL

The interactive prompt often looks like:

```text
>>>
```

Example:

```python
print("Hello, Data Engineering")
```

## Script

Save reusable Python code in a `.py` file:

```python
print("Pipeline check started")
```

## Module and Package Concept

A module is an importable Python unit conceptually. A package is reusable code that can be installed for a project.

## pip

`pip` installs Python packages. Prefer:

```bash
python -m pip
```

This ties pip to the selected interpreter.

## Virtual Environment

```text
project A → environment A
project B → environment B
```

Virtual environments isolate dependencies so projects do not fight over package versions.

## `.venv`

`.venv` is a common local folder name for a project virtual environment.

## Reproducibility

Reproducible setup documents Python version, dependency versions, setup steps, and source code.

## Setup Mental Model

```text
Python installed?
→ correct interpreter?
→ create .venv
→ activate
→ confirm executable
→ install only required packages
→ run script
→ document dependencies
```
