# Beginner Summary

Data engineering pipelines often begin with files. A text note, a CSV delivery, and a JSON configuration may look simple, but each needs careful handling. First decide whether a file is an input that must be preserved or generated output that the pipeline owns. In this lesson, `sample-data/` is read-only learning input and `output/` is the safe destination for generated results.

Use `pathlib.Path` to build paths and `with` to open files. A context manager closes the file even when an error happens. Specify UTF-8 encoding for text. For CSV, also use `newline=""` and Python's `csv` module. CSV values are text initially, including amounts, so convert and validate them deliberately.

`csv.DictReader` makes each CSV row a dictionary using the header names. Check that required headers exist before processing. A useful validation output retains the source values and adds a clear status such as PASS, REVIEW, or FAIL plus a reason. This makes data quality visible without changing the original delivery.

JSON is useful for configuration and summaries. Read it using `json.load`, write it using `json.dump`, and catch `JSONDecodeError` for malformed files. Valid JSON syntax is only the start: the pipeline should still check for required keys and sensible values.

For every file workflow, follow a simple order: locate, read, parse, validate, write generated output, and verify. Compare row counts, inspect output headers, and record the source file in a summary. These habits make small scripts reliable enough to grow into larger pipelines.
