# Common File-Handling Mistakes

| # | Mistake | Safer approach |
|---|---|---|
| 1 | Hard-coding a private path | Build paths from the script location |
| 2 | Opening without `with` | Use a context manager |
| 3 | Omitting encoding | Use UTF-8 explicitly |
| 4 | Using `w` on an input | Write only to `output/` |
| 5 | Appending on every rerun | Decide whether `a` is truly required |
| 6 | Splitting CSV text by commas | Use `csv.reader` or `DictReader` |
| 7 | Ignoring quoted CSV fields | Let the CSV module parse them |
| 8 | Assuming a header exists | Check `fieldnames` |
| 9 | Assuming headers match | Validate required columns |
| 10 | Using `SELECT`-style thinking for rows | Inspect each parsed dictionary |
| 11 | Converting an amount without error handling | Catch `ValueError` |
| 12 | Treating blank text as valid | Use `.strip()` for required fields |
| 13 | Losing row numbers | Use `enumerate(..., start=2)` |
| 14 | Dropping invalid rows silently | Keep a status and reason |
| 15 | Rewriting the source to clean it | Produce a separate generated file |
| 16 | Relying on column dictionary order | Specify CSV `fieldnames` |
| 17 | Writing extra DictWriter keys | Align the output dictionary and fields |
| 18 | Forgetting `newline=""` for CSV | Include it in CSV open calls |
| 19 | Hand-building JSON | Use `json.dump` |
| 20 | Parsing JSON without error handling | Catch `JSONDecodeError` |
| 21 | Trusting valid JSON content | Validate expected keys |
| 22 | Hiding parsing errors | Report file and reason |
| 23 | Treating malformed input as empty | Stop or quarantine it |
| 24 | Using relative paths from an unknown cwd | Resolve paths from `__file__` |
| 25 | Reading huge files with `.read()` | Iterate line by line when suitable |
| 26 | Removing meaningful spaces | Choose `rstrip()` or `strip()` intentionally |
| 27 | Forgetting the final newline | Add it deliberately for line-oriented output |
| 28 | Assuming date text is valid | Validate date format separately |
| 29 | Treating status case as identical without normalising | Use `.strip().upper()` |
| 30 | Mixing parsing and writing in one loop | Separate stages when possible |
| 31 | No output verification | Reopen output and inspect it |
| 32 | No row-count reconciliation | Compare input and output counts |
| 33 | Overwriting an audit file | Use meaningful names or controlled append logic |
| 34 | Creating output folders implicitly in unknown places | Use a reviewed day-level output directory |
| 35 | Ignoring file permissions | Handle `PermissionError` clearly |
| 36 | Calling every error a bad row | Distinguish file, schema, and value errors |
| 37 | Accepting changed schema silently | Fail fast on missing required columns |
| 38 | Mixing business rules with path logic | Keep rules in functions/configuration |
| 39 | Forgetting source provenance | Store the source filename in summaries |
| 40 | Using broad exception handling | Catch expected exception types |
| 41 | Assuming CSV types are numeric | Remember all CSV cells begin as strings |
| 42 | Retrying destructive writes automatically | Inspect before retrying |
