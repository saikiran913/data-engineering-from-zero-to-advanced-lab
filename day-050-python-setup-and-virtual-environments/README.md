# Day 050 — Python for Data Engineers

Day 050 introduces the Python interpreter, scripts, virtual environments, dependency isolation, and reproducible setup.

Day 049 completed the initial Git collaboration foundation. Day 050 begins Python. Command-line and Git knowledge now helps learners create isolated, reproducible Python projects.

## Learning Objectives

By the end of this day, you should understand:

- what Python is and why it is common in Data Engineering
- Python interpreter, executable, version, and Python 3
- REPL and interactive interpreter concepts
- `.py` script files and running scripts from the terminal
- current working directory and script paths
- modules, packages, dependencies, and `pip` conceptually
- why `python -m pip` can be clearer than plain `pip`
- system/global environment versus project environment
- virtual environments and `.venv`
- activation and deactivation
- interpreter and package isolation
- checking `sys.executable` and `sys.version`
- `requirements.txt` and pinning concepts
- why `.venv/` should not normally be committed to Git
- why reproducible setup matters for Data Engineering

## Why Python Matters for Data Engineers

Python is used for data ingestion, transformations, orchestration, API integration, validation, automation, cloud SDKs, file processing, data quality, and pipeline utilities. Day 050 keeps these examples conceptual so the environment is ready before business logic begins.

## Required Warnings

> Use Python 3 and verify which interpreter is active before installing packages or running project scripts.

> Prefer a project-specific virtual environment instead of installing learning dependencies globally.

> Do not commit `.venv/`, credentials, API keys, local secrets, or machine-specific configuration into Git.

> Dependency commands and activation syntax differ across operating systems. Verify your active interpreter and environment before installing or running packages.

## Recommended Learning Order

1. `notes.md`
2. `why-python-for-data-engineering.md`
3. `python-interpreter.md`
4. `python-repl.md`
5. `python-scripts.md`
6. `python-path-and-executable.md`
7. `packages-and-pip.md`
8. `virtual-environments.md`
9. `cross-platform-setup.md`
10. `reproducible-python-environments.md`
11. inspect `scripts/`
12. inspect `project-template/`
13. complete `practice-lab.md`
14. use `troubleshooting-guide.md`
15. review `python-setup-cheatsheet.md`
16. complete `practice-questions.md`
17. read `beginner-summary.md`
18. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Python | General-purpose programming language |
| Interpreter | Program that runs Python code |
| REPL | Interactive prompt for tiny experiments |
| Script | Reusable `.py` file |
| Module | Python file or importable unit conceptually |
| Package | Reusable code installed for a project |
| pip | Python package installer |
| Dependency | Package a project needs |
| Virtual environment | Isolated project Python environment |
| `.venv` | Common local folder name for a virtual environment |
| Activation | Point current shell at the environment |
| Deactivation | Leave the active environment |
| Executable | Python program path being used |
| Project environment | Environment for one project |
| Requirements file | Text file documenting dependencies |
| Reproducibility | Ability to recreate setup reliably |

## Safe-Learning Note

No external dependencies are required for Day 050. Examples use standard Python only. `.venv` should remain local and ignored. No credentials, secrets, or production environment setup are included.

## Navigation

- Previous Day: [Day 049 - Git Remote Workflows](../day-049-git-remote-workflows/)
- Next Day: [Day 051 - Python Variables and Data Types](../day-051-python-variables-and-data-types/)
- [Back to Main Learning Path](../README.md)
