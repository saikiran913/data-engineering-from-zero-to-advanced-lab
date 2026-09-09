# Python Path and Executable

## Which Command Is Being Used?

Linux/macOS:

```bash
command -v python
command -v python3
```

Optional:

```bash
which python
```

Windows PowerShell:

```powershell
where python
```

## Python Executable From Python

```python
import sys
print(sys.executable)
```

## Before Activation vs After Activation

Before activation, Python may point to a global or system interpreter. After activation, it should normally point inside the project environment.

## Current Working Directory

```python
import os
print(os.getcwd())
```

This is setup inspection, not file-processing logic.

## Common Confusion

- shell finds a different Python than expected
- IDE uses another Python
- `pip` belongs to another interpreter

Reinforce the pip check:

```bash
python -m pip --version
```
