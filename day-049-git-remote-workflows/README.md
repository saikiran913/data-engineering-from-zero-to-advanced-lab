# Day 049 — Git Remote Workflows

Day 049 introduces clone, fetch, pull, push, tracking branches, synchronisation, and pull request thinking.

Day 047 introduced local Git fundamentals. Day 048 introduced branches, merges, conflicts, and safe collaboration habits. Day 049 now explains how local repositories interact with remote repositories in a safe, beginner-friendly way.

## Learning Objectives

By the end of this day, you should understand:

- local repository versus remote repository
- remote names and the common `origin` convention
- remote URL concept
- clone, fetch, pull, and push
- why fetch is safer for inspection before integration
- why pull can change the current branch
- why push publishes local commits
- upstream and tracking branches
- remote-tracking branches such as `origin/main`
- local branches versus remote branches
- ahead, behind, and diverged states
- why push can be rejected
- why clean working tree state matters before synchronisation
- pull request thinking, source branch, and target branch
- why local validation still matters before opening a review
- why secrets and large raw data should not be pushed
- why force push, rebase, and destructive history rewriting remain out of scope

## Why Remote Git Matters for Data Engineers

Remote Git workflows help Data Engineers share SQL, Bash scripts, Python code, pipeline configuration, schema documentation, and data-quality rules. They also support review discipline before changes are merged into shared work.

## Required Safety Warnings

> `git push` publishes commits to a remote repository. Review your current branch, repository status, commit history, and sensitive files before pushing.

> Never push passwords, API keys, tokens, credentials, confidential datasets, or private configuration. If a secret is exposed, treat it as compromised and follow the appropriate rotation process.

> `git pull` changes the local branch by integrating remote work. Fetch first when you want to inspect remote changes before integration.

> Day 049 intentionally avoids force push, rebase, destructive resets, and history rewriting. Do not use them as shortcuts for synchronisation problems.

## Recommended Learning Order

1. `notes.md`
2. `local-vs-remote-repositories.md`
3. `clone-fundamentals.md`
4. `fetch-fundamentals.md`
5. `pull-fundamentals.md`
6. `push-fundamentals.md`
7. `tracking-branches.md`
8. `synchronisation-and-divergence.md`
9. `pull-request-thinking.md`
10. `safe-remote-collaboration.md`
11. inspect `remote-simulation-template/`
12. `practice-lab.md`
13. `troubleshooting-guide.md`
14. `git-remote-cheatsheet.md`
15. `practice-questions.md`
16. `beginner-summary.md`
17. `glossary.md`

## Files

| File | Purpose |
|---|---|
| `notes.md` | Broad remote Git overview |
| `local-vs-remote-repositories.md` | Local and shared repository comparison |
| `clone-fundamentals.md` | First local copy from a repository URL |
| `fetch-fundamentals.md` | Inspect remote changes safely |
| `pull-fundamentals.md` | Integrate remote work into current branch |
| `push-fundamentals.md` | Publish local commits |
| `tracking-branches.md` | Upstream and remote-tracking branch concepts |
| `synchronisation-and-divergence.md` | Ahead, behind, and diverged states |
| `pull-request-thinking.md` | Review-oriented collaboration thinking |
| `safe-remote-collaboration.md` | Safe team habits |
| `remote-simulation-template/` | Disposable local practice template |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Local repository | Repository on your machine |
| Remote repository | Shared repository somewhere else |
| `origin` | Common default remote name |
| Clone | Create a local copy from a remote |
| Fetch | Download remote references for inspection |
| Pull | Fetch and integrate into current branch |
| Push | Publish local commits to a remote |
| Upstream | Remote branch a local branch tracks |
| Remote-tracking branch | Local reference to remote state |
| Ahead | Local branch has commits remote does not |
| Behind | Remote has commits local branch does not |
| Diverged | Both local and remote have different new commits |
| Pull request | Review proposal, not a core Git object |

## Safe-Learning Note

Day 049 is provider-neutral. It avoids credential setup, real remote administration, force push, rebase, destructive resets, and history rewriting. The lab uses disposable local simulation only.

## Navigation

- Previous Day: [Day 048 - Git Branching and Merging](../day-048-git-branching-and-merging/)
- Next Day: [Day 050 - Python for Data Engineers](../day-050-python-setup-and-virtual-environments/)
- [Back to Main Learning Path](../README.md)
