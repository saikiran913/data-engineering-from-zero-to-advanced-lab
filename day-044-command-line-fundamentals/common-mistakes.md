# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Not checking current directory | You do not know where commands apply | Files may be created in the wrong place | Run `pwd` first |
| Confusing file and directory | Commands expect different item types | Navigation can fail | Use `ls -l` |
| Assuming relative path starts from home | Relative paths start from current directory | File not found errors happen | Check `pwd` |
| Confusing `/` with home | `/` is root in POSIX paths | You may look in the wrong place | Use `~` for home |
| Confusing `.` and `..` | They mean current and parent directory | Navigation mistakes happen | Practise slowly |
| Wrong case | Some systems are case-sensitive | Path fails | Match exact name |
| Forgetting quotes around spaces | Shell splits the path | Command sees multiple arguments | Quote the path |
| Windows path pasted into Bash | Path syntax differs | Command may fail | Convert path style |
| POSIX path pasted into Windows unchanged | Path syntax differs | Command may fail | Use platform path rules |
| Using `cat` on huge file | Output can flood the terminal | Hard to read and interrupt | Use `head` or `tail` |
| Assuming extension proves content | Extension can be misleading | Wrong file assumptions | Use `file` where available |
| Editing hidden files accidentally | Hidden files can be important | Tool behaviour may change | List carefully with `ls -a` |
| Creating files in wrong folder | Current directory was wrong | Practice files scatter | Use dedicated folder |
| Running command from wrong project directory | Relative paths no longer match | Command fails or targets wrong file | Navigate deliberately |
| Ignoring help | Guessing increases mistakes | Options may differ | Use `--help` or `man` |
| Assuming aliases are portable | Aliases differ by shell | Scripts and notes may break | Learn full command names |
| Confusing command and argument | Syntax is misunderstood | Wrong operation | Break command into parts |
| Confusing flag and path | Option treated like a target | Unexpected result | Read command syntax |
| Assuming `ls` behaves identically everywhere | GNU/BSD/PowerShell differences exist | Output or options differ | Check local help |
| Copying dangerous internet commands | Unknown commands can harm files | Risk is high | Understand before running |
| Using admin mode unnecessarily | Extra privileges increase risk | Mistakes have wider impact | Stay in normal user mode |
| Assuming every shell behaves the same | Bash, Zsh, and PowerShell differ | Commands may fail | Identify your shell |
| Terminal vs shell confusion | Window and interpreter are different | Troubleshooting is harder | Learn both terms |
| Absolute vs relative confusion | Path base is unclear | Wrong target | Decide path type first |
| Path separator confusion | Slash rules differ | Path fails | Use platform conventions |
| Trying advanced commands too early | Path basics are not stable yet | Mistakes multiply | Master navigation first |

