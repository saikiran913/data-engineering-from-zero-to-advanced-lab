# Files, Directories, and Paths

## Core Terms

| Term | Meaning |
|---|---|
| File | Stored item, such as a CSV or text file |
| Directory | Folder that can contain files or directories |
| Extension | Ending that hints at file type |
| File system | Organised structure of files and directories |
| Path | Address of a file or directory |

## Common Extensions

| Extension | Common use |
|---|---|
| `.csv` | Comma-separated data |
| `.json` | JSON data |
| `.txt` | Plain text |
| `.sql` | SQL |
| `.py` | Python |
| `.md` | Markdown |

## POSIX-Style Paths

```text
/home/user/project/data/orders.csv
sample-data/orders_sample.csv
../day-043-sql-semi-structured-data/
```

## Windows-Style Path

```text
C:\Projects\data-engineering\sample-data\orders_sample.csv
```

## Absolute and Relative Paths

An absolute path gives the full location. A relative path starts from your current working directory.

## Parent, Home, and Root

| Symbol | Meaning |
|---|---|
| `..` | parent directory |
| `~` | home directory in many POSIX shells |
| `/` | POSIX root and path separator |

## Spaces and Case

Quote paths with spaces:

```bash
cd "practice files"
```

Some systems treat `Data` and `data` as different names. Others may not. Check spelling and case carefully.

## Path Troubleshooting Checklist

1. Run `pwd`.
2. Run `ls`.
3. Check spelling.
4. Check uppercase and lowercase letters.
5. Quote paths with spaces.
6. Confirm whether you are using POSIX shell or PowerShell.

