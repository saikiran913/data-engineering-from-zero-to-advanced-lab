# Real-World Examples

| # | Situation | Git state | Useful command | Expected outcome | Reproducibility benefit | Safety note |
|---|---|---|---|---|---|---|
| 1 | Edit SQL validation query | Modified SQL file | `git diff` | Shows changed filter | Logic change is reviewable | Check no unrelated edits |
| 2 | Add Bash script | Untracked script | `git status` | Shows new file | Script can be tracked | Inspect before staging |
| 3 | Update README | Modified doc | `git diff` | Shows documentation change | Context is preserved | Commit with related changes |
| 4 | Add sample schema file | Untracked file | `git add docs/` | Stages docs directory | Schema note enters history | Avoid private data |
| 5 | Inspect accidental change | Modified file | `git diff` | Reveals unwanted edit | Prevents bad commit | Do not commit blindly |
| 6 | Stage one SQL file | Modified SQL | `git add sql/daily_orders.sql` | Only selected file staged | Commit stays focused | Prefer explicit paths |
| 7 | Stage docs directory | Modified docs | `git add docs/` | Docs staged | Notes versioned | Review staged diff |
| 8 | Review staged diff | Staged files | `git diff --staged` | Shows commit-ready changes | Confirms contents | Check for secrets |
| 9 | Create local commit | Staged changes | `git commit -m "Add order validation query"` | Local commit recorded | History gains purpose | Does not upload |
| 10 | Inspect latest history | Existing commits | `git log --oneline -5` | Compact history | Shows recent evolution | Read messages |
| 11 | Inspect one commit | Known hash | `git show <commit-hash>` | Detailed commit view | Past change is auditable | Use placeholder hash |
| 12 | Find repository root | Unsure location | `git rev-parse --show-toplevel` | Root path shown | Avoids wrong repo | Verify before actions |
| 13 | Discover untracked file | New file | `git status` | Untracked listed | New work noticed | Inspect before adding |
| 14 | Discover generated log | Untracked log | `git status` | Log visible | Prevents noise | Usually do not commit |
| 15 | Identify secret-like file | Untracked `.env` | `git status` | File noticed | Prevents exposure | Do not commit secrets |
| 16 | Ignore practice output concept | Generated outputs | `.gitignore` concept | Keeps noise out | History stays clean | Ignore is prevention |
| 17 | Separate SQL and docs commits | Unrelated changes | `git status` | Shows both | History clearer | Commit logical units |
| 18 | Combine related SQL and docs | Related changes | `git diff --staged` | Shows both | Full reason preserved | Keep one purpose |
| 19 | Pipeline config change | Modified config | `git diff` | Shows parameter change | Result can be traced | No credentials |
| 20 | Data-quality rule change | Modified rule doc | `git commit -m "Document required order fields"` | Rule recorded | Audit trail improves | Validate wording |
| 21 | Sample-data caution | CSV changed | `git diff` | Shows row changes | Samples are explainable | Avoid large raw data |
| 22 | Git versus GitHub misconception | Local commit | `git log` | Commit visible locally | Local history exists | No remote needed |
| 23 | Local commit without remote | Committed change | `git log --oneline` | Commit appears | Work is recorded locally | Not uploaded |
| 24 | No-change clean tree | Clean state | `git status` | Nothing to commit | Work is settled | Good stopping point |
