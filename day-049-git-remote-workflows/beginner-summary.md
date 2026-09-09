# Beginner Summary

## What Learners Should Remember

A local repository lives on your machine. A remote repository is a shared repository somewhere else. `origin` is the common default name for the remote created by cloning.

`git clone <repository-url>` creates a local copy, configures `origin`, and checks out the default branch. `git fetch` downloads remote references so you can inspect them. `git pull` fetches and integrates remote work into the current branch. `git push` publishes local commits to a remote repository.

Remote-tracking branches such as `origin/main` are local references to remote state. They update when you fetch. An upstream branch is the remote branch your local branch tracks. `git branch -vv` can help show tracking and ahead/behind information.

Ahead means your local branch has commits the remote does not have. Behind means the remote has commits your local branch does not have. Diverged means both sides have different new commits.

A push rejection is a safety signal. It often means the remote has work your local branch does not contain. Do not force changes. Fetch, inspect, integrate according to team policy, validate, and then push again if appropriate.

A pull request is review thinking, not a core Git object. It usually proposes that a source branch should be reviewed and merged into a target branch. A good pull request is focused, clearly explained, validated, and free of secrets.

Never push passwords, API keys, tokens, credentials, confidential datasets, private configuration, or large raw data by default. Local validation still matters before review.

Day 049 avoids force push, rebase, destructive resets, credential setup, and history rewriting.

## Mental Model

```text
Clone once
→ Work locally
→ Fetch
→ Inspect
→ Integrate
→ Validate
→ Push
→ Review through PR
```

## Required Warnings

> `git push` publishes commits to a remote repository. Review your current branch, repository status, commit history, and sensitive files before pushing.

> Never push passwords, API keys, tokens, credentials, confidential datasets, or private configuration. If a secret is exposed, treat it as compromised and follow the appropriate rotation process.

> `git pull` changes the local branch by integrating remote work. Fetch first when you want to inspect remote changes before integration.

> Day 049 intentionally avoids force push, rebase, destructive resets, and history rewriting. Do not use them as shortcuts for synchronisation problems.

## Next Day Preview

**Day 050 — Git Collaboration Practice: Remote Branches, Pull Request Reviews, Sync Conflicts, and Safe Team Workflows**
