# Troubleshooting Guide

```text
1. print collection
2. print type(collection)
3. inspect keys/items
4. check spelling/case
5. check membership
6. distinguish missing vs None
7. inspect nested shape one level at a time
8. verify expected-key set
```

| Symptom | Likely cause | Check |
| --- | --- | --- |
| `KeyError` | Direct lookup used for absent key | Check key spelling and required contract |
| `.get()` returns `None` | Key absent or value is `None` | Test `key in record` |
| Membership looks wrong | Dictionary membership checks keys | Use `.values()` only when intended |
| Value disappeared | Duplicate literal key overwrote it | Inspect the dictionary construction |
| Empty set behaves like dict | `{}` was used | Use `set()` |
| Set cannot be indexed | Sets are unordered collections | Use membership instead |
| Set display order differs | Order is not guaranteed meaning | Do not use positional logic |
| Missing set check is backwards | Difference operands reversed | Use `expected - observed` |
| Nested lookup fails | Parent is absent or not a dictionary | Inspect each level |
| Some records fail | List of dictionaries has inconsistent shape | Validate required keys per record |
| Original changed | Dictionary was mutated | Copy or document the side effect |
| `remove()` fails | Value was absent | Use `discard()` when absence is acceptable |
