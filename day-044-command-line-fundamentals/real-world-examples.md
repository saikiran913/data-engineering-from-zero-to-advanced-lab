# Real-World Examples

| # | Situation | Goal | Safe command | Path concept | Safety note |
|---|---|---|---|---|---|
| 1 | Find project folder | Confirm location | `pwd` | Current directory | Start by checking where you are |
| 2 | Inspect CSV folder | See available files | `ls sample-data` | Relative path | Confirm folder name first |
| 3 | Enter sample data | Work inside data folder | `cd sample-data` | Relative path | Use `pwd` after moving |
| 4 | Verify current directory | Avoid wrong-folder work | `pwd` | Working directory | Make this a habit |
| 5 | Move to parent | Return one level up | `cd ..` | Parent directory | Know what parent means |
| 6 | Return home | Go to home folder | `cd ~` | Home directory | POSIX shell shortcut |
| 7 | Preview CSV header | See first lines | `head sample-data/customers_sample.csv` | File path | Good for small previews |
| 8 | Preview latest log lines | Check recent run | `tail sample-data/log_sample.txt` | File path | Safer than full output |
| 9 | Inspect file type | Check content hint | `file sample-data/orders_sample.csv` | File target | Extension is not proof |
| 10 | Find command help | Learn options | `ls --help` | Command syntax | Help first |
| 11 | Confirm command exists | Check availability | `command -v python` | Executable lookup | Availability varies |
| 12 | Create practice directory | Safe workspace | `mkdir command-line-practice` | New folder | Keep practice isolated |
| 13 | Create notes file | Empty practice file | `touch command-line-practice/notes.txt` | Nested relative path | POSIX example |
| 14 | Use relative path | Read nearby file | `cat sample-data/README.txt` | Relative path | Depends on current folder |
| 15 | Use absolute path | Navigate from root | `cd /home/user/project` | Absolute path | Generic example only |
| 16 | Path with spaces | Enter spaced folder | `cd "practice files"` | Quoted path | Quotes keep path together |
| 17 | Hidden `.git` concept | Understand hidden folder | `ls -a` | Hidden files | Do not edit hidden files casually |
| 18 | Inspect pipeline log | Read recent entries | `tail sample-data/log_sample.txt` | Log file | Avoid full huge logs |
| 19 | Remote Linux concept | Navigate safely | `pwd` | Working directory | Same basics apply remotely |
| 20 | Python script path concept | Locate future script | `ls scripts` | Directory path | Script running is future scope |
| 21 | Repository navigation concept | Find project root | `ls` | Folder contents | Repository commands are future scope |
| 22 | Future cloud CLI context | Prepare path skills | `pwd` | Current location | Cloud tools are future scope |
| 23 | Wrong-directory troubleshooting | Diagnose failure | `pwd` then `ls` | Current and relative path | Recheck before retrying |
| 24 | Cross-platform mismatch | Fix copied path | `Get-Location` | PowerShell location | Use platform equivalents |

