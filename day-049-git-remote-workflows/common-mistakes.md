# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Git confused with hosting provider | Tool and platform are mixed | Concepts blur | Separate Git from hosting |
| `origin` treated as magic | It is just a remote name | Learner cannot inspect it | Use `git remote -v` |
| Local and remote branches confused | Branch locations differ | Push/pull expectations fail | Use `git branch -vv` |
| Remote-tracking branch misunderstood | `origin/main` is a local reference | Working tree may not change | Fetch then inspect |
| Fetch and pull confused | Pull integrates; fetch inspects | Local files may change unexpectedly | Fetch first when unsure |
| Expecting fetch to update working branch | Fetch updates references only | Branch appears unchanged | Inspect graph |
| Expecting push to receive remote changes | Push sends local commits | Remote changes still missing | Fetch or pull separately |
| Cloning into wrong directory | Files land in unexpected place | Workspace gets messy | Check `pwd` first |
| Nested clone | Repo inside repo can confuse status | Metadata risk | Use disposable area |
| Wrong branch before pull | Current branch receives integration | Wrong work changes | Confirm branch |
| Wrong branch before push | Wrong branch is published | Review confusion | Confirm branch |
| Dirty tree before pull | Local changes can conflict | Sync becomes harder | Check status first |
| Pushing secrets | Sensitive data published | Security risk | Inspect before push |
| Pushing credentials | Access may be exposed | Rotation required | Never commit credentials |
| Pushing `.env` | Often contains private config | Secrets may leak | Keep it out |
| Pushing raw datasets | Data may be large/private | Repo and privacy risk | Use small samples |
| Pushing generated logs | Noisy and possibly private | Review clutter | Ignore generated files |
| Pushing unrelated files | PR scope grows | Review is harder | Keep branch focused |
| Force push after rejection | Can overwrite shared work | Collaboration risk | Fetch and inspect |
| Rebase without understanding | History can change unexpectedly | Too advanced today | Learn later |
| Bypassing conflicts | Final logic may be wrong | Data quality risk | Resolve manually |
| Treating push rejection as failure only | It is also a safety signal | Learner may panic | Inspect remote state |
| Local commit assumed remote | Commit is still local | Team cannot see it | Push when ready |
| PR assumed commit | PR is review surface | Git object model confused | Commit first, propose review |
| Giant PR | Too much to review | Bugs hide | Keep PR focused |
| Vague PR description | Purpose unclear | Review slows | Explain goal and validation |
| No validation | Review lacks evidence | Bad changes can merge | Validate before PR |
| Wrong target branch | Changes proposed to wrong place | Merge risk | Confirm source/target |
| Wrong source branch | PR shows wrong work | Review confusion | Choose focused branch |
| Never fetching | Local view gets stale | Rejections/conflicts surprise | Fetch regularly |
| Long-outdated branch | More divergence | Integration harder | Sync thoughtfully |
| Pulling blindly | Local branch changes suddenly | Conflicts surprise | Status and fetch first |
