# Script Structure

## Recommended Template

```bash
#!/usr/bin/env bash

# Purpose:
# Safely count lines in a sample file.

input_file="sample-data/orders_sample.csv"

echo "Input file: $input_file"
wc -l "$input_file"
```

## Shebang

```bash
#!/usr/bin/env bash
```

The shebang names the intended shell when a script is run directly. Day 046 still runs scripts with `bash script-name.sh` to avoid permission-management exercises.

## Comments

Comments explain the purpose and make scripts easier to review.

## Configuration Section

Variables near the top make a script easier to adjust:

```bash
input_file="sample-data/orders_sample.csv"
```

## Validation Section

Validation checks whether required inputs exist before the main work begins.

## Main Logic

Main logic does the small task: count lines, filter logs, or print a summary.

## Summary Output

Scripts should print clear output so the learner can inspect results.

## Running

Preferred in Day 046:

```bash
bash scripts/02-count-lines.sh sample-data/orders_sample.csv
```

Running with `./script.sh` requires executable permission. That idea is mentioned only conceptually today.

## Naming

Use clear names:

- `count-lines.sh`
- `filter-log.sh`
- `validate-input-file.sh`

Avoid vague permanent names such as `test.sh`.
