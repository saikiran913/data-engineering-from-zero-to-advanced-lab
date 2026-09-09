# Beginner Summary

## What Learners Should Remember

Variables store reusable values. Instead of typing the same file path many times, you can store it once:

```bash
input_file="sample-data/orders_sample.csv"
```

Bash assignment has no spaces around `=`. The value is read with `$input_file`, and beginners should usually quote it:

```bash
wc -l "$input_file"
```

Quotes matter. Double quotes allow variable expansion while protecting spaces. Single quotes preserve literal text. Unquoted variables can split into multiple words or expand wildcard characters, so unquoted path variables are risky.

Command substitution captures stdout from a command:

```bash
line_count=$(wc -l < "$input_file")
```

Scripts package commands into reusable workflows. A script may define inputs, validate them, run safe commands, and print a clear summary. `$1` is the first argument, `$#` is the argument count, and `$@` represents all positional arguments.

Validation should happen before processing. Use `-f` for files, `-d` for directories, `-s` for non-empty files, and `-z` for empty strings. If validation fails, print a helpful error to stderr and exit with a non-zero code.

Exit code `0` commonly means success. A non-zero exit code commonly means failure. Error messages belong on stderr so normal output and failure messages can be handled separately.

Loops repeat commands. They are useful for reviewing several files, but they also magnify mistakes. Quote loop variables and keep beginner loops read-only.

All Day 046 scripts remain safe and non-destructive. They read sample files, validate inputs, print summaries, and avoid production scheduling or system configuration.

## Mental Model

```text
Define inputs
→ store values
→ validate
→ run safe commands
→ inspect output
→ report success/failure
```

## Required Warnings

> A shell script can repeat a command many times very quickly. Always review the commands and target paths before running automation.

> Quote variable expansions that contain paths or filenames unless you intentionally need shell word splitting or glob expansion.

> Day 046 scripts must not delete, overwrite, rename, or move important files. All practice automation should be read-only or create clearly named outputs inside a dedicated practice directory.

> Do not schedule or deploy beginner scripts to production systems. Test them manually with sample data first and verify their output.

## Next Day Preview

**Day 047 — Bash Text Processing for Data Engineers: grep, cut, sort, uniq, wc, and Simple Log Investigation**

Day 047 will deepen shell-based text inspection and log analysis while keeping complex CSV and JSON parsing out of shell.
