# Day 046 Notes - Bash Variables and Shell Scripts

## Why Use Variables?

Instead of retyping paths:

```bash
wc -l sample-data/orders_sample.csv
grep "ERROR" sample-data/pipeline_log.txt
```

store them once:

```bash
orders_file="sample-data/orders_sample.csv"
log_file="sample-data/pipeline_log.txt"
```

Then reuse them safely:

```bash
wc -l "$orders_file"
grep "ERROR" "$log_file"
```

Variables reduce typing and make scripts easier to adjust.

## Why Use Scripts?

Scripts help with repeatability, readability, fewer copy-paste errors, parameterisation, validation, and standardised checks. A script should make a small task easier to repeat safely.

## Script Anatomy

```bash
#!/usr/bin/env bash

input_file="sample-data/orders_sample.csv"

echo "Reviewing $input_file"
wc -l "$input_file"
```

The first line names the shell. The variable stores the file path. `echo` prints a message. `wc -l` counts lines. The quoted variable protects the path.

## Comments

```bash
# This is a comment
```

Comments explain intent for future readers.

## Variables

```bash
name="orders"
```

Bash assignment has no spaces around `=`.

## Variable Expansion

```bash
echo "$name"
```

Expansion means Bash replaces `$name` with the stored value.

## Quoting

Double quotes allow expansion and protect spaces:

```bash
echo "$name"
```

Single quotes print literal text:

```bash
echo '$name'
```

Unquoted variables can split into multiple words, so beginners should quote path variables.

## Command Substitution

```bash
line_count=$(wc -l < "$input_file")
```

The command runs first. Its stdout becomes the value stored in `line_count`.

## Arguments

```bash
input_file="$1"
```

`$1` is the first value supplied after the script name.

## Validation

```bash
if [ -f "$input_file" ]; then
    echo "File exists"
fi
```

Validation checks inputs before processing.

## Exit Codes

`0` commonly means success. A non-zero exit code commonly indicates failure. Exact meanings depend on the command or script.

## Repetition

Loops repeat a command for several values:

```bash
for file in "$@"
do
    echo "$file"
done
```

Loops are useful, but they repeat mistakes too.

## Safe Automation Mindset

```text
validate
→ preview
→ run
→ inspect
→ log result
```

Small, readable, read-only scripts are the safest beginner practice.
