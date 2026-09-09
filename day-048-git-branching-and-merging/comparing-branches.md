# Comparing Branches

Comparison is review, not merge.

## Log Graph

```bash
git log --oneline --graph --decorate --all
```

This shows commits, branch labels, and branch divergence.

## Diff Branch Contents

```bash
git diff main..feature/order-validation
```

Conceptually, this compares the default branch with the feature branch.

## Compare File-Level Changes

```bash
git diff --stat main..feature/order-validation
```

This shows which files changed and a summary of changes.

## Questions to Ask

- what files changed?
- does the feature branch contain only intended work?
- is output grain or business logic unchanged where required?
- are docs included when needed?
- are secrets absent?

## Why Compare First?

Comparison helps catch unrelated edits before merge.
