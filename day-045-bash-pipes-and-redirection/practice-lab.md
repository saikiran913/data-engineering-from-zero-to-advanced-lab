# Build Safe Bash Pipelines for Data Engineering Files

All exercises must stay inside:

```text
day-045-bash-pipes-and-redirection/
```

Use:

```text
practice-output/
```

as the only write target.

If the directory does not exist, create it safely:

```bash
mkdir -p practice-output
```

## Part 1 - Verify Location

```bash
pwd
ls
```

## Part 2 - Inspect Sample Log

```bash
head sample-data/pipeline_log.txt
tail sample-data/pipeline_log.txt
```

## Part 3 - Count Error Lines

```bash
grep "ERROR" sample-data/pipeline_log.txt | wc -l
```

## Part 4 - Count Warning Lines

```bash
grep "WARN" sample-data/pipeline_log.txt | wc -l
```

## Part 5 - List Unique Statuses

```bash
sort sample-data/status_values.txt | uniq
```

## Part 6 - Count Unique Statuses

```bash
sort sample-data/status_values.txt | uniq | wc -l
```

## Part 7 - Extract Order Status Column

```bash
cut -d',' -f4 sample-data/orders_sample.csv
```

The header line appears in the output. `cut` is only a simple delimiter tool, not a full CSV parser.

## Part 8 - Save Warning Lines

Check output first:

```bash
grep "WARN" sample-data/pipeline_log.txt
```

Then save it to the practice directory:

```bash
grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt
```

## Part 9 - Inspect Saved File

```bash
cat practice-output/warnings.txt
```

## Part 10 - Append a Review Note

```bash
echo "Reviewed warning output" >> practice-output/review_notes.txt
```

## Part 11 - Capture an Error Safely

```bash
cat sample-data/does-not-exist.txt 2> practice-output/errors.txt
```

## Part 12 - Inspect Errors

```bash
cat practice-output/errors.txt
```

## Part 13 - Use `tee`

```bash
grep "INFO" sample-data/pipeline_log.txt | tee practice-output/info_lines.txt
```

## Part 14 - Review Generated Outputs

```bash
ls practice-output
cat practice-output/review_notes.txt
```

## Checklist

- Source files remain unchanged.
- All created files are inside `practice-output/`.
- You understand stdout and stderr.
- You understand overwrite versus append.
- You inspected generated output.

