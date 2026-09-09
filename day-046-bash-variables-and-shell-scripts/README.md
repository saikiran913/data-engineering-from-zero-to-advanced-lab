# Day 046 — Bash Variables and Shell Scripts

Day 046 introduces Bash variables, quoting, arguments, simple scripts, validation, and safe automation basics.

Day 045 taught how to connect commands with pipes and control output with redirection. Day 046 teaches how to save values in variables and package reusable commands into small scripts. This is the first step toward repeatable command-line workflows.

Windows users can use Git Bash, WSL, or another Bash-compatible environment for these examples. Native PowerShell scripting uses different syntax and is outside Day 046 scope.

## Learning Objectives

By the end of this day, you should understand:

- what a shell variable is
- variable assignment and expansion
- why spaces around `=` change meaning in Bash
- single quotes, double quotes, and unquoted variables
- why quoted path variables are safer
- command substitution with `$(...)`
- shell variables versus environment variables conceptually
- `$0`, `$1`, `$2`, `$#`, `$@`, and `$?`
- comments and the shebang line
- running scripts with `bash script.sh`
- why executable script permission is only a concept today
- exit status, `exit 0`, and non-zero exits
- simple `if` statements
- file tests such as `-f`, `-d`, `-s`, and `-z`
- basic `for` loops
- safe stdout and stderr in scripts
- dry-run and idempotency concepts
- why automation should be reviewed before scheduling

## Why This Matters for Data Engineers

Data Engineers use small scripts to:

- reuse input-file paths
- validate that source files exist
- count records in multiple files
- inspect logs consistently
- parameterise repeated checks
- create reusable local utility scripts
- prepare for future pipeline automation
- reduce copy-paste mistakes

## Required Warnings

> A shell script can repeat a command many times very quickly. Always review the commands and target paths before running automation.

> Quote variable expansions that contain paths or filenames unless you intentionally need shell word splitting or glob expansion.

> Day 046 scripts must not delete, overwrite, rename, or move important files. All practice automation should be read-only or create clearly named outputs inside a dedicated practice directory.

> Do not schedule or deploy beginner scripts to production systems. Test them manually with sample data first and verify their output.

## Recommended Learning Order

1. `notes.md`
2. `bash-variable-basics.md`
3. `quoting-and-expansion.md`
4. `command-substitution.md`
5. `script-structure.md`
6. `script-arguments.md`
7. `conditionals-and-validation.md`
8. `loops-and-repetition.md`
9. `exit-status-and-errors.md`
10. `safe-automation-patterns.md`
11. inspect `scripts/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review `bash-scripting-cheatsheet.md`
15. complete `practice-questions.md`
16. read `beginner-summary.md`
17. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Variable | A named value reused later |
| Expansion | Replacing a variable name with its value |
| Quoting | Protecting text from unwanted splitting |
| Command substitution | Capturing command output into a variable |
| Argument | A value passed to a script |
| Positional parameter | A numbered argument such as `$1` |
| Shebang | First line that names the intended shell |
| Script | A file containing reusable shell commands |
| Conditional | Logic that runs only when a test passes |
| Loop | Repeats commands for several values |
| Exit status | Number reporting success or failure |
| Validation | Checking inputs before processing |
| Safe default | Do nothing risky when inputs are missing |
| Dry run | Show what would happen without changing data |
| Idempotency | Repeated safe runs do not create unexpected changes |

## Files

| File or folder | Purpose |
|---|---|
| `notes.md` | Broad lesson notes |
| `bash-variable-basics.md` | Variable assignment and expansion |
| `quoting-and-expansion.md` | Safe quoting habits |
| `command-substitution.md` | Capturing stdout into variables |
| `script-structure.md` | Beginner script layout |
| `script-arguments.md` | Positional parameters and usage messages |
| `conditionals-and-validation.md` | Safe checks with `if` |
| `loops-and-repetition.md` | Simple repetition |
| `exit-status-and-errors.md` | Exit codes and stderr |
| `safe-automation-patterns.md` | Safe scripting habits |
| `scripts/` | Runnable beginner scripts |
| `sample-data/` | Generic practice data |

## Safe-Learning Note

Scripts are intentionally small. They are read-only or create outputs only inside safe practice locations. No file deletion or production automation is included. Run scripts with `bash script-name.sh`.

## Navigation

- Previous Day: [Day 045 - Bash Pipes and Redirection](../day-045-bash-pipes-and-redirection/)
- Next Day: [Day 047 - Git Fundamentals](../day-047-git-fundamentals/)
- [Back to Main Learning Path](../README.md)
