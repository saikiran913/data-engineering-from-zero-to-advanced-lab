# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Assuming `python` always means Python 3 | Command differs by system | Wrong version may run | Check version |
| Ignoring Python version | Environment is unclear | Reproducibility suffers | Record Python 3 version |
| Using wrong interpreter | Script runs elsewhere | Packages may be missing | Check `sys.executable` |
| `pip` tied to another Python | Package installs elsewhere | Import errors happen later | Use `python -m pip` |
| Installing globally by default | Projects can conflict | System environment gets messy | Use `.venv` |
| Not creating venv | No project isolation | Version conflicts grow | Create project environment |
| Forgetting activation | Global Python may run | Confusing package list | Activate and verify |
| Assuming venv remains active after terminal closes | Activation is session-specific | Next terminal may differ | Activate per session |
| Running script from wrong directory | Relative paths fail | Script not found | Check `pwd` |
| Wrong script path | Command cannot find file | Learner thinks Python failed | Inspect folders |
| Committing `.venv` | Local environment enters Git | Repo becomes large/noisy | Ignore `.venv/` |
| Committing `__pycache__` | Generated cache enters Git | History gets noisy | Ignore cache |
| Committing `.pyc` | Compiled cache enters Git | Not source code | Ignore `*.pyc` |
| Adding secrets to scripts | Sensitive values leak | Security risk | Keep secrets out |
| Putting API keys in requirements | Requirements is not secret storage | Credentials can leak | Never store keys there |
| Unknown package installed blindly | Supply-chain risk | Environment becomes unclear | Install deliberately |
| Requirements undocumented | Setup cannot be recreated | Teammates struggle | Document dependencies |
| System Python modified unnecessarily | Shared Python changes | Other tools may break | Use project env |
| Venv confused with Docker | Different isolation level | Wrong expectations | Learn one tool at a time |
| Venv confused with Git branch | Environment and history differ | Concepts blur | Keep mental models separate |
| REPL used for long code | Work is not reusable | Git cannot track easily | Use `.py` scripts |
| Script confused with module | Roles are mixed | Imports feel confusing | Keep concept light today |
| Package confused with Python file | Installed code vs file differs | Dependency model unclear | Learn terms |
| Interpreter path not checked | Active Python unknown | pip mismatch possible | Print executable |
| IDE differs from terminal | Code works in one place only | Debugging is confusing | Align interpreter |
| Activation copied across OSes | Syntax differs | Command fails | Use platform-specific command |
| PowerShell policy weakened casually | Security setting changed | Risk increases | Follow approved guidance |
| Dependency version assumed universal | Versions change | Reproducibility breaks | Document versions |
| `.venv` treated as source code | Local artifact mistaken for project | Git noise | Ignore it |
| Requirements file treated as environment itself | It documents, not creates by itself | Setup step missed | Create env and install docs |
| Real credentials in sample setup | Public repo risk | Secret exposure | Use generic examples |
| Heavy packages installed early | Slow/confusing setup | Learning focus shifts | Standard library only today |
| Multiple managers mixed unnecessarily | Tooling confusion | Hard to reproduce | Use standard `venv` today |
