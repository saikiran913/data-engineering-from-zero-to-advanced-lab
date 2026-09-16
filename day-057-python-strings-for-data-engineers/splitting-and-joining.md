# Splitting and Joining

A delimiter separates fields in a simple controlled string.

```python
raw_record = "ORD-1001|CUST-001|COMPLETED"
parts = raw_record.split("|")
if len(parts) == 3:
    canonical = "|".join(parts)
```

`text.split()` without an argument splits whitespace conceptually. Validate the expected field count before indexing. `ORD-1||PASS` produces an empty middle field, which needs its own validation.

Split and join can form a useful round trip for controlled data. They are not replacements for structured parsers when data can contain quotes, escaped delimiters, embedded delimiters, or nested structures.
