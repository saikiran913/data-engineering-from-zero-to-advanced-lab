# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Spaces around `=` | Bash no longer sees simple assignment | Variable is not created | Use `name="value"` |
| Forgetting `$` | Variable name prints literally | Stored value is not used | Use `"$name"` when reading |
| Unquoted path variable | Spaces may split the path | File command may fail | Use `"$input_file"` |
| Single quotes when expansion was expected | Variable is printed literally | Script output is confusing | Use double quotes for expansion |
| Double quotes misunderstood | They still expand variables | Secrets or values may print unexpectedly | Know what should be displayed |
| Empty variable not validated | Command may run with missing input | Results are unclear | Check with `-z` |
| Positional argument missing | `$1` is empty | Script reviews nothing useful | Check `$#` first |
| `$1` used without checking `$#` | Missing input is not caught | Later errors become confusing | Print usage and exit |
| `$@` used unquoted | Arguments with spaces split | Loop processes wrong values | Use `"$@"` |
| Path argument contains spaces | Unquoted command breaks | File not found errors appear | Quote path variables |
| Hardcoded local absolute path | Works only on one machine | Public examples become unusable | Use relative paths |
| Script assumes current directory incorrectly | Relative paths fail | Learner sees missing files | Run from lesson folder |
| File existence not checked | Command error appears later | Failure is harder to understand | Use `[ -f "$file" ]` |
| Directory existence not checked | Summary script fails later | Missing folder is unclear | Use `[ -d "$dir" ]` |
| Errors printed to stdout | Errors mix with normal results | Output capture becomes messy | Use `>&2` for errors |
| Exit status ignored | Failure may look successful | Automation becomes misleading | Return non-zero for failed validation |
| `$?` checked too late | Another command replaced it | Wrong result is inspected | Check immediately |
| Script continues after failed validation | Later commands run with bad input | Output can be false | Exit after failure |
| Loop uses unquoted variable | Each file path may split | Counts are wrong | Use `"$file"` |
| Changing command placed inside loop | Mistake repeats quickly | Many files can be affected | Keep Day 046 loops read-only |
| Wildcard loop not understood | More files match than expected | Scope expands quietly | Use explicit files first |
| Command substitution output assumed valid | Captured value may be empty | Summary can mislead | Test command before capture |
| stderr ignored | Failure details are missed | Empty stdout is misread | Inspect stderr |
| Usage instructions missing | Learner does not know arguments | Script feels broken | Print a usage message |
| Script name is vague | Purpose is unclear | Maintenance is harder | Use descriptive names |
| Too much logic in one script | Hard to review | Mistakes hide | Keep scripts small |
| Copy-paste mentality | Repeated changes are error-prone | Paths drift across commands | Use variables/scripts |
| Script scheduled before manual testing | Automation repeats unknown behaviour | Bad output can multiply | Test manually first |
| Advanced error mode assumed to solve everything | Behaviour can surprise beginners | Debugging gets harder | Keep validation explicit |
| Dynamic command execution used unnecessarily | Input can become command text | Safety risk increases | Keep commands direct |
| Secrets hardcoded | Sensitive values may leak | Public repos become unsafe | Do not include secrets |
| Script overwrites source data | Source file may be damaged | Practice becomes unsafe | Read source files only |
| Output directory not controlled | Files appear in random places | Cleanup is confusing | Use `practice-output/` |
| Environment variable confused with local variable | Scope is misunderstood | Scripts behave unexpectedly | Keep Day 046 variables local |
| Script syntax copied into PowerShell | Shells differ | Commands may fail | Use a Bash-compatible environment |
