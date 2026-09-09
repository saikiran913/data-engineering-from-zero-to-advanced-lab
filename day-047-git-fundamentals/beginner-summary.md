# Beginner Summary

## What Learners Should Remember

Git is version control. It records how project files change over time. GitHub is a hosting and collaboration platform built around Git repositories, but Git and GitHub are not the same.

A repository contains tracked work and history. The working tree is the current project state: the files you can see and edit. A file can be untracked, modified, staged, or committed.

Untracked means Git does not yet track the file. Modified means a tracked file changed since the last commit. Staged means the change is selected for the next commit. Committed means the change has been recorded in local history.

`git status` is the first safety command. It tells you what Git sees. `git diff` reviews unstaged changes. `git diff --staged` reviews staged changes. `git add` stages changes; it does not commit them. `git commit` records a local change. `git log` shows history. `git show` inspects one commit.

Commits should be small and meaningful. A good commit has one logical purpose and a clear message, such as `Add order validation query` or `Document staging checks`.

Secrets and confidential data must never be committed. `.gitignore` helps prevent accidental tracking of temporary files, generated outputs, logs, and local environment files, but it is not secret management. If sensitive information has already been committed or exposed, that requires advanced cleanup and often credential rotation.

Git history improves reproducibility because it helps connect a result to a specific version of SQL, Bash scripts, Python code, configuration, data-quality rules, and documentation.

Day 047 is local Git only. Remote collaboration comes later.

## Mental Model

```text
Check
→ Change
→ Review
→ Stage
→ Review again
→ Commit
→ Inspect history
```

## Required Warnings

> Git records changes, but it does not automatically protect sensitive information. Never commit passwords, API keys, tokens, private credentials, or confidential data.

> Check `git status` and `git diff` before every commit so you understand exactly what will be recorded.

> Avoid using broad staging commands blindly. `git add .` can stage more files than intended, so beginners should understand the repository state first.

> Do not initialize a new Git repository inside an existing repository unless you intentionally want a nested repository. Day 047 should use the existing learning repository for concepts and a clearly isolated practice example for `git init`.

## Next Day Preview

**Day 048 — Git Branches and Safe Collaboration Basics: Branches, Switching, Merging Concepts, and Conflict Awareness**

Day 048 will introduce branches and collaboration concepts without advanced rebasing or destructive history rewriting.
