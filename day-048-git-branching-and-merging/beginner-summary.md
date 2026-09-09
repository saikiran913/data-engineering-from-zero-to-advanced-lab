# Beginner Summary

## What Learners Should Remember

A branch is a named line of Git history. Branches isolate feature work so changes can be developed, reviewed, committed, compared, and merged without immediately changing the main line of work.

`git branch` lists branches. `git branch --show-current` shows the current branch. `git switch -c feature/name` creates and switches to a new branch. `git switch main` changes back to the default branch, but the default branch name is repository-specific. Some repositories use `main`; others may use another name.

Feature branches should stay focused. A branch for order validation should not also contain unrelated formatting, unrelated documentation, temporary logs, or private files.

Compare branches before merging. `git diff main..feature/name` shows content differences conceptually, and `git log --oneline --graph --decorate --all` helps show branch history.

Merge direction matters. The current branch receives the merge. To merge a feature into the default branch, switch to the default branch first, inspect status, then merge the feature branch.

Git may merge automatically. A fast-forward merge is normal when the default branch has not moved separately. A merge commit is normal when histories need to be joined.

Conflicts are normal. A conflict means Git needs a human decision. Conflict markers such as `<<<<<<<`, `=======`, and `>>>>>>>` show competing versions. These markers must be removed before committing. `git status` guides conflict resolution, and resolved files must be staged.

Merged work still requires validation. Git can combine text, but it cannot guarantee correct SQL grain, business filters, Bash behaviour, or documentation meaning.

Day 048 avoids rebase and destructive history rewriting. Remote collaboration comes later.

## Mental Model

```text
Confirm branch
→ Create focused branch
→ Change
→ Review
→ Commit
→ Compare
→ Merge
→ Resolve if needed
→ Validate
```

## Required Warnings

> Always check the current branch with `git status` or `git branch` before making or merging changes. Merging from the wrong branch can produce unintended history.

> A merge conflict is not an error to bypass. It means Git needs a human decision about the final content.

> Never leave conflict markers such as `<<<<<<<`, `=======`, or `>>>>>>>` in committed source files.

> Day 048 intentionally avoids destructive history rewriting. Do not use commands such as `git reset --hard`, force push, or rebase as shortcuts for beginner merge problems.

## Next Day Preview

**Day 049 — Git Remote Collaboration Basics: Remotes, Clone, Fetch, Pull, Push, and Safe Synchronisation**

Day 049 will introduce remote Git concepts and synchronisation after local branching and merging are understood.
