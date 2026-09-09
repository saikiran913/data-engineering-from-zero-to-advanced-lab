# Day 045 Notes - Bash Pipes and Redirection

## Standard Streams

```text
stdin  = standard input
stdout = standard output
stderr = standard error
```

Commands often read input, produce normal output, and may also produce errors or warnings.

## File Descriptors

```text
0 = stdin
1 = stdout
2 = stderr
```

These numbers are a simple way for the shell to refer to the three streams.

## Pipe Mental Model

```text
command A
   ↓ stdout
   |
command B stdin
```

Example:

```bash
cat sample-data/status_values.txt | sort
```

`cat` prints the file. The pipe sends that output into `sort`.

In this case, `cat` is not necessary because `sort` can read the file directly:

```bash
sort sample-data/status_values.txt
```

This teaches an important habit: pipelines should have a reason.

## Redirection Mental Model

```text
stdout → file
stderr → another file
```

Redirection changes where output goes.

## Overwrite Versus Append

```bash
echo "Pipeline review" > practice-output/review.txt
```

`>` writes stdout to a file and can overwrite existing content.

```bash
echo "Second line" >> practice-output/review.txt
```

`>>` appends to the end of a file.

## Why Command Order Matters

```bash
sort sample-data/status_values.txt | uniq
```

This sorts values first, then collapses adjacent duplicates.

```bash
uniq sample-data/status_values.txt | sort
```

This only collapses duplicates that were already adjacent before sorting. If repeated values are separated, they may remain.

## Error Handling

Normal output appears on stdout. Error messages appear on stderr. Redirect them separately when useful, and inspect captured errors before assuming success.

## Data Engineering Connection

Pipes and redirection help with log investigation, simple line counts, basic source-file checks, searching for status codes, capturing command outputs, and future automation.

## Safe Workflow

1. Inspect source.
2. Test command without redirect.
3. Verify output.
4. Verify target path.
5. Redirect to `practice-output/`.
6. Inspect generated output.
7. Inspect error file separately.

