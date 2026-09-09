# Git Branching Cheatsheet

## Current Branch

```bash
git branch --show-current
```

## List Branches

```bash
git branch
```

## Create and Switch

```bash
git switch -c feature/name
```

## Switch

```bash
git switch main
```

Use the actual default branch name in your repository.

## Compare

```bash
git diff main..feature/name
```

## History Graph

```bash
git log --oneline --graph --decorate --all
```

## Merge Into Current Branch

```bash
git merge feature/name
```

## Conflict Workflow

```text
git status
→ edit conflict
→ remove markers
→ validate
→ git add file
→ git status
→ git commit
```

## Safety

- confirm branch
- clean working tree
- compare first
- no rebase
- no reset-hard
- no force operations
- no remote operations in Day 048
