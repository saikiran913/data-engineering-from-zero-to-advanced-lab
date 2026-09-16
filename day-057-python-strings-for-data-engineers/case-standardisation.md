# Case Standardisation

`lower()` and `upper()` return lower- and upper-case versions of a string.

```python
raw_status = " completed "
canonical_status = raw_status.strip().upper()
```

For a controlled status or country code, `uk`, `UK`, and `Uk` may all become `UK` when the contract says they are equivalent. `title()` can improve display text conceptually, but title case is not a universal cleaning rule. `casefold()` supports stronger case-insensitive comparison conceptually; beginner examples should normally use `lower()` or `upper()`.

Do not change user-facing free text, case-sensitive IDs, or display names without a justified rule. Canonicalisation should preserve meaning and be repeatable.
