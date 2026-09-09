# Python Scripts

## Script File

```text
scripts/01_hello_python.py
```

A `.py` file stores reusable Python code.

## Run Script

```bash
python scripts/01_hello_python.py
```

or:

```bash
python3 scripts/01_hello_python.py
```

Use the command that points to your intended Python 3 interpreter.

## Current Working Directory Matters

The script path is interpreted from your current terminal location. This connects back to Day 044 path skills.

## Comments

```python
# This is a comment
```

## Script Entry Point

```python
def main():
    print("Script entry point is working")


if __name__ == "__main__":
    main()
```

This is a common structure. Full function learning comes later.

## Why Scripts Matter

Scripts are reusable, version-controlled, testable later, and automatable later.
