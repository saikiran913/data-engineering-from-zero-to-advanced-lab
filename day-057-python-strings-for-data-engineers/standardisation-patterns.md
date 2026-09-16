# Standardisation Patterns

Use a business-approved lookup map for accepted variants.

```python
status_map = {
    "complete": "COMPLETED",
    "completed": "COMPLETED",
    "done": "COMPLETED",
}
raw_status = " Done "
canonical_status = status_map.get(raw_status.strip().lower())
```

A mapping is not universal truth. Document its input meaning, transformations, accepted variants, canonical output, missing-value rule, and invalid-value rule. A set can hold allowed canonical values.

For traceability, preserve a raw source value where needed and derive a separate canonical value. Separator, prefix, and suffix rules must be similarly specific. Never invent a mapping just because two values look similar.
