# Troubleshooting Guide

## Beginner Troubleshooting Flow

```text
1. pwd
2. ls
3. check spelling
4. check case
5. quote path
6. verify platform/shell
7. use help
```

## Common Problems

| Problem | Likely cause | Safer response |
|---|---|---|
| `command not found` | Command is not installed or shell cannot find it | Use `command -v command_name` and check spelling |
| `No such file or directory` | Path is wrong or current directory is different | Run `pwd`, then `ls` |
| `Not a directory` | The path points to a file, not a folder | List contents and check item type |
| Path with spaces fails | Path was not quoted | Use quotes around the path |
| File cannot be found after `cd` | Relative path now starts somewhere else | Check current directory again |
| Different `ls` output | Platform or options differ | Use help for your system |
| `man` unavailable | Manual pages may not be installed | Try `command --help` |
| PowerShell mismatch | POSIX command copied into PowerShell | Use PowerShell equivalent |
| Wrong slash direction | Path copied from another platform | Convert path style carefully |
| Case sensitivity | Uppercase/lowercase differs | Match exact file and folder names |
| Current-directory confusion | Command ran from unexpected folder | Start with `pwd` |
| Relative-path confusion | Relative path starts from current location | Draw the folder path |
| Hidden-file confusion | Hidden files are not shown by normal listing | Use `ls -a` |

## Example: Path With Spaces

```bash
cd "practice files"
```

## Example: Command Lookup

```bash
command -v python
```

## Example: Help First

```bash
mkdir --help
```

