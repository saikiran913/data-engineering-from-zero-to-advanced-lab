# Help Commands

Help commands are part of normal command-line work. Experienced users check help often.

## `--help`

Many commands can print help text:

```bash
ls --help
mkdir --help
```

Some macOS/BSD commands may differ from GNU/Linux examples.

## `man`

Manual pages provide detailed help.

```bash
man ls
```

Common sections:

| Section | Meaning |
|---|---|
| NAME | Command name and short purpose |
| SYNOPSIS | Syntax pattern |
| DESCRIPTION | Longer explanation |
| OPTIONS | Available flags/options |

## `command -v`

Checks whether a command is available and where the shell finds it.

```bash
command -v python
```

## `which`

`which` is commonly used, but behaviour can vary. Prefer `command -v` for POSIX shell learning.

```bash
which python
```

## PowerShell Help

```powershell
Get-Help Get-ChildItem
```

## Syntax Notation

```text
command [OPTION]... [FILE]...
```

Square brackets often mean optional. Three dots often mean the item can repeat.

