# Safe File Inspection

Day 044 focuses on safe, read-only inspection of small text files.

## `cat`

Use `cat` only for small text files.

```bash
cat sample-data/pipeline_notes.txt
```

## `head`

Preview the beginning of a file.

```bash
head sample-data/customers_sample.csv
```

## `tail`

Preview the end of a file.

```bash
tail sample-data/log_sample.txt
```

## `file`

Inspect the file type conceptually.

```bash
file sample-data/customers_sample.csv
```

## `wc -l`

Count lines.

```bash
wc -l sample-data/orders_sample.csv
```

Line count is not always identical to logical row count for every file format. CSV files often include a header line.

## Safe Workflow

```text
list
→ inspect file type
→ preview beginning
→ preview end
→ count lines if useful
```

## PowerShell Equivalents

| POSIX-style command | PowerShell concept |
|---|---|
| `cat file.txt` | `Get-Content file.txt` |
| `head file.txt` | `Get-Content file.txt -TotalCount 10` |
| `tail file.txt` | `Get-Content file.txt -Tail 10` |

Do not use text preview commands on huge files without care. Binary files should not be treated like plain text.

