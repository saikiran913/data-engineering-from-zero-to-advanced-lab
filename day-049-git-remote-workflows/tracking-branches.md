# Tracking Branches

## Local Branch

A local branch exists in your local repository.

## Remote-Tracking Branch

A remote-tracking branch is your local reference to remote state, such as:

```text
origin/main
origin/feature/order-validation
```

It updates when you fetch.

## Upstream Branch

An upstream branch is the remote branch a local branch tracks.

## Inspect Tracking

```bash
git branch -vv
```

This can show local branches, upstream information, and ahead/behind hints.

## First Push With Upstream

```bash
git push -u origin feature/order-validation
```

After this, future `git push` or `git pull` commands may know the matching remote branch.

## Ahead and Behind Language

Ahead means local has commits not on upstream. Behind means upstream has commits not in local.
