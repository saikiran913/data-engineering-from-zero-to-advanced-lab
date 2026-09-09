# Real-World Examples

| # | Scenario | Git state | Useful command | Expected outcome | Safety note |
|---|---|---|---|---|---|
| 1 | Clone repository | No local copy | `git clone <repository-url>` | Local repo created | Use intended location |
| 2 | Inspect origin | Existing clone | `git remote -v` | Remote names/URLs shown | Do not expose private URLs |
| 3 | Fetch updates | Remote may changed | `git fetch` | Remote-tracking refs update | Working branch unchanged |
| 4 | Behind main | Remote ahead | `git branch -vv` | Behind shown conceptually | Inspect before pull |
| 5 | Local ahead | Local commits exist | `git branch -vv` | Ahead shown conceptually | Validate before push |
| 6 | Diverged | Both changed | graph log | Divergence visible | Integrate carefully |
| 7 | First push | New feature branch | `git push -u origin feature/order-validation` | Branch published | Check secrets first |
| 8 | Later push | Upstream exists | `git push` | New commits published | Confirm branch |
| 9 | Push rejection | Remote changed | push output | Rejection message | Fetch and inspect |
| 10 | Fast-forward pull | Local behind only | `git pull` | Local moves forward | Status first |
| 11 | Pull conflict | Same lines changed | `git pull` | Conflict state | Resolve manually |
| 12 | SQL PR | Feature branch | PR thinking | Review SQL | Include validation |
| 13 | Bash PR | Script changed | PR thinking | Review script | Run sample check |
| 14 | DQ rule PR | Rule updated | PR thinking | Review docs/query | Confirm business rule |
| 15 | Schema docs PR | Docs changed | PR thinking | Review schema notes | Keep concise |
| 16 | Config PR | Config changed | PR thinking | Review parameters | No secrets |
| 17 | Accidental `.env` | Untracked private file | `git status` | File noticed | Do not push |
| 18 | Large data | Big file appears | `git status` | File noticed | Avoid raw datasets |
| 19 | Generated log | Log appears | `git status` | File noticed | Usually ignore |
| 20 | Wrong target | PR target incorrect | review PR settings | Correct target chosen | Pause before merge |
| 21 | Giant PR | Too many files | diff/review | Hard to review | Split work |
| 22 | Focused PR | One logical change | review | Easier approval | Keep scope tight |
| 23 | Reviewer catches join issue | SQL diff | review comment concept | Fix before merge | Review protects logic |
| 24 | Reviewer requests validation | Missing evidence | PR update | Add validation note | Do checks before merge |
| 25 | Clean merge after review | Approved change | merge concept | Shared branch updated | Validate afterwards |
| 26 | Protected main concept | Direct change restricted | PR review | Safer workflow | Admin setup out of scope |
| 27 | No-remote-needed experiment | Local-only idea | local branch | No push needed | Keep private experiments local |
