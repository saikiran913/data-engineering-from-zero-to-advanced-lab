# Troubleshooting Guide

```text
1. inspect signature
2. inspect arguments
3. inspect input contract
4. inspect returned value
5. inspect return type
6. check hidden globals
7. check input mutation
8. test function directly
9. compose one step at a time
```

| Symptom | Likely cause | Fix |
|---|---|---|
| Unexpected `None` | Parser contract returned invalid marker | Check raw type/value before validation |
| Wrong default | Optional rule is unsuitable | Document and pass explicit value |
| Keyword typo | Parameter name differs | Inspect function signature |
| Missing/extra arguments | Call does not match contract | Use required/keyword arguments correctly |
| Values retained between calls | Mutable default | Use `None` then create a new list |
| Input dictionary changed | Helper mutated it | Return `{**record, ...}` |
| Validation shape differs | Mixed return branches | Always return status/reason dictionary |
| Global rule changes result | Hidden dependency | Pass config explicitly |
| Import fails | Layout/import name is wrong | Run the documented app command |
| Code runs on import | Top-level workflow | Use `if __name__ == "__main__"` |
| Later function gets wrong type | Stage contracts conflict | Test each stage directly |
| Parser hides bad input | Broad fallback | Return `None` and validate it |
