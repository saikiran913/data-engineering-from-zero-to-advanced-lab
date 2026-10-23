# Day 061 Notes

```text
input path → verify → open → parse → validate → transform → write generated output → verify
```

Preserve source first, choose mode deliberately, validate before writing, write only to output, then verify generated artefacts. Parser selection remains simple: text reader for text, `csv` for CSV, and `json` for JSON.

Use `with` for every file operation so files close even if a parse or validation step fails. CSV cells arrive as text; validate conversions explicitly. JSON can be syntactically valid yet miss required configuration keys. Record a row's validation reason and source file instead of silently removing it.
