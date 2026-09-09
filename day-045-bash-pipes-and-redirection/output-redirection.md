# Output Redirection

Output redirection sends stdout to a file.

## `>` Overwrites

The `>` operator can overwrite an existing file. Always check the target path first.

```bash
echo "Pipeline review" > practice-output/review.txt
```

## `>>` Appends

The `>>` operator adds output to the end of a file.

```bash
echo "Second line" >> practice-output/review.txt
```

Appending is useful for notes or logs, but files can grow forever if appends are never reviewed.

## Redirect Command Output

```bash
grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt
```

## Redirect Count Result

```bash
wc -l sample-data/orders_sample.csv > practice-output/order_line_count.txt
```

## Input Redirection

```bash
wc -l < sample-data/orders_sample.csv
```

This sends the file into stdin. Passing the file as an argument is often clearer:

```bash
wc -l sample-data/orders_sample.csv
```

## Safe Target-Path Workflow

1. `pwd`
2. `ls`
3. verify `practice-output`
4. run command without redirect
5. redirect
6. inspect result

## Source-Protection Warning

Never redirect into the same source file in Day 045.

Dangerous pattern:

```bash
sort file.txt > file.txt
```

This can damage the source because the target may be opened for writing before the command finishes reading.

