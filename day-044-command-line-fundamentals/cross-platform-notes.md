# Cross-Platform Notes

Linux/macOS examples use POSIX shell syntax. Windows PowerShell has the same core file-system concepts, but command names and path conventions may differ.

| Concept | Linux/macOS | PowerShell |
|---|---|---|
| Current location | `pwd` | `Get-Location` |
| List files | `ls` | `Get-ChildItem` |
| Change directory | `cd` | `Set-Location` |
| Create directory | `mkdir` | `New-Item -ItemType Directory` |
| Read text | `cat` | `Get-Content` |
| Help | `man`, `--help` | `Get-Help` |

## Aliases

Aliases exist in many shells, but they should not be assumed in scripts or documentation. A short command may point to different behaviour in different shells.

## Path Differences

| Concept | POSIX-style | Windows-style |
|---|---|---|
| Root | `/` | Drive root such as `C:\` |
| Separator | `/` | `\` |
| Home shortcut | `~` in many shells | PowerShell also commonly supports `~` |

## Transferable Skill

The command names may change, but the thinking transfers:

```text
Where am I?
What is here?
Which path should I use?
How do I preview safely?
How do I ask for help?
```

