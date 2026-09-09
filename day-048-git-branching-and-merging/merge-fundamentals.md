# Merge Fundamentals

## Merge Target Matters

To merge a feature branch into the default branch:

```bash
git switch main
git status
git merge feature/order-validation
```

The current branch receives the changes. The feature branch is the source of changes.

## Fast-Forward Merge Concept

```text
A---B  main
     \
      C---D  feature

after fast-forward:

A---B---C---D  main
              feature
```

A fast-forward merge moves the target branch pointer forward when no separate target-branch commits need combining.

## Merge Commit Concept

```text
A---B---C  main
     \   \
      D---E---M
```

A merge commit records that two lines of history were combined.

## Automatic Merge

Git may combine non-overlapping changes automatically. Automatic does not always mean the final business logic is correct, so validation still matters.

## Post-Merge Validation

```bash
git status
git log --oneline --graph --decorate --all
```

Then validate files and tests manually.

## Branch Cleanup

Deleting merged branches is a later topic. Day 048 focuses on understanding the merge.
