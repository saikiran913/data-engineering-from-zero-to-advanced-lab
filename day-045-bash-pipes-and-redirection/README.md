# Day 045 — Bash Pipes and Redirection

Day 045 introduces Bash pipes, stdout, stderr, output redirection, error handling, and safe text pipelines.

Day 044 taught how to navigate and inspect files. Day 045 teaches how to connect commands and control where their output goes. These skills are foundational for logs, shell-based inspection, automation, and future command-line workflows.

Bash pipeline and redirection syntax is not identical to PowerShell. The core idea of passing output between commands is transferable, but command behaviour and object/text handling differ.

## Learning Objectives

By the end of this day, you should understand:

- standard input, standard output, and standard error
- why stdout and stderr are separate
- file descriptors `0`, `1`, and `2` conceptually
- what the pipe operator `|` does
- what `>`, `>>`, `<`, `2>`, `2>>`, and `2>&1` mean conceptually
- why redirection can overwrite files
- why append redirection is useful but can grow files forever
- why command order matters in pipelines
- how `grep`, `wc`, `sort`, `uniq`, and `cut` support simple text inspection
- why `cut` is not a full CSV parser
- how to redirect errors separately from normal output
- how `tee` can display and write output
- why every redirect target should be checked before use
- how Bash pipelines support Data Engineering work

## Why This Matters for Data Engineers

Data Engineers use pipes and redirection to:

- count rows in simple text files
- filter log messages
- inspect recent failures
- combine command output
- write command results into review files
- capture normal output and errors separately
- create simple ad hoc investigation pipelines

## Required Warnings

> The `>` operator can overwrite an existing file. Always check the target path before redirecting output.

> Use a dedicated practice directory for redirection exercises. Never practise by redirecting into important source, configuration, or project files.

> Shell text-processing commands are useful for simple inspection and transformation, but they are not reliable substitutes for proper CSV, JSON, or structured-data parsers when quoting, embedded delimiters, multiline fields, or nested structures are involved.

> Error redirection and combined output can hide important failures if used carelessly. Always inspect captured error output before assuming a command succeeded.

## Recommended Learning Order

1. `notes.md`
2. `standard-streams.md`
3. `pipe-fundamentals.md`
4. `output-redirection.md`
5. `error-redirection.md`
6. `text-processing-pipelines.md`
7. `tee-and-observation.md`
8. `practice-lab.md`
9. `troubleshooting-guide.md`
10. `bash-pipeline-cheatsheet.md`
11. `practice-questions.md`
12. `beginner-summary.md`
13. `glossary.md`

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 045 landing page | 1 |
| `notes.md` | Broad conceptual notes | 2 |
| `standard-streams.md` | stdin, stdout, stderr, and descriptors | 3 |
| `pipe-fundamentals.md` | Pipe operator and command chains | 4 |
| `output-redirection.md` | Safe stdout redirection | 5 |
| `error-redirection.md` | stderr and combined output concepts | 6 |
| `text-processing-pipelines.md` | `grep`, `wc`, `sort`, `uniq`, and `cut` | 7 |
| `tee-and-observation.md` | Displaying and writing output | 8 |
| `practice-lab.md` | Guided safe lab | 9 |
| `troubleshooting-guide.md` | Common problems and fixes | 10 |
| `bash-pipeline-cheatsheet.md` | Quick reference | 11 |
| `common-mistakes.md` | Common mistakes and safer habits | 12 |
| `real-world-examples.md` | Data Engineering scenarios | 13 |
| `beginner-summary.md` | Lesson recap | 14 |
| `glossary.md` | Alphabetical terms | 15 |
| `practice-questions.md` | Exercises and answer key | 16 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| stdin | Standard input |
| stdout | Normal output |
| stderr | Error output |
| Pipe | Sends output of one command into another |
| Redirect | Sends stream output somewhere else |
| Append | Adds to the end of a file |
| Overwrite | Replaces existing file content |
| File descriptor | Number representing a stream |
| Filter | Keep matching text lines |
| Pipeline | Connected command stages |
| `grep` | Filters matching lines |
| `wc` | Counts lines, words, or bytes |
| `sort` | Sorts text lines |
| `uniq` | Collapses adjacent duplicate lines |
| `cut` | Selects simple delimited fields |
| `tee` | Displays output and writes it to a file |

## Safe-Learning Note

All exercises use safe sample files. Redirection targets should stay inside `practice-output/`. Source files must remain unchanged. Complex CSV and JSON parsing remains out of scope.

## Navigation

- Previous Day: [Day 044 - Command Line Fundamentals for Data Engineers](../day-044-command-line-fundamentals/)
- Next Day: [Day 046 - Bash Variables and Shell Scripts](../day-046-bash-variables-and-shell-scripts/)
- [Back to Main Learning Path](../README.md)
