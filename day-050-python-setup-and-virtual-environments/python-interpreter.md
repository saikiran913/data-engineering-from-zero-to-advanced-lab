# Python Interpreter

## Verify Version

```bash
python --version
python3 --version
```

Use the command that points to Python 3 on your system.

## Start Interpreter

```bash
python
```

or:

```bash
python3
```

## Exit Interpreter

```python
exit()
```

Some terminals also support keyboard shortcuts, but `exit()` is easy to remember.

## Interpreter Versus Script

| Interpreter / REPL | Script |
|---|---|
| Quick interactive checks | Reusable file |
| Good for tiny experiments | Good for project logic |
| Not ideal for long workflows | Can be version-controlled |

## Inspect Version in Python

```python
import sys
print(sys.version)
```

## Inspect Executable

```python
import sys
print(sys.executable)
```

This matters because virtual environments change which Python executable is active.
