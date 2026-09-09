# Git Fundamentals Cheatsheet

## Check Git

```bash
git --version
```

## Find Repo Root

```bash
git rev-parse --show-toplevel
```

## Check Status

```bash
git status
```

## Review Unstaged Changes

```bash
git diff
```

## Stage File

```bash
git add path/to/file
```

## Review Staged Changes

```bash
git diff --staged
```

## Commit

```bash
git commit -m "Clear commit message"
```

## History

```bash
git log --oneline
git log --oneline -5
```

## Show Commit

```bash
git show <commit-hash>
```

## Safe Workflow

```text
status
→ diff
→ add exact file
→ status
→ diff --staged
→ commit
→ log
```

## Safety

- no secrets
- no raw private data
- no blind `git add .`
- no remote operations in Day 047
- no destructive history recovery commands in Day 047
