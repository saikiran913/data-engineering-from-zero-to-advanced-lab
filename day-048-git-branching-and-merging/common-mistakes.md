# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| Branch confused with folder | A branch is history, not a directory | Learner looks for files in wrong way | Think line of commits |
| Branch confused with repository copy | Branch is not a full duplicate repo | Repo structure is misunderstood | Use branch commands to inspect |
| Not checking current branch | Work may happen in wrong place | Wrong history changes | Run status or branch check |
| Creating feature from wrong branch | Feature starts from wrong base | Merge can be confusing | Confirm branch first |
| Vague branch names | Purpose is unclear | Review is harder | Use meaningful names |
| Editing main accidentally | Feature work is not isolated | Main changes too early | Create feature branch first |
| Unrelated work on feature branch | Purpose becomes mixed | Merge review becomes hard | Keep branch focused |
| Huge feature branch | Too many changes collect | Conflicts become harder | Make smaller branches |
| Not committing before merge | Work may not be recorded | Merge state is unclear | Commit intended work first |
| Merging from wrong target branch | Changes go into unintended branch | History is confusing | Switch to target first |
| Assuming merge direction does not matter | Current branch receives changes | Wrong branch changes | Identify target/source |
| Not comparing before merge | Accidental changes enter merge | Bugs can slip in | Compare branches first |
| Conflict treated as failure | Conflict is a decision point | Learner panics or bypasses | Inspect calmly |
| Conflict markers committed | Markers break source files | Code/docs become invalid | Remove all markers |
| Choosing one side blindly | Business logic may be lost | Correct result may be wrong | Understand both versions |
| Resolving without business context | Final content may be invalid | Data rules can regress | Ask what final logic should be |
| Staged resolution not validated | Bad resolution is recorded | Merge may look complete but be wrong | Validate before commit |
| No post-merge validation | Automatic merge may still be wrong | Logic errors remain | Validate after merge |
| Assuming automatic merge means correct logic | Git checks text, not business meaning | Reports may change incorrectly | Review result |
| Using rebase without understanding it | History changes can confuse beginners | More complexity | Learn later |
| Using reset-hard to fix conflict | Work can be discarded | Data loss risk | Stop and seek review |
| Using force push | Remote history can be damaged | Collaboration risk | Out of scope |
| Mixing secret files into branch | Sensitive data enters history | Security risk | Never commit secrets |
| Long-lived branch ignored | Branch drifts from default | Merge becomes harder | Keep branches current conceptually |
| Giant commits | Review is difficult | History is less useful | Make small commits |
| Poor commit messages | Purpose is unclear | Future review suffers | Explain the change |
| Branch name includes sensitive information | Private detail appears in history/tools | Public repo risk | Use generic names |
| Remote concepts mixed into local practice | Scope becomes confusing | Fundamentals are skipped | Stay local today |
| `.git` manually edited | Repository metadata can break | History can be damaged | Never edit `.git` |
| Nested practice repository committed | Embedded metadata confuses main repo | Repository hygiene suffers | Do not commit `.git` |
| Generated files committed during merge | Noise enters history | Review becomes messy | Inspect status |
| Relying only on Git to validate code | Git does not understand business logic | Broken logic can merge | Run checks and review |
