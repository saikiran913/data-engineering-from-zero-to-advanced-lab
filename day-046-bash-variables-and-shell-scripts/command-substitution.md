# Command Substitution

Command substitution runs a command and stores its stdout in a variable.

## Pattern

```bash
value=$(command)
```

The command runs first. Its normal output becomes the value.

## Current Path

```bash
current_dir=$(pwd)
echo "$current_dir"
```

This stores the current directory path.

## Line Count

```bash
line_count=$(wc -l < sample-data/orders_sample.csv)
echo "$line_count"
```

This stores the line count from a sample file.

## Error Count

```bash
error_count=$(grep "ERROR" sample-data/pipeline_log.txt | wc -l)
echo "$error_count"
```

This stores the number of matching error lines.

## stdout and stderr

Command substitution captures stdout. Error messages still use stderr unless redirected.

## Nesting Caution

Keep command substitution simple. If the command becomes hard to read, test it separately first.

## Backticks

Older examples may use:

```text
`command`
```

Modern `$(...)` is clearer and easier to read.

## Practice

1. Store `current_dir=$(pwd)`.
2. Print `"$current_dir"`.
3. Store an order line count.
4. Print the order line count.
5. Store an error count from the log.
6. Store a warning count from the log.
7. Store `status_count=$(sort sample-data/status_values.txt | uniq | wc -l)`.
8. Print `"Unique statuses: $status_count"`.
9. Test the command before storing it.
10. Explain why stderr is not the same as stdout.
