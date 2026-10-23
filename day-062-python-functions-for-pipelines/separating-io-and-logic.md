# Separating I/O and Logic

Avoid an all-in-one function such as `validate_orders()` that reads a CSV, transforms rows, validates, writes, and prints. It is hard to test and reuse.

Prefer a clear boundary:

```text
read_records(...) → normalize_record(...) → validate_record(...) → write_results(...)
```

Reading and writing are I/O functions. Normalization and validation can be pure logic. An orchestrator calls them in the right order. Day 062 has no file I/O; Day 061 supplies that context, while this day makes the reusable middle stages testable and safe.
