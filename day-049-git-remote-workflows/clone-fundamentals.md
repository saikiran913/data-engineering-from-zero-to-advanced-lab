# Clone Fundamentals

## Clone Command

```bash
git clone <repository-url>
```

The repository URL may come from a hosting provider or a local practice remote.

## What Clone Typically Does

Clone usually:

- downloads repository history
- creates a local working copy
- creates local Git metadata
- configures `origin`
- checks out the default branch

## After Clone

```bash
cd repository-name
git status
git remote -v
git branch
```

These commands help confirm location, remote configuration, and branches.

## Safety Warning

Avoid cloning inside another tracked repository unintentionally. Use `pwd`, `ls`, and repository-root checks before creating practice clones.

## Installation Note

```bash
git --version
```

If Git is not installed, installation depends on operating system. Day 049 does not teach package-manager installation commands.
