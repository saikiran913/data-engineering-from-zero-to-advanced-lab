# Build Safe Reusable Bash Scripts for Data Engineering Files

All exercises must remain inside:

```text
day-046-bash-variables-and-shell-scripts/
```

Use the provided `scripts/` and `sample-data/`.

No deletion. No permission changes required.

## Part 1 - Verify Location

```bash
pwd
ls
```

## Part 2 - Run Variable Demo

```bash
bash scripts/01-show-variable.sh
```

## Part 3 - Count Order Lines

```bash
bash scripts/02-count-lines.sh sample-data/orders_sample.csv
```

## Part 4 - Test Missing Argument

```bash
bash scripts/02-count-lines.sh
```

Observe the stderr message and non-zero exit behaviour.

## Part 5 - Filter ERROR

```bash
bash scripts/03-filter-log.sh sample-data/pipeline_log.txt ERROR
```

## Part 6 - Filter WARN

```bash
bash scripts/03-filter-log.sh sample-data/pipeline_log.txt WARN
```

## Part 7 - Validate File

```bash
bash scripts/04-validate-input-file.sh sample-data/customers_sample.csv
```

## Part 8 - Test Missing File

```bash
bash scripts/04-validate-input-file.sh sample-data/does-not-exist.csv
```

## Part 9 - Review Multiple Files

```bash
bash scripts/05-review-multiple-files.sh \
    sample-data/customers_sample.csv \
    sample-data/orders_sample.csv
```

## Part 10 - Run Safe Summary

```bash
bash scripts/06-safe-summary.sh sample-data
```

## Part 11 - Redirect Summary Manually

```bash
mkdir -p practice-output
bash scripts/06-safe-summary.sh sample-data > practice-output/summary.txt
```

## Part 12 - Inspect Summary

```bash
cat practice-output/summary.txt
```

## Part 13 - Change a Variable Conceptually

Create your own practice copy if you want to experiment. Do not change repository source files unless you intentionally make a separate practice copy.

## Lab Checklist

- You understand assignment.
- You understand quoting.
- You understand arguments.
- You understand file validation.
- You understand exit codes.
- You understand loops.
- You can run scripts with `bash`.
- No source data changed.
