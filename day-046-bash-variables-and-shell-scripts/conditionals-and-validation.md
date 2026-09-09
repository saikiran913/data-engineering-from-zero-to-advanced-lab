# Conditionals and Validation

Validation means checking inputs before a script processes them.

## File Exists

```bash
if [ -f "$input_file" ]; then
    echo "File exists"
else
    echo "File not found" >&2
fi
```

`-f` checks whether a path is a regular file.

## Directory Exists

```bash
if [ -d "$data_dir" ]; then
    echo "Directory exists"
else
    echo "Directory not found" >&2
fi
```

`-d` checks whether a path is a directory.

## File Is Not Empty

```bash
if [ -s "$input_file" ]; then
    echo "File has content"
fi
```

`-s` checks whether a file exists and has a size greater than zero.

## Empty String

```bash
if [ -z "$input_file" ]; then
    echo "Input file is missing" >&2
fi
```

`-z` checks whether a string is empty.

## String Comparison

```bash
status="READY"

if [ "$status" = "READY" ]; then
    echo "Ready to continue"
fi
```

Use simple string comparisons when the meaning is clear.

## Why Validate First?

Validation helps avoid confusing errors, wrong paths, partial output, and unpredictable scripts. A safe script should stop early when required input is missing.

## Exit After Failed Validation

```bash
exit 1
```

A non-zero exit communicates that the script did not complete successfully.

## Practice

1. Check whether `sample-data/orders_sample.csv` is a file.
2. Check whether `sample-data` is a directory.
3. Check whether an input variable is empty.
4. Print a usage message for a missing argument.
5. Exit with `1` after failed validation.
6. Print success only after validation passes.
7. Check whether a log file exists.
8. Check whether a sample file is non-empty.
9. Compare `search_term` with `ERROR`.
10. Explain why validation should happen before `grep`.
11. Explain why validation should happen before a loop.
12. Explain why error messages should go to stderr.
