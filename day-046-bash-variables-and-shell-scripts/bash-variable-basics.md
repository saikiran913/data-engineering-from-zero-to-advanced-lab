# Bash Variable Basics

## Assignment

```bash
file_name="orders_sample.csv"
```

This creates a shell variable named `file_name`.

## Invalid Spacing Example

```bash
file_name = "orders_sample.csv"
```

In Bash, spaces around `=` change how the shell reads the line. Bash treats `file_name` like a command name, not a variable assignment.

## Expansion

```bash
echo "$file_name"
```

`$file_name` means "use the value stored in `file_name`".

## Multiple Variables

```bash
data_dir="sample-data"
file_name="orders_sample.csv"
full_path="$data_dir/$file_name"
```

Variables can be combined to build clear paths.

## Numeric-Looking Values

```bash
expected_count="18"
```

Bash variables are strings by default conceptually. A number-looking value is still stored as text unless used in a numeric context.

## Readability

Prefer descriptive names:

- `input_file`
- `log_file`
- `data_dir`
- `search_term`

Use lowercase names for local script variables. Avoid overwriting common environment variable names.

## Shell Variable Versus Environment Variable

```text
shell variable       = available inside the current shell/script
environment variable = exported for child processes
```

Environment variables are useful later, but Day 046 keeps the idea conceptual.

## Practice

1. Create `data_dir="sample-data"`.
2. Create `orders_file="orders_sample.csv"`.
3. Combine them into `input_file="$data_dir/$orders_file"`.
4. Print `"$input_file"`.
5. Create `log_file="sample-data/pipeline_log.txt"`.
6. Print `"$log_file"`.
7. Create `search_term="ERROR"`.
8. Run `grep "$search_term" "$log_file"`.
9. Create `status_file="sample-data/status_values.txt"`.
10. Run `sort "$status_file" | uniq`.
11. Create `line_count=$(wc -l < "$input_file")`.
12. Print `"Line count: $line_count"`.
