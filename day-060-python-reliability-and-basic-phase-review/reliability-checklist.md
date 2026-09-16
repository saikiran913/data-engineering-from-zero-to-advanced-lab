# Reliability Checklist

Before: confirm interpreter, paths, expected files, and input contract.

During: validate `None`/blank values, convert deliberately, catch only known exceptions, preserve raw values where useful, and report invalid reasons.

Organisation: use small functions, focused modules, a main entry point, no hidden globals, and no broad exception swallowing.

After: summarise counts, surface failures, inspect unexpected cases, and keep sample behaviour deterministic.

```text
validate → attempt → handle → report
```
