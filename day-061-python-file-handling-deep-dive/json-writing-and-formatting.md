# JSON Writing and Formatting

Use JSON for small configuration files, summaries, and structured audit information. `json.dump()` writes Python data to an open file.

```python
summary = {"total_rows": 12, "pass_rows": 8, "fail_rows": 3, "review_rows": 1}
with Path("output/validation_summary.json").open("w", encoding="utf-8") as file:
    json.dump(summary, file, indent=2)
```

`indent=2` makes output easier for a person to inspect. JSON object keys should be stable, descriptive, and documented. Reopen generated JSON with `json.load()` after writing to prove it can be parsed.

Do not hand-build JSON using string concatenation. The JSON module safely handles quotation marks, escaping, and valid formatting.
