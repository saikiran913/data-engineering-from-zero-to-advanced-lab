# Real-World Examples

| # | Situation | Python setup need | Interpreter/environment check | Safe action | Reproducibility note |
|---|---|---|---|---|---|
| 1 | Run local validation script | Correct Python | `python --version` | Run `.py` script | Record setup |
| 2 | New data pipeline repo | Project env | `sys.executable` | Create `.venv` | Isolated dependencies |
| 3 | Two projects need different versions | Separate envs | `python -m pip list` | One `.venv` each | Avoid conflicts |
| 4 | Teammate setup | Documented steps | README checklist | Use requirements | Repeatable onboarding |
| 5 | CI environment concept | Known Python | version output | Install documented deps | Later automation |
| 6 | Cloud job runtime concept | Runtime version | provider docs concept | Match Python version | Fewer surprises |
| 7 | Python CLI script | Terminal execution | executable path | Run script | Version-controlled |
| 8 | Wrong Python version | Verify Python 3 | `python3 --version` | Use intended command | Avoid old interpreter |
| 9 | Wrong pip | Align pip | `python -m pip --version` | Use module form | Same interpreter |
| 10 | Forgotten activation | Env missing | executable path | Activate | Session-specific |
| 11 | `.venv` visible in status | Ignore needed | `git status` | Update ignore conceptually | Do not commit |
| 12 | `__pycache__` appears | Ignore cache | `git status` | Ignore generated files | Source stays clean |
| 13 | Requirements missing | Setup unclear | inspect repo | Add docs conceptually | Easier reproduction |
| 14 | Requirements outdated | Docs drift | compare setup | Refresh intentionally | Avoid stale setup |
| 15 | No third-party deps | Simple setup | pip list | Run standard library | Minimal reproducibility |
| 16 | IDE mismatch | Different Python | IDE interpreter path | Align interpreter | Same behaviour |
| 17 | PowerShell activation issue | OS-specific activation | error message | Follow approved guidance | Avoid unsafe policy changes |
| 18 | Linux `python3` vs `python` | Command difference | both version checks | Choose Python 3 | Document command |
| 19 | Shared server Python caution | Avoid global changes | executable path | Use project env | Protect shared tools |
| 20 | Production environment concept | Controlled runtime | documented version | Do not experiment there | Separate learning/prod |
| 21 | Jupyter future concept | Environment still matters | kernel/interpreter concept | Learn later | Same isolation idea |
| 22 | API connector future use | Package isolation | venv active | Install deliberately later | Avoid global packages |
| 23 | Data-quality script setup | Stable script env | run environment check | Use `.venv` | Repeatable checks |
| 24 | Tiny REPL exploration | Quick interpreter check | `python` | Small experiment | Use scripts for reusable work |
