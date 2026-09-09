# Python Setup Cheatsheet

## Check Python

```bash
python --version
python3 --version
```

## Run Script

```bash
python script.py
```

## Create venv

```bash
python -m venv .venv
```

## Activate POSIX

```bash
source .venv/bin/activate
```

## Activate PowerShell

```powershell
.venv\Scripts\Activate.ps1
```

## Check Executable

```bash
python -c "import sys; print(sys.executable)"
```

## Check pip

```bash
python -m pip --version
```

## List Packages

```bash
python -m pip list
```

## Deactivate

```bash
deactivate
```

## Git Ignore

```text
.venv/
__pycache__/
*.pyc
```
