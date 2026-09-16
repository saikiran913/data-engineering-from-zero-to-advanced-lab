# Real-World Examples

| Situation | Reliability habit |
| --- | --- |
| Missing source file | Check path and handle FileNotFoundError |
| Invalid record count | Validate then catch ValueError |
| Optional note | Explicit fallback |
| Required order ID | Report clearly |
| Bad JSON | Handle JSONDecodeError |
| CSV header typo | Validate headers |
| Blank amount | REVIEW outcome |
| Negative amount | FAIL outcome |
| Shared rule | Validator module |
| Shared format | Formatter module |
| CSV parsing | Parser module |
| Entry script | Main guard |
| Imported helper | No top-level workflow |
| Date freshness | Compatible datetimes |
| Status cleaning | Raw/canonical values |
| Phase workflow | Parse, validate, summarise |
