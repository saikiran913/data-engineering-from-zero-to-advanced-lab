# Day 057 Notes

## Strings in Data Engineering

Strings represent IDs, status codes, filenames, table names, country codes, free text, and raw timestamp text. They are not just display values: an extra space or different case can cause a lookup or validation to fail.

## Strings Are Immutable

```python
raw_status = " ready "
clean_status = raw_status.strip()
```

`raw_status` remains unchanged. Cleaning methods return a new string, so use clear names such as `raw_status`, `clean_status`, and `canonical_status`.

## Standardisation

Canonical representation means choosing one approved output for equivalent controlled inputs.

```text
" ready "  "READY"  "Ready"
→ "READY"
```

Only apply this rule where the business says those values mean the same thing.

## Parsing

```text
raw text
→ split into parts
→ validate part count
→ assign meaning
```

## Data Engineering Mental Model

```text
raw text
→ clean
→ standardise
→ validate
→ parse if needed
→ use downstream
```

Preserve a raw value when source traceability matters. Use simple `split()` only for controlled delimiters without quoting or embedded delimiter rules.
