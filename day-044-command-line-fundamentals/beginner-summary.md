# Beginner Summary

The terminal is where commands are entered. The shell is the program that interprets those commands. The command line is the text-based way of interacting with the system.

The most important beginner idea is the current working directory. Commands often depend on where you are. Use `pwd` to show your current location, `ls` to see what is there, and `cd` to move between directories.

Files and directories are addressed using paths. An absolute path gives the full location. A relative path starts from your current working directory. `..` means parent directory, and `~` commonly means home in POSIX shells.

Use `mkdir` to create a dedicated practice directory. Use `touch` to create an empty practice file in POSIX-style shells. PowerShell uses different command names for similar concepts.

Use `cat`, `head`, and `tail` to inspect small text files safely. `cat` prints a whole file, so it is best for small files. `head` previews the beginning. `tail` previews the end, which is useful for logs. `file` can help identify file type, and `wc -l` counts lines.

Help is part of normal command-line work. Use `command --help`, `man command`, or `command -v command` to learn and troubleshoot.

Mental model:

```text
Where am I?
→ What is here?
→ Where should I go?
→ Which path should I use?
→ What safe command should I run?
→ How do I get help?
```

Safety reminders:

> Command-line tools are powerful. Always check your current directory and target path before creating, moving, renaming, or deleting files.

> Day 044 intentionally avoids destructive file commands. Beginner practice should not use recursive delete commands.

> Paths are platform-specific. Linux/macOS commonly use `/`, while Windows commonly uses drive letters and `\`. Do not copy paths blindly between environments.

> Use a dedicated practice directory for command-line exercises so mistakes do not affect important personal or project files.

Day 045 will add controlled file operations such as copying, moving, renaming, wildcards, and safe cleanup thinking with strong safety rules.

