# Day 059 — Python Filesystem Basics

Pathlib, paths, directories, text files, CSV, JSON, and safe read-only file handling introduce local structured-file thinking.

## Connect to Day 058

Day 058 taught structured date/time handling. Day 059 moves from in-memory values to local filesystem inspection. Data Engineers receive text, CSV, and JSON files, so safe path handling and correct parser selection are essential.

## Learning Objectives

Learn `pathlib.Path`, current working directory, relative and absolute paths, parent/child paths, portable composition, existence/type checks, path properties, safe directory inspection, context-managed text reading, UTF-8, CSV readers, JSON loading, and basic structure validation.

## Why Filesystem Basics Matter

Common tasks include inspecting an incoming directory, verifying an expected file, identifying suffixes, reading pipeline notes, loading CSV rows, loading JSON configuration, and building portable path logic.

## Important Warnings

> Filesystem paths are environment-specific. Prefer `pathlib.Path` instead of manually concatenating path separators such as `/` or `\`.

> Day 059 is intentionally read-oriented. Do not teach destructive filesystem operations such as deleting, renaming, recursively removing, or overwriting important files.

> `split(",")` is not a reliable CSV parser because valid CSV may contain quoted delimiters, embedded commas, and other edge cases. Use Python's `csv` module for CSV files.

> JSON text is not automatically a Python dictionary or list. Parse JSON using Python's `json` module and validate the resulting structure before using nested values.

## Recommended Learning Order

1. `notes.md`
2. `pathlib-basics.md`
3. `relative-and-absolute-paths.md`
4. `inspecting-files-and-directories.md`
5. `reading-text-files.md`
6. `context-managers-and-encoding.md`
7. `csv-introduction.md`
8. `json-introduction.md`
9. `structured-file-safety.md`
10. `filesystem-patterns-for-data-engineers.md`
11. inspect `sample-data/` and `scripts/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review the cheatsheet and practice questions

## Safe-Learning Note

All scripts are read-only and use synthetic files inside this folder. No deletion, rename, move, cloud access, production data, or external dependency is included.

## Navigation

- Previous Day: [Day 058 - Python Dates and Times](../day-058-python-dates-and-times/)
- Next Day: [Day 060 - Python Reliability Basics](../day-060-python-reliability-and-basic-phase-review/)
- [Back to Main Learning Path](../README.md)
