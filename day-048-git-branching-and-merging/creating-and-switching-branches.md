# Creating and Switching Branches

## Create and Switch

```bash
git switch -c feature/order-validation
```

This creates a new branch and switches to it.

## Switch Back

```bash
git switch main
```

Use the actual default branch name in your repository.

## Switch Existing Branch

```bash
git switch feature/order-validation
```

This switches to an existing branch.

## Verify

```bash
git status
git branch --show-current
```

Always verify where you are before editing or merging.

## Historical Checkout Syntax

Older Git examples may show:

```bash
git checkout -b feature/order-validation
```

Day 048 prefers `git switch` because it is clearer for branch switching.

## Uncommitted Changes Caution

Switching may be blocked if local changes would be overwritten. In some cases, changes may carry across branches. Beginners should commit or understand changes first. Stash is out of scope today.

## Safe Workflow

```text
status
→ confirm clean state
→ switch/create branch
→ status again
```
