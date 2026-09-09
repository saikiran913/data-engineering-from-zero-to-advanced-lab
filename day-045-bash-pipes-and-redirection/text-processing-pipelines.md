# Text Processing Pipelines

Day 045 uses simple text commands for safe inspection.

## `grep`

`grep` filters matching lines.

```bash
grep "ERROR" sample-data/pipeline_log.txt
grep "COMPLETED" sample-data/status_values.txt
```

## `wc`

`wc` counts lines, words, or bytes. `wc -l` counts lines.

```bash
wc -l sample-data/orders_sample.csv
```

## `sort`

`sort` sorts text lines.

```bash
sort sample-data/status_values.txt
```

## `uniq`

`uniq` normally detects adjacent duplicates.

```bash
sort sample-data/status_values.txt | uniq
```

## `cut`

`cut` selects simple delimited fields.

```bash
cut -d',' -f2 sample-data/orders_sample.csv
```

> `cut` is not a full CSV parser. Quoted commas, embedded delimiters, and multiline fields can break simple delimiter-based logic.

## Combine Commands

```bash
cut -d',' -f4 sample-data/orders_sample.csv | sort | uniq
```

```bash
grep "ERROR" sample-data/pipeline_log.txt | wc -l
```

## Header Caution

The header line may appear in `cut` and sorted results. Remember that line count is not always the same as business row count.

