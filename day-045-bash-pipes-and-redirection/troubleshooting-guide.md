# Troubleshooting Guide

## Troubleshooting Flow

```text
1. pwd
2. ls
3. inspect source
4. run command without redirect
5. confirm stdout
6. confirm stderr
7. verify target
8. redirect only after output looks correct
```

## Output File Is Empty

Possible reasons:

- `grep` matched nothing
- wrong file
- wrong path
- wrong case
- wrong command order

Safer response: run the command without redirection and inspect output first.

## Source File Was Overwritten

The `>` operator can replace existing content. This is why Day 045 keeps write targets inside `practice-output/`.

If an important source file was overwritten, restore it from the original source, version control, or backup if available.

## `uniq` Still Shows Duplicates

`uniq` normally collapses adjacent duplicates only. Sort first when global uniqueness is expected:

```bash
sort sample-data/status_values.txt | uniq
```

## Wrong CSV Column

`cut -d',' -f4` means comma delimiter and field 4. The header line is included, and complex CSV files can break simple delimiter logic.

## Error File Is Empty

The command may not have produced stderr. Empty error output does not always mean the command produced useful stdout.

## Normal Output Missing

stdout may have been redirected to a file. Inspect the target file.

## Combined Output Confusing

If stdout and stderr were combined with `2>&1`, later separation is difficult. Capture them separately next time.

## `tee` Changed File Unexpectedly

`tee` writes to files. Without append mode, it can overwrite the target.

## Bash Syntax Fails in PowerShell

Bash and PowerShell syntax differ. Use shell-specific help and examples.

## Path Issue

Use the Day 044 safe path flow:

```text
pwd
ls
check spelling
check case
quote paths with spaces
verify shell
```

