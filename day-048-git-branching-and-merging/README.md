# Day 048 — Git Branching and Merging

Day 048 introduces branches, feature work, merging, conflicts, and safe collaboration habits.

Day 047 taught local Git states and commits. Day 048 builds on that by showing how separate branches isolate feature work. Branching allows experimentation and focused changes without immediately changing the main line of work.

Git commands are generally cross-platform across Linux, macOS, Windows Git Bash, and PowerShell when Git is installed. Shell path syntax may differ.

## Learning Objectives

By the end of this day, you should understand:

- what a branch is
- why branches provide isolated lines of work
- current branch and default branch concepts
- why many repositories use `main`, while some use another default branch name
- what a feature branch is
- branch pointer and HEAD concepts
- what `git branch`, `git switch`, and `git switch -c` do
- why Day 048 prefers `git switch`
- how commits remain associated with branch history
- how to compare branches
- what `git diff main..feature-name` means conceptually
- what `git log --oneline --graph --decorate --all` shows
- what merging means
- what `git merge <branch>` does
- fast-forward merge and merge commit concepts
- why Git may merge automatically
- why merge conflicts happen
- what conflict markers look like
- why conflict markers must not remain in final source
- how to inspect merge state with `git status`
- how to resolve a simple text conflict manually
- why validation is required after merging
- why collaboration requires communication as well as Git commands
- why remote workflows and rebase/history rewriting come later

## Why Branching Matters for Data Engineers

Branches help Data Engineers:

- develop a new SQL transformation
- modify a pipeline script
- add a data-quality rule
- update schema documentation
- test a new validation approach
- isolate experimental work
- collaborate later without mixing unrelated changes

## Required Warnings

> Always check the current branch with `git status` or `git branch` before making or merging changes. Merging from the wrong branch can produce unintended history.

> A merge conflict is not an error to bypass. It means Git needs a human decision about the final content.

> Never leave conflict markers such as `<<<<<<<`, `=======`, or `>>>>>>>` in committed source files.

> Day 048 intentionally avoids destructive history rewriting. Do not use commands such as `git reset --hard`, force push, or rebase as shortcuts for beginner merge problems.

## Recommended Learning Order

1. `notes.md`
2. `branch-fundamentals.md`
3. `creating-and-switching-branches.md`
4. `feature-workflow.md`
5. `comparing-branches.md`
6. `merge-fundamentals.md`
7. `merge-conflicts.md`
8. `conflict-resolution-guide.md`
9. `safe-collaboration-habits.md`
10. inspect `practice-repo-template/`
11. complete `practice-lab.md`
12. use `troubleshooting-guide.md`
13. review `git-branching-cheatsheet.md`
14. complete `practice-questions.md`
15. read `beginner-summary.md`
16. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Branch | Named line of Git history |
| Main/default branch | Repository's main line of work |
| Feature branch | Focused branch for one change |
| Branch pointer | Name pointing to a commit |
| HEAD | Current position in the repository |
| Switch | Move to another branch |
| Merge | Bring one branch's work into another |
| Fast-forward | Move branch pointer forward when histories allow |
| Merge commit | Commit that records combined branch histories |
| Conflict | Git needs a human decision |
| Conflict marker | Text showing competing changes |
| Resolved file | Conflict markers removed and final content chosen |
| Branch comparison | Review differences before merging |
| Collaboration | Working safely with overlapping changes |

## Safe-Learning Note

Day 048 uses disposable local practice. No remote push or pull is required. No rebase or history rewriting is taught. No nested `.git` metadata should be committed into the main repository.

## Navigation

- Previous Day: [Day 047 - Git Fundamentals](../day-047-git-fundamentals/)
- Next Day: [Day 049 - Git Remote Workflows](../day-049-git-remote-workflows/)
- [Back to Main Learning Path](../README.md)
