# Day 044 Notes - Command Line Fundamentals

## What Is a Command Line?

A command line is a text-based interface for interacting with a computer. Instead of clicking buttons, you type commands.

## What Is a Terminal?

A terminal is the application or window where commands are entered.

## What Is a Shell?

A shell is the program that interprets commands. Beginner examples include Bash, Zsh, and PowerShell.

## Why Data Engineers Use Terminals

Data Engineers use terminals to navigate repositories, inspect files, run Python, use SQL tools, check logs, work on remote Linux systems, and operate data tooling. Those future tools are easier once file-system basics feel comfortable.

## Command Anatomy

```bash
ls -l sample-data
```

| Part | Meaning |
|---|---|
| `ls` | command |
| `-l` | option or flag |
| `sample-data` | argument |

## Working Directory

The working directory is where the shell currently is. Many commands depend on this location.

Use:

```bash
pwd
```

to print the current working directory.

## File-System Hierarchy

```text
/
├── home/
├── project/
└── data/
```

Folders can contain files and other folders. This creates a tree.

## Paths

An absolute path starts from the root or drive. A relative path starts from your current directory.

| Symbol | Meaning |
|---|---|
| `.` | current directory |
| `..` | parent directory |
| `~` | home directory in many POSIX shells |
| `/` | root or path separator in POSIX paths |

## Hidden Files

In POSIX-style systems, names beginning with `.` are often hidden from normal listing. Use:

```bash
ls -a
```

to include hidden files.

## Quoting Paths

Paths with spaces should be quoted:

```bash
cd "practice files"
```

## Safe Habits

1. Check location.
2. List contents.
3. Verify spelling and case.
4. Use exact paths.
5. Quote spaces.
6. Use a practice directory.
7. Use help before unfamiliar commands.

