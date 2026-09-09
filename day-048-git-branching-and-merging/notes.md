# Day 048 Notes - Git Branching and Merging

## What Is a Branch?

A branch is a lightweight named pointer to a line of commits. It lets work progress separately from another line of work.

```text
A---B---C  main
         \
          D---E  feature/order-validation
```

In this diagram, `feature/order-validation` started from `main` and then added its own commits.

## Why Use Branches?

Branches help isolate feature work, reduce unrelated changes, support review, enable parallel work, and preserve a stable main branch conceptually.

## Current Branch

The current branch is where new commits will be added. HEAD points to the current position conceptually.

## Default Branch

Many repositories use `main` as the default branch. Some repositories use another name. Always inspect the repository instead of assuming.

## Feature Branch

Example names:

```text
feature/order-validation
feature/log-review
docs/update-data-quality-notes
```

Teams use different naming conventions. The important habit is clarity.

## Branch Workflow

```text
main
→ create branch
→ edit
→ validate
→ commit
→ compare
→ merge
```

## Merge

Merging combines work from one branch into another. The current branch receives the changes.

## Conflict

A conflict happens when the same area changed differently and Git cannot safely decide the final content. A human resolves the intended result.

## Collaboration

Branches structure work, but communication still matters. Code review and remote workflows come later.
