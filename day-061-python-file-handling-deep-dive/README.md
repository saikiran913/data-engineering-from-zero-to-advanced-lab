# Day 061 — Python File Handling Deep Dive

Text, CSV, JSON, context managers, and safe read/write workflows extend the filesystem foundations into controlled beginner file processing.

Day 059 introduced read-only files and Day 060 added reliability and reusable code. Day 061 combines both: preserve source data, parse correctly, validate in memory, and write only generated outputs.

## Learning Goals

By the end of this day, you can safely read and write UTF-8 text files, parse CSV with the standard library, parse and format JSON, use context managers, validate basic file content, and preserve source data while producing auditable outputs.

## Why File Handling Matters

Many pipelines begin with a scheduled file delivery, a small configuration file, or a plain-text operational note. The difficult part is not merely opening a file: it is knowing which data must remain unchanged, checking that a delivery is usable, and leaving a clear generated result for the next step.

## Warnings

> Opening a file with `"w"` truncates the existing file before writing. Never use write mode on an important source file unless overwriting is explicitly intended.

> Keep raw input files separate from generated output files. A safe Data Engineering workflow should avoid modifying source data in place during beginner practice.

> CSV and JSON parsers return Python values, but parsed data still requires validation. Correct syntax does not guarantee correct business meaning or correct types.

> Context managers close files automatically, but they do not make unsafe write logic safe. Path choice, file mode, validation, and overwrite rules still matter.

## Safety Model

```text
locate input → verify → parse → validate → transform → write generated output → verify
```

All sources are synthetic and read-only. Scripts write only below `output/`; no files are deleted, renamed, or written outside this Day 061 folder.

## Recommended Learning Order

1. Read [notes.md](notes.md), [file-modes-and-safety.md](file-modes-and-safety.md), and [context-managers-deep-dive.md](context-managers-deep-dive.md).
2. Work through text, CSV, and JSON reading and writing guides.
3. Run the numbered scripts in `scripts/` from 01 through 06.
4. Inspect only generated files in `output/`.
5. Complete [practice-lab.md](practice-lab.md) and [practice-questions.md](practice-questions.md).

## Lesson Files

| Area | Files |
|---|---|
| Text | `reading-text-files.md`, `writing-text-files-safely.md` |
| CSV | `csv-reading-deep-dive.md`, `csv-writing-and-validation.md` |
| JSON | `json-reading-deep-dive.md`, `json-writing-and-formatting.md` |
| Safety | `file-errors-and-recovery.md`, `troubleshooting-guide.md`, `common-mistakes.md` |
| Reuse and revision | `reusable-file-processing-patterns.md`, `python-file-handling-cheatsheet.md`, `glossary.md` |
| Practice | `real-world-examples.md`, `practice-questions.md`, `practice-lab.md` |

This day uses only Python's standard library: `pathlib`, `csv`, and `json`.

## Navigation

- Previous Day: [Day 060 - Python Reliability Basics](../day-060-python-reliability-and-basic-phase-review/)
- Next Day: [Day 062 - Python Functions for Pipelines: Parameters, Return Values, Pure Logic, and Reuse](../day-062-python-functions-for-pipelines/)
- [Back to Main Learning Path](../README.md)
