# Day 044 - Command Line Fundamentals for Data Engineers

Day 044 introduces command-line fundamentals for Data Engineers: files, directories, paths, safe navigation, file inspection, and help commands.

Day 043 worked with semi-structured data. Day 044 moves from SQL into the operating-system and file-system layer. Data Engineers regularly use terminals before running scripts, repository tools, SQL clients, pipeline utilities, cloud tools, or remote Linux environments.

Linux/macOS examples use POSIX shell syntax. Windows PowerShell has the same core file-system concepts, but command names and path conventions may differ.

## Learning Objectives

By the end of this day, you should understand:

- terminal, shell, command line, and command prompt
- command, option, flag, and argument
- current working directory
- file, directory, folder, and file extension
- path, absolute path, and relative path
- `.`, `..`, `~`, root directory, and home directory
- hidden files and path separators
- spaces in paths and quoted paths
- case sensitivity concept
- `pwd`, `ls`, `cd`, `mkdir`, `touch`, `cat`, `head`, `tail`, `file`, and `wc -l`
- `--help`, `man`, `command -v`, and `which` with portability caution
- basic command and path troubleshooting
- how command-line skills connect to Data Engineering work

## Why Command-Line Skills Matter

Data Engineers use terminals to:

- navigate project folders
- inspect CSV, text, and log files
- confirm where files are located
- preview input data before processing
- check logs after a pipeline run
- prepare for future script, repository, SQL-client, cloud, and remote-Linux work

## Safety Warnings

> Command-line tools are powerful. Always check your current directory and target path before creating, moving, renaming, or deleting files.

> Day 044 intentionally avoids destructive file commands. Beginner practice should not use recursive delete commands.

> Paths are platform-specific. Linux/macOS commonly use `/`, while Windows commonly uses drive letters and `\`. Do not copy paths blindly between environments.

> Use a dedicated practice directory for command-line exercises so mistakes do not affect important personal or project files.

## Recommended Learning Order

1. `terminal-shell-command-line.md`
2. `files-directories-and-paths.md`
3. `navigation-commands.md`
4. `safe-file-inspection.md`
5. `help-commands.md`
6. `cross-platform-notes.md`
7. `practice-lab.md`
8. `troubleshooting-guide.md`
9. `command-line-cheatsheet.md`
10. `practice-questions.md`
11. `beginner-summary.md`
12. `glossary.md`

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 044 landing page | 1 |
| `notes.md` | Full conceptual notes | 2 |
| `terminal-shell-command-line.md` | Terminal, shell, prompt, and command anatomy | 3 |
| `files-directories-and-paths.md` | Files, directories, extensions, and paths | 4 |
| `navigation-commands.md` | Safe navigation commands | 5 |
| `safe-file-inspection.md` | Read-only file preview commands | 6 |
| `help-commands.md` | Help and command lookup | 7 |
| `cross-platform-notes.md` | POSIX and PowerShell comparison | 8 |
| `practice-lab.md` | Guided safe lab | 9 |
| `troubleshooting-guide.md` | Beginner troubleshooting flow | 10 |
| `command-line-cheatsheet.md` | Quick reference | 11 |
| `common-mistakes.md` | Common mistakes and safer habits | 12 |
| `real-world-examples.md` | Data Engineering examples | 13 |
| `beginner-summary.md` | Lesson recap | 14 |
| `glossary.md` | Alphabetical terms | 15 |
| `practice-questions.md` | Exercises and answer key | 16 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Terminal | Application window where commands are entered |
| Shell | Program that interprets commands |
| Command line | Text-based way to interact with the system |
| Working directory | The folder your shell is currently using |
| File | A stored item such as CSV, text, SQL, or Markdown |
| Directory | A folder that can contain files or other folders |
| Path | Address of a file or directory |
| Absolute path | Full path from root or drive |
| Relative path | Path from the current working directory |
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Home directory in many POSIX shells |
| Hidden file | File often hidden from normal listing |
| Quoted path | Path wrapped in quotes because it contains spaces |

## Safe-Learning Note

All examples are safe, beginner-friendly, and focused on navigation, listing, creating a dedicated practice folder, creating empty practice files, reading small text files, and using help. Destructive commands, admin commands, permission changes, package installation, network commands, shell scripting, and cloud setup are out of scope.

## Navigation

- Previous Day: [Day 043 - SQL for Semi-Structured Data](../day-043-sql-semi-structured-data/)
- Next Day: [Day 045 - Bash Pipes and Redirection](../day-045-bash-pipes-and-redirection/)
- [Back to Main Learning Path](../README.md)
