# Troubleshooting Guide

```text
read signature and docstring → inspect actual input → validate/convert input
→ inspect actual return → compare contract → isolate one function
```

| Symptom | Likely cause | First response |
|---|---|---|
| Annotation appears but wrong value is accepted | Hints are not runtime checks | Add parsing and validation |
| `TypeError` using raw input | Text compared with number | Convert before comparison |
| `AttributeError` on `None` | Optional value used as string | Check `None` before `.strip()` |
| `KeyError` for record field | Missing dictionary key | Check required keys or use deliberate `.get()` |
| Unexpected `None` result | Branch returns nothing or parser signals failure | Inspect every return path |
| Tuple in one branch, dictionary in another | Inconsistent return contract | Pick one shape |
| Docstring differs from output | Code or text became stale | Update both after verifying behaviour |
| List vs tuple hint mismatch | Annotation does not match actual collection | Correct hint or return |
| `TypedDict` did not reject bad data | It is a static hint | Add runtime shape checks |
| Python older than 3.10 rejects `|` | Union syntax needs 3.10+ | Use the specified runtime |
| Imported helper runs workflow | Top-level code executes on import | Put workflow in guarded `main()` |
| Refactor changes classifications | Business branch moved or reordered | Compare small known cases step by step |
