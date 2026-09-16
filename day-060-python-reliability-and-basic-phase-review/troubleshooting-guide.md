# Troubleshooting Guide

| Symptom | Check |
| --- | --- |
| ValueError | Input text cannot convert |
| KeyError | Required key missing/spelled differently |
| IndexError | Sequence too short |
| FileNotFoundError | Path and working directory |
| JSONDecodeError | JSON syntax invalid |
| Import error | Run documented entry point/package layout |
| Main runs on import | Add main guard |
| Unexpected fallback | Review validation contract |

```text
1. read exception type and message
2. inspect input
3. validate contract
4. narrow try block
5. handle known failure
6. report clear outcome
```
