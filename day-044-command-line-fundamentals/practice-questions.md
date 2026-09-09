# Practice Questions

## Section A - Concept Checks

1. What is a terminal?
2. What is a shell?
3. What is the command line?
4. What is a command?
5. What is an option or flag?
6. What is an argument?
7. What is the current working directory?
8. What does `pwd` show?
9. What does `ls` show?
10. What does `cd` do?
11. What is a file?
12. What is a directory?
13. What is a file extension?
14. What is a path?
15. What is an absolute path?
16. What is a relative path?
17. What does `.` mean?
18. What does `..` mean?
19. What does `~` commonly mean?
20. What is a hidden file in POSIX-style systems?
21. Why should paths with spaces be quoted?
22. What does `head` do?
23. What does `tail` do?
24. Why should help commands be used?

## Section B - Choose the Command

1. Show your current directory.
2. List visible files.
3. List files in long format.
4. Show hidden files.
5. Move into `sample-data`.
6. Move to the parent directory.
7. Move to the home directory.
8. Create a folder named `practice`.
9. Create nested folders `practice/data/raw`.
10. Create an empty file named `notes.txt`.
11. Print a small text file.
12. Preview the first lines of a CSV.
13. Preview the last lines of a log.
14. Count lines in a file.
15. Inspect file type.
16. Ask `ls` for help.
17. Open the manual page for `ls`.
18. Check whether `python` is available.

## Section C - Predict the Path

Use this tree:

```text
/project
├── data
│   ├── raw
│   └── clean
├── scripts
└── logs
```

1. Current path is `/project`. Command: `cd data`. Result?
2. Current path is `/project/data`. Command: `cd raw`. Result?
3. Current path is `/project/data/raw`. Command: `cd ..`. Result?
4. Current path is `/project/data`. Command: `cd ..`. Result?
5. Current path is `/project`. Command: `cd logs`. Result?
6. Current path is `/project/logs`. Command: `cd ../scripts`. Result?
7. Current path is `/project/data/raw`. What relative path reaches `/project/logs`?
8. Current path is `/project/scripts`. What relative path reaches `/project/data/clean`?
9. Is `/project/data/raw` absolute or relative?
10. Is `data/raw` absolute or relative?
11. Is `../logs` absolute or relative?
12. Current path is `/project`. What command lists `data/raw` without entering it?
13. Current path is `/project/data`. What command returns to `/project`?
14. Current path is `/project/data/clean`. What command reaches `/project`?
15. Current path is `/project`. What command enters `scripts`?

## Section D - Fix the Mistake

1. A learner runs a command without checking the current directory.
2. A learner tries to `cd` into a CSV file.
3. A learner thinks `orders_sample.csv` and `Orders_Sample.csv` are always the same.
4. A learner types `cd practice files` for a folder with a space.
5. A learner pastes a Windows path into Bash without adjustment.
6. A learner pastes a POSIX path into PowerShell unchanged.
7. A learner uses `cat` on a huge log.
8. A learner assumes `.csv` guarantees valid CSV content.
9. A learner does not know whether a command exists.
10. A learner ignores `--help`.
11. A learner confuses `-l` with a path.
12. A learner assumes `ls` output is identical on every system.
13. A learner creates practice files in an important project folder by mistake.
14. A learner cannot find a file after changing directory.
15. A learner starts advanced commands before understanding paths.

## Section E - Cross-Platform Reasoning

1. What is the PowerShell equivalent of `pwd`?
2. What is the PowerShell equivalent of `ls`?
3. What is the PowerShell equivalent of `cd`?
4. What is the PowerShell command concept for creating a directory?
5. What is the PowerShell command concept for reading text?
6. What path separator is common in POSIX paths?
7. What path separator is common in Windows paths?
8. Why should aliases not be assumed in scripts?
9. Why do command options differ across systems?
10. Which concept stays the same across platforms: current directory or command names?

## Section F - Mini Lab Review

Describe safe commands to:

1. Confirm you are inside `day-044-command-line-fundamentals`.
2. List the files.
3. Enter `sample-data`.
4. Preview `customers_sample.csv`.
5. Preview the end of `log_sample.txt`.
6. Count lines in `orders_sample.csv`.
7. Return to the Day 044 folder.
8. Create `command-line-practice`.
9. Create `notes.txt` inside the practice folder.
10. Ask for help on `mkdir`.

## Answer Key

### Section A

1. Application window where commands are entered.
2. Program that interprets commands.
3. Text-based way to interact with the system.
4. Instruction typed into a shell.
5. Modifier that changes command behaviour.
6. Value passed to a command.
7. Folder the shell is currently using.
8. Current working directory.
9. Files and folders in a location.
10. Changes directory.
11. Stored item such as CSV or text.
12. Folder that can contain files or folders.
13. File ending such as `.csv`.
14. Address of a file or directory.
15. Full path from root or drive.
16. Path from current directory.
17. Current directory.
18. Parent directory.
19. Home directory in many POSIX shells.
20. A file often hidden from normal listing, commonly beginning with `.`.
21. So the shell treats the path as one argument.
22. Shows the beginning of a file.
23. Shows the end of a file.
24. Help reduces guessing.

### Section B

1. `pwd`
2. `ls`
3. `ls -l`
4. `ls -a`
5. `cd sample-data`
6. `cd ..`
7. `cd ~`
8. `mkdir practice`
9. `mkdir -p practice/data/raw`
10. `touch notes.txt`
11. `cat file.txt`
12. `head file.csv`
13. `tail file.log`
14. `wc -l file.txt`
15. `file file.txt`
16. `ls --help`
17. `man ls`
18. `command -v python`

### Section C

1. `/project/data`
2. `/project/data/raw`
3. `/project/data`
4. `/project`
5. `/project/logs`
6. `/project/scripts`
7. `../../logs`
8. `../data/clean`
9. Absolute.
10. Relative.
11. Relative.
12. `ls data/raw`
13. `cd ..`
14. `cd ../..`
15. `cd scripts`

### Section D

1. Run `pwd` first.
2. Use `cat`, `head`, or `tail` for a file; use `cd` for directories.
3. Match exact case.
4. Use `cd "practice files"`.
5. Convert the path to POSIX style or use the correct shell.
6. Use PowerShell path conventions.
7. Use `head` or `tail`.
8. Inspect the file where possible.
9. Use `command -v command_name`.
10. Use help before guessing.
11. Remember `-l` is an option.
12. Check local help.
13. Use a dedicated practice directory.
14. Run `pwd` and `ls`.
15. Practise paths first.

### Section E

1. `Get-Location`
2. `Get-ChildItem`
3. `Set-Location`
4. `New-Item -ItemType Directory`
5. `Get-Content`
6. `/`
7. `\`
8. Aliases can mean different things in different shells.
9. Implementations differ.
10. Current directory concept.

### Section F

Sample sequence:

```bash
pwd
ls
cd sample-data
head customers_sample.csv
tail log_sample.txt
wc -l orders_sample.csv
cd ..
mkdir command-line-practice
touch command-line-practice/notes.txt
mkdir --help
```

