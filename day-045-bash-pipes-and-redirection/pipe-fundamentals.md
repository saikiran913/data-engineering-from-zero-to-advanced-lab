# Pipe Fundamentals

The pipe operator `|` sends stdout from one command into stdin of the next command.

## One Pipe

```bash
cat sample-data/pipeline_log.txt | grep "ERROR"
```

## Better Direct Form When Possible

```bash
grep "ERROR" sample-data/pipeline_log.txt
```

Pipelines should have a reason. If one command can read the file directly, the simpler form may be clearer.

## Multiple Commands

```bash
grep "INFO" sample-data/pipeline_log.txt | wc -l
```

This filters INFO lines and counts them.

## Sort and Unique

```bash
sort sample-data/status_values.txt | uniq
```

`uniq` normally detects adjacent duplicates, so sorting first is common.

## Count Unique Values

```bash
sort sample-data/status_values.txt | uniq | wc -l
```

## Head and Tail in Pipelines

```bash
grep "WARN" sample-data/pipeline_log.txt | head
```

## Pipeline Order

Pipelines flow left to right. Each stage receives text from the previous stage.

## Filtering Early

```text
large input
→ grep relevant lines
→ count or sort later
```

Filtering early can reduce later text processing, but exact performance depends on context.

## Practice Examples

```bash
grep "ERROR" sample-data/pipeline_log.txt
grep "WARN" sample-data/pipeline_log.txt
grep "INFO" sample-data/pipeline_log.txt | wc -l
grep "ERROR" sample-data/pipeline_log.txt | wc -l
grep "WARN" sample-data/pipeline_log.txt | head
tail sample-data/pipeline_log.txt | grep "INFO"
sort sample-data/status_values.txt
sort sample-data/status_values.txt | uniq
sort sample-data/status_values.txt | uniq | wc -l
cut -d',' -f4 sample-data/orders_sample.csv
cut -d',' -f4 sample-data/orders_sample.csv | sort
cut -d',' -f4 sample-data/orders_sample.csv | sort | uniq
```

