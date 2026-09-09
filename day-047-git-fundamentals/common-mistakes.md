# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Git confused with GitHub | Tool and hosting platform are mixed | Learner misunderstands local history | Learn Git locally first |
| Repository confused with folder | Not every folder is a repo | Git commands may fail | Check with `git status` |
| Running `git init` inside existing repo | Creates nested repository metadata | Main repo becomes confusing | Verify location first |
| Manually editing `.git` | Metadata can be damaged | History may break | Do not edit `.git` |
| Not checking `git status` | State is unknown | Wrong files may be committed | Start with status |
| Committing without reviewing diff | Accidental changes are recorded | Bugs or private text can enter history | Review diff first |
| Staging everything blindly | Too many files may be staged | Generated or private files can be included | Stage exact files |
| Assuming `git add` creates commit | Staging and committing are different | Work is not recorded yet | Commit after reviewing staged diff |
| Assuming commit uploads to GitHub | Local and remote are confused | Learner expects online changes | Remote workflows come later |
| Vague commit messages | Purpose is unclear | History becomes hard to read | Write meaningful messages |
| Huge unrelated commits | Many topics mixed | Review and debugging are harder | Make small logical commits |
| Committing secrets | Sensitive data enters history | Security risk | Never commit secrets |
| Committing API keys | Keys can be exposed | Access risk | Keep keys out of repo |
| Committing `.env` | Often contains private values | Sensitive data may leak | Ignore and avoid committing it |
| Committing confidential data | Private data becomes recorded | Trust and compliance risk | Use generic samples |
| Committing large raw datasets | Repo becomes heavy | Git is not raw-data storage by default | Store only small samples |
| Ignoring untracked files | New work may be missed | Commit incomplete | Inspect untracked files |
| Assuming `git diff` shows all untracked content | Diff may omit new file content | New files need inspection | Open untracked files before staging |
| Forgetting `git diff --staged` | Staged set is not reviewed | Wrong change may be committed | Review staged diff |
| Committing generated output accidentally | Temporary files enter history | Repo becomes noisy | Keep generated files ignored |
| Committing temporary logs | Logs are often generated | Noise and possible private text | Keep logs out unless intentional |
| Committing cache files | Cache is not source | History grows unnecessarily | Ignore caches |
| Relying only on `.gitignore` after secret committed | Ignore rules do not remove history | Secret may remain exposed | Stop and seek advanced help |
| Using Git as backup only | Git is not full backup by itself | Data loss expectations are wrong | Use Git for version history |
| Not validating code before commit | Broken work is recorded | Reproducibility suffers | Run suitable checks |
| Mixing code and unrelated formatting | Change purpose becomes unclear | Review is harder | Separate unrelated changes |
| Not reading commit history | Past context is missed | Repeated mistakes can happen | Use `git log` |
| Confusing working tree with staging area | Current files and selected changes differ | Commit contents are misunderstood | Use status and diff |
| Confusing staged with committed | Selected is not recorded yet | Work may be lost from history | Commit after review |
| Copying destructive recovery commands | Commands may discard work | Loss risk | Seek review before recovery |
| Using `git reset --hard` casually | It can discard changes | Work can be lost | Do not use in Day 047 |
| Using `git clean` casually | It can remove untracked files | New work can be lost | Do not use in Day 047 |
| Force-push thinking introduced too early | Remote history risk | Too advanced now | Learn local basics first |
| Not knowing repository root | Commands run in wrong place | State looks confusing | Use repo-root check |
