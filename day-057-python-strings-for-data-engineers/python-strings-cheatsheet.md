# Python Strings Cheatsheet

```python
value.strip()
value.lstrip()
value.rstrip()
value.lower()
value.upper()
value.replace("-", "_")
"ERROR" in value
value.startswith("orders_")
value.endswith(".csv")
parts = value.split("|")
combined = "|".join(parts)
message = f"Source: {source_name}"
```

```text
None?
→ strip
→ blank?
→ standardise
→ validate
```

Remember: strings are immutable, so save each cleaned result. Use `split()` only for simple controlled delimiters and validate the number of parts before indexing.
