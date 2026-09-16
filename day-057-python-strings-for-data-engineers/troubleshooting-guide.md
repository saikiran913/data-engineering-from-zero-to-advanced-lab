# Troubleshooting Guide

| Problem | Likely cause | Safer check |
| --- | --- | --- |
| Cleaning appears ineffective | Returned result was not assigned | Save `raw.strip()` |
| `IndexError` after split | Too few parts | Validate count first |
| Status fails comparison | Whitespace, case, or unexpected characters | Inspect raw and canonical values |
| Blank not detected | Whitespace remains | Strip before blank check if allowed |
| `None` causes method error | Method called before missing check | Check `is None` first |
| `find()` gives `-1` | Substring is absent | Use `in` when position is unnecessary |
| Replace changed too much | Rule is too broad | Narrow and test the rule |
| Too many split fields | Delimiter occurs in data | Simple split may be unsuitable |
| Too few split fields | Input is incomplete | Mark record invalid or review |
| Leading zeros disappear | ID converted elsewhere | Keep identifier as string |
| Extension check fails | Case or whitespace mismatch | Strip and normalise controlled value |
| Map returns no result | Variant or normalisation is missing | Review approved map keys |

```text
1. print repr(raw_value)
2. check None
3. inspect len(raw_value)
4. strip if rule allows
5. inspect canonical value
6. validate delimiter/field count
7. preserve raw value
8. test with one small example
```

`repr()` is a useful debugging display because it makes whitespace visible.
