# Validation Versus Exception Handling

Validation checks known rules before an operation; exceptions handle a known operation failure.

```text
missing? → blank? → try conversion → validate range
```

For an amount, check missing/blank text, attempt conversion, then check non-negative range. Fail fast for critical input and use explicit fallback only for recoverable optional input.
