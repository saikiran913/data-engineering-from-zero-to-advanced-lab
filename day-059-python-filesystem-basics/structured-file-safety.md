# Structured File Safety

```text
.txt → text reader
.csv → csv module
.json → json module
```

An extension is a hint, not proof. Check file existence and type. CSV may have quoted delimiters, missing/extra columns, blanks, and text values. JSON may be malformed, have an unexpected root type, miss keys, contain `null`, or contain nested shapes. Preserve source files in this read-only lesson and never use destructive correction.
