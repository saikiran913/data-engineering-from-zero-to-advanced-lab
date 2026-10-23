# Pure Functions and Side Effects

A pure function depends only on its parameters and returns the same output for the same input. It does not print, change a global value, change an input dictionary, or perform I/O. This deterministic behaviour makes direct tests simple.

```python
def normalize_status(raw_status):
    return raw_status.strip().upper() if isinstance(raw_status, str) else None
```

Calling it twice gives the same result, so it is also idempotent: normalizing `" READY "` and then normalizing `"READY"` both lead to `"READY"`.

| Behaviour | Pure? | Why |
|---|---|---|
| Return an upper-case string | Yes | No external change |
| Print a warning | No | Observable output side effect |
| Write a file | No | Changes storage |
| Read hidden global configuration | No | Dependency is invisible |

Keep side effects in a thin orchestration layer. Pure logic can then be reused for files, APIs, or tests without changing its contract.
