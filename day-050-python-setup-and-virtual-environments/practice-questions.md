# Practice Questions

## Section A - Concept Checks

1. What is Python?
2. Why is Python common in Data Engineering?
3. What is an interpreter?
4. What is a Python executable?
5. Why verify Python 3?
6. What is the REPL?
7. What is a `.py` file?
8. Why are scripts useful?
9. Why does current working directory matter?
10. What is a module conceptually?
11. What is a package?
12. What is a dependency?
13. What is `pip`?
14. Why use `python -m pip`?
15. What is a global environment?
16. What is a project environment?
17. What is a virtual environment?
18. What is `.venv`?
19. What does activation do?
20. What does deactivation do?
21. What is `sys.executable`?
22. What is `sys.version`?
23. What does `pip list` show?
24. What is `requirements.txt`?
25. What is version pinning conceptually?
26. Why avoid global installs?
27. Why not commit `.venv`?
28. Why ignore `__pycache__`?
29. What makes setup reproducible?
30. Why does Day 050 avoid third-party packages?

## Section B - Choose the Command

1. Check Python version with `python`.
2. Check Python version with `python3`.
3. Run `scripts/01_hello_python.py`.
4. Create `.venv` using `python`.
5. Create `.venv` using `python3`.
6. Activate on Linux/macOS.
7. Activate on Windows PowerShell.
8. Activate on Windows Command Prompt.
9. Deactivate environment.
10. Check executable with a one-line Python command.
11. Check pip version.
12. List packages.
13. Start Python REPL.
14. Exit REPL.
15. Find Python on POSIX.
16. Find Python on Windows.
17. Run project template.
18. Show Python version from a script.
19. Conceptually install a documented package later.
20. Conceptually freeze package versions.

## Section C - Cross-Platform Setup

1. Linux system uses `python3`. Which version command?
2. Windows PowerShell creates venv. Which command?
3. macOS activates `.venv`. Which command?
4. PowerShell activates `.venv`. Which command?
5. Command Prompt activates `.venv`. Which command?
6. POSIX finds Python command path. Which command?
7. Windows finds Python command path. Which command?
8. PowerShell blocks activation. What should learner avoid?
9. Git Bash path differs from Windows path. What should learner verify?
10. `python` unavailable but `python3` works. What should learner use?
11. IDE uses different Python. What should learner inspect?
12. Terminal reopened. What must happen again?

## Section D - Predict the Environment

1. `sys.executable` points inside `.venv`. What does this suggest?
2. `python -m pip --version` shows global Python path. What might be wrong?
3. `.venv` appears in `git status`. What should be checked?
4. `python --version` shows Python 2. What should learner do?
5. `python3 --version` shows Python 3. What can learner use?
6. `deactivate` is run. What happens?
7. REPL is closed. Is code saved automatically?
8. `requirements.txt` has no packages. Is Day 050 broken?
9. `pip list` differs between two projects. Why might that be OK?
10. Activation command from PowerShell is pasted into Linux. What happens?
11. Script path is wrong. What error likely appears?
12. `environment_hint` is false. Does it prove no venv is active?

## Section E - Fix the Mistake

1. Learner assumes `python` is always Python 3.
2. Learner runs `pip install` without checking interpreter.
3. Learner commits `.venv`.
4. Learner commits `__pycache__`.
5. Learner puts API key in a script.
6. Learner runs from wrong directory.
7. Learner uses REPL for long reusable workflow.
8. Learner installs heavy packages before basics.
9. Learner copies Linux activation into PowerShell.
10. Learner weakens PowerShell policy casually.
11. Learner treats `requirements.txt` as the environment itself.
12. Learner forgets activation after reopening terminal.
13. Learner's IDE uses different Python.
14. Learner ignores `sys.executable`.
15. Learner adds fake dependency to Day 050.
16. Learner does not document setup steps.
17. Learner installs globally by default.
18. Learner confuses venv with Git branch.

## Section F - Safe or Unsafe?

1. Check Python version before running scripts.
2. Create `.venv` for a project.
3. Commit `.venv`.
4. Run standard-library script.
5. Install unknown package blindly.
6. Use `python -m pip --version`.
7. Put credentials in `requirements.txt`.
8. Add `.venv/` to `.gitignore`.
9. Follow approved installation guidance.
10. Change security policy casually.
11. Run `project-template/src/main.py`.
12. Document no third-party dependencies.

## Section G - Mini Case Study

A learner clones a Python Data Engineering repository. Python is installed. The repository includes `requirements.txt`. `.venv` does not exist yet.

Answer:

1. How should they check Python version?
2. How can they identify the interpreter?
3. How should they create `.venv`?
4. How should they activate it on POSIX?
5. How should they activate it on PowerShell?
6. How should they verify executable?
7. How should they inspect pip?
8. How should documented requirements be installed conceptually?
9. How should they run a simple script?
10. How should they inspect Git status?
11. What confirms `.venv` should be ignored?
12. How should they deactivate?

## Answer Key

### Section A

1. A readable general-purpose programming language.
2. It supports automation, validation, files, APIs, and pipeline utilities.
3. Program that runs Python code.
4. The Python program path being used.
5. To avoid old or wrong Python.
6. Interactive Python prompt.
7. Python script file.
8. Reusable and trackable in Git.
9. Paths are resolved from current location.
10. Importable Python unit conceptually.
11. Reusable installed code.
12. Package a project needs.
13. Python package installer.
14. It aligns pip with selected interpreter.
15. System-wide Python environment.
16. Environment for one project.
17. Isolated project Python environment.
18. Common virtual environment folder.
19. Points current shell at environment.
20. Leaves active environment.
21. Python executable path.
22. Python version details.
23. Installed packages.
24. Dependency documentation file.
25. Recording intended package version.
26. To avoid project conflicts.
27. It is local and reproducible from docs.
28. It is generated cache.
29. Documented Python version, dependencies, setup, and source.
30. Setup comes before external packages.

### Section B

1. `python --version`
2. `python3 --version`
3. `python scripts/01_hello_python.py`
4. `python -m venv .venv`
5. `python3 -m venv .venv`
6. `source .venv/bin/activate`
7. `.venv\Scripts\Activate.ps1`
8. `.venv\Scripts\activate.bat`
9. `deactivate`
10. `python -c "import sys; print(sys.executable)"`
11. `python -m pip --version`
12. `python -m pip list`
13. `python` or `python3`
14. `exit()`
15. `command -v python`
16. `where python`
17. `python project-template/src/main.py`
18. `import sys` then `print(sys.version)`
19. `python -m pip install <package-name>`
20. `python -m pip freeze`

### Section C

1. `python3 --version`.
2. `python -m venv .venv`.
3. `source .venv/bin/activate`.
4. `.venv\Scripts\Activate.ps1`.
5. `.venv\Scripts\activate.bat`.
6. `command -v python`.
7. `where python`.
8. Do not weaken policy casually.
9. Verify active interpreter.
10. `python3`.
11. Interpreter path.
12. Activate again.

### Section D

1. The venv may be active.
2. Activation or interpreter choice may be wrong.
3. `.gitignore`.
4. Use a Python 3 command.
5. Use `python3` for commands.
6. Leaves the active environment.
7. No.
8. No, Day 050 uses standard library only.
9. Separate project environments isolate packages.
10. It likely fails because syntax differs.
11. File or script not found.
12. No; environment names can differ.

### Section E

Use version checks, `python -m pip`, `.gitignore`, standard-library examples, correct working directory, scripts for reusable code, OS-specific activation, approved security guidance, documented setup, project-specific environments, and clear mental models.

### Section F

1. Safe.
2. Safe.
3. Unsafe.
4. Safe.
5. Unsafe.
6. Safe.
7. Unsafe.
8. Safe.
9. Safe.
10. Unsafe.
11. Safe.
12. Safe.

### Section G

1. `python --version` and/or `python3 --version`.
2. `python -c "import sys; print(sys.executable)"`.
3. `python -m venv .venv` with the intended Python 3 command.
4. `source .venv/bin/activate`.
5. `.venv\Scripts\Activate.ps1`.
6. Print `sys.executable`.
7. `python -m pip --version` and `python -m pip list`.
8. `python -m pip install -r requirements.txt` conceptually when requirements are documented.
9. `python script.py` with the correct path.
10. `git status`.
11. `.gitignore` includes `.venv/`.
12. `deactivate`.
