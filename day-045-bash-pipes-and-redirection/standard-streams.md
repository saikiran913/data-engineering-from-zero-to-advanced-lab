# Standard Streams

## Standard Input

Standard input, or stdin, is input a command can read. It may come from the keyboard, a file, or a previous command in a pipeline.

## Standard Output

Standard output, or stdout, is normal command output.

```bash
echo "Pipeline started"
```

## Standard Error

Standard error, or stderr, is where error or warning messages can appear.

```bash
cat sample-data/does-not-exist.txt
```

The exact error wording depends on the system, but the message is error output.

## File Descriptors

| Stream | Descriptor | Purpose |
|---|---:|---|
| stdin | 0 | input |
| stdout | 1 | normal output |
| stderr | 2 | errors or warnings |

## Why stdout and stderr Are Separate

Normal results can be stored separately from errors. This helps Data Engineers capture useful output while still reviewing failures.

## Stream Diagram

```text
keyboard/file/pipe
        |
        v
      stdin
     command
      /   \
stdout   stderr
normal   errors
```

