# Script Arguments

Arguments are values passed to a script.

## `$0`

`$0` usually contains the script name.

## `$1`

`$1` is the first argument.

## `$2`

`$2` is the second argument.

## `$#`

`$#` is the number of positional arguments supplied.

## `$@`

`$@` represents all positional arguments.

## Basic Example

```bash
#!/usr/bin/env bash

input_file="$1"

echo "Input file: $input_file"
```

Run it like:

```bash
bash scripts/02-count-lines.sh sample-data/orders_sample.csv
```

## Validate Missing Argument

```bash
if [ "$#" -lt 1 ]; then
    echo "Usage: bash script.sh <input-file>" >&2
    exit 1
fi
```

The usage message goes to stderr because it explains a problem.

## Quote Arguments

```bash
input_file="$1"
```

Quoting is safer when the value may contain spaces.

## Practice

1. Identify the first argument in `bash script.sh sample-data/orders_sample.csv`.
2. Identify the second argument in `bash script.sh sample-data/pipeline_log.txt ERROR`.
3. Explain why `$#` is useful.
4. Explain why usage messages help.
5. Assign `input_file="$1"`.
6. Assign `search_term="$2"`.
7. Print `"$input_file"`.
8. Print `"$search_term"`.
9. Check whether at least one argument was supplied.
10. Check whether at least two arguments were supplied.
11. Loop through `"$@"`.
12. Explain why `"$@"` should be quoted.
