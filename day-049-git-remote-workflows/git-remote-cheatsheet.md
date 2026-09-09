# Git Remote Cheatsheet

## Inspect Remotes

```bash
git remote -v
```

## Clone

```bash
git clone <repository-url>
```

## Fetch

```bash
git fetch
git fetch origin
```

## Status and Branch

```bash
git status
git branch --show-current
git branch -vv
```

## Pull

```bash
git pull
```

Pull fetches and integrates into the current branch.

## First Push

```bash
git push -u origin feature/name
```

## Later Push

```bash
git push
```

## History Graph

```bash
git log --oneline --graph --decorate --all
```

## Safe Sync

```text
status
→ fetch
→ inspect
→ integrate
→ validate
→ push
```

## Never in Day 049

- force push
- rebase
- reset-hard
- clean
- credential setup
- destructive history recovery
