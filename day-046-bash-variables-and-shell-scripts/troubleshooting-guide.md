# Troubleshooting Guide

## Troubleshooting Flow

```text
1. pwd
2. ls
3. inspect script
4. check argument count
5. print variable values
6. quote paths
7. validate file/directory
8. run one command manually
9. inspect stderr
10. check exit status
```

## `command not found`

Check spelling and make sure you are using a Bash-compatible environment.

## Script File Not Found

Check `pwd`, then run `ls scripts` from the Day 046 folder.

## `syntax error near unexpected token`

Look for missing `then`, `fi`, `do`, `done`, or unmatched quotes.

## Variable Prints Empty

The variable may not be assigned, or the assignment may contain spaces around `=`.

## Literal `$variable` Printed

Single quotes prevent expansion. Use double quotes when you want the value.

## Path Split Into Multiple Arguments

Quote the variable:

```bash
"$input_file"
```

## Missing Argument

Check how many arguments were supplied with `$#`, then print usage if required input is missing.

## File Validation Fails Unexpectedly

Check the current directory and verify the relative path.

## Wrong Current Directory

Run scripts from `day-046-bash-variables-and-shell-scripts/`.

## `$?` Value Confusing

`$?` changes after every command. Check it immediately after the command you care about.

## Script Exits With Code 1

This usually means validation failed in Day 046 scripts. Read stderr for the reason.

## Loop Skips File

Check that the file was supplied as an argument and that it exists.

## `grep` Returns No Matches

Check spelling and case. `ERROR` and `error` are different in the examples.

## Output Is Empty

The command may have matched nothing, printed only stderr, or received an empty variable.

## Bash Script Run in PowerShell

Day 046 examples use Bash syntax. Use Git Bash, WSL, or another Bash-compatible shell.

## Shebang Not Used When Running With `bash`

When you run `bash scripts/script-name.sh`, Bash is chosen by the command. The shebang is still useful documentation.

## Permission Denied When Trying `./script.sh`

Day 046 does not require executable permission. Use:

```bash
bash scripts/script-name.sh
```
