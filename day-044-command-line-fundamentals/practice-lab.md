# Navigate a Data Engineering Practice Folder

## Rules

- Remain inside `day-044-command-line-fundamentals/`.
- Do not delete files.
- Do not use admin commands.
- Do not use internet or network commands.

## Lab Steps

1. Check where you are.

```bash
pwd
```

2. List files.

```bash
ls
```

3. Use a long listing.

```bash
ls -l
```

4. Enter the sample data folder.

```bash
cd sample-data
```

5. List sample files.

```bash
ls
```

6. Inspect the README file.

```bash
cat README.txt
```

7. Preview the customer CSV.

```bash
head customers_sample.csv
```

8. Preview the end of the log.

```bash
tail log_sample.txt
```

9. Inspect file type.

```bash
file orders_sample.csv
```

10. Count lines.

```bash
wc -l orders_sample.csv
```

11. Return to the Day 044 folder.

```bash
cd ..
```

12. Create a practice directory.

```bash
mkdir command-line-practice
```

13. Enter it.

```bash
cd command-line-practice
```

14. Create an empty notes file.

```bash
touch notes.txt
```

15. Check your location again.

```bash
pwd
```

16. List with detail.

```bash
ls -l
```

17. Return to the Day folder.

```bash
cd ..
```

18. Ask for help.

```bash
ls --help
```

PowerShell commands differ. Use `Get-Location`, `Get-ChildItem`, `Set-Location`, `New-Item`, `Get-Content`, and `Get-Help` when working in PowerShell.

## Learner Checklist

- I checked my current directory.
- I listed files before moving.
- I used relative paths safely.
- I previewed small text files.
- I created practice items only in the practice folder.
- I used help before guessing.

