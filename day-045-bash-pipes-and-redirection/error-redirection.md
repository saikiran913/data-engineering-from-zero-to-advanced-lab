# Error Redirection

Error redirection controls stderr, the stream used for error and warning messages.

## Redirect stderr

```bash
cat sample-data/does-not-exist.txt 2> practice-output/errors.txt
```

## Append stderr

```bash
cat sample-data/another-missing-file.txt 2>> practice-output/errors.txt
```

## Separate stdout and stderr

Normal output and errors can be captured separately:

```bash
cat sample-data/README.txt > practice-output/normal-output.txt 2> practice-output/errors.txt
```

## Combine stderr With stdout

```bash
command > practice-output/all-output.txt 2>&1
```

This sends stdout to a file, then sends stderr to the same place as stdout.

Strong caution: combined output makes later separation impossible. Inspect failures carefully.

## Order Matters

Shell redirection order can matter because the shell processes redirections from left to right. Day 045 keeps this conceptual and beginner-friendly.

## Error-Handling Mental Model

```text
normal output → stdout
errors        → stderr
```

## Review Captured Errors

```bash
cat practice-output/errors.txt
```

