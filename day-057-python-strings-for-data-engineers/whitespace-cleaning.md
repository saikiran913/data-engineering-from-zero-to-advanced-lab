# Whitespace Cleaning

`strip()` removes whitespace from both edges. `lstrip()` removes the left edge and `rstrip()` removes the right edge.

```python
raw = "  COMPLETED  "
clean = raw.strip()
left_clean = raw.lstrip()
right_clean = raw.rstrip()
```

`strip()` does not remove internal spaces. This matters because internal spaces in names, descriptions, or meaningful codes may need to stay.

```python
raw_value = "   "
clean_value = raw_value.strip()
is_blank = clean_value == ""
```

Whitespace can break status comparisons, joins, lookups, and required-field checks. Do not remove all spaces blindly: use a documented business rule.

## Practice

1. Strip a status. 2. Left-strip a filename. 3. Right-strip a code. 4. Check blank after strip. 5. Preserve an internal name space. 6. Compare raw and cleaned. 7. Retain a source value. 8. Clean a country code. 9. Explain edge whitespace. 10. Explain internal whitespace. 11. Check an empty string. 12. Check whitespace-only text. 13. Avoid removing code punctuation. 14. Name raw and clean variables clearly.
