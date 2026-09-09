# Troubleshooting Guide

## Useful Flow

```text
1. pwd
2. git rev-parse --show-toplevel
3. git branch --show-current
4. git status
5. git remote -v
6. git fetch
7. git branch -vv
8. git log --oneline --graph --decorate --all
9. act only after state is understood
```

## Repository Not Found

The repository URL or local path may be wrong. Confirm the source before cloning.

## Not a Git Repo

You may be in the wrong folder. Use `pwd` and `ls`.

## Origin Missing

The repository may not have a remote named `origin`. Use `git remote -v`.

## Push Rejected

Remote contains work your local branch does not have. Fetch and inspect before integrating.

## Pull Conflict

Pull integrated remote work and found overlapping changes. Use the Day 048 conflict workflow.

## No Upstream

Use first-push tracking in a safe practice repo:

```bash
git push -u origin feature/name
```

## Wrong Branch Pushed

Stop and inspect branch, status, and history. Do not use force commands.

## Clone Destination Confusion

Check `pwd` before cloning and use clear folder names.

## Fetch Shows No File Changes

Fetch updates remote-tracking references. It does not update your current branch files automatically.

## Pull Already Up to Date

Your current branch already contains the remote work Git checked.

## Authentication Prompt

Real remotes may require authentication. Day 049 does not teach credential setup. Follow your organisation or provider guidance.

## Remote-Tracking Confusion

Remember that `origin/main` is a local reference to remote state, not the same as your local `main`.

## Ahead/Behind Confusion

Use `git branch -vv` and the history graph to inspect state before acting.
