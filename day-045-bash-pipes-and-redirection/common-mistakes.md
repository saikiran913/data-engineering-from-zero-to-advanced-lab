# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Confusing pipe and redirection | `|` connects commands, `>` writes to a file | Output goes to the wrong place | Explain the operator before using it |
| Using `>` when `>>` was intended | Existing content can be replaced | Review notes may be lost | Use append only after checking target |
| Appending when overwrite was intended | File keeps growing | Old results mix with new results | Inspect target file first |
| Redirecting into source file | Source content can be damaged | Original input may be lost | Write only to `practice-output/` |
| Redirecting to wrong directory | Output is hard to find | Investigation becomes confusing | Run `pwd` and `ls` first |
| Not checking `pwd` | Current location is unknown | Relative paths may target wrong folder | Check location first |
| Ignoring stderr | Errors are missed | Empty output may be misread | Capture or inspect errors |
| Assuming empty stdout means success | A command may fail silently in stdout | Failures can hide in stderr | Review stderr |
| Combining stdout and stderr too early | Normal and error lines mix | Later separation is harder | Capture separately first |
| Assuming pipeline failure is obvious | Some stages can still produce output | Results may be incomplete | Inspect each stage |
| `uniq` used before sorting | Non-adjacent duplicates remain | Unique list may be wrong | Use `sort | uniq` |
| Using `cat` unnecessarily | Extra stage adds noise | Pipeline is less clear | Let commands read files directly |
| Assuming `cut` fully parses CSV | Simple delimiter logic is limited | Quoted commas can break output | Use proper parsers for complex CSV |
| Counting CSV lines as business rows | Header line may be counted | Row count can be off by one | Account for headers |
| Forgetting header row | Header appears in output | Status lists include column name | Inspect first line |
| Filtering case-sensitively without noticing | `error` and `ERROR` differ | Matches may be missed | Check exact text |
| Quoting errors | Shell splits words unexpectedly | Paths or patterns fail | Quote paths and patterns |
| Path with spaces not quoted | Path becomes multiple arguments | Command fails | Use quotes |
| `grep` matches unintended text | Pattern is too broad | Count may be misleading | Inspect matching lines |
| Redirect order misunderstood | Streams may not go where expected | Captured output surprises you | Keep redirection simple |
| `tee` assumed read-only | `tee` writes to files | Target can be changed | Use safe targets |
| `tee` overwrites target | Default mode can replace content | Existing notes may be lost | Use `tee -a` for append |
| Endlessly appending logs | File grows without review | Old and new results mix | Rotate or review conceptually |
| Using shell text tools on binary files | Output may be unreadable | Terminal becomes noisy | Inspect file type first |
| Piping huge output without need | Hard to inspect | Work becomes noisy | Filter early |
| Using advanced one-liners blindly | Stages are not understood | Mistakes are hidden | Test one stage at a time |
| Copying Bash syntax into PowerShell unchanged | Shells differ | Command may fail | Use platform-specific help |
| Treating stderr as always fatal | Warnings may not stop work | Context is missed | Read the message |
| Treating warnings as harmless | Warning may require action | Data quality can suffer | Review warning output |
| Not inspecting generated output | Mistakes remain hidden | Bad files may be trusted | Preview result files |

