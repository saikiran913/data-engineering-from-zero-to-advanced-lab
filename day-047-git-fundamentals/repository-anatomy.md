# Repository Anatomy

## Repository Root

The repository root is the top-level folder of a Git project.

Find it with:

```bash
git rev-parse --show-toplevel
```

## `.git` Concept

`.git` stores Git metadata and history. Do not edit it manually.

## Working Tree

The working tree contains the current project files.

## Files and Folders

A repository can contain SQL, scripts, docs, configs, and sample data:

```text
project/
├── .git/          # Git metadata - do not edit manually
├── sql/
├── scripts/
├── docs/
├── .gitignore
└── README.md
```

## Tracked Files

Tracked files are already known to Git.

## Untracked Files

Untracked files are new files Git is not tracking yet.

## Ignored Files

Ignored files match `.gitignore` rules and normally stay out of staging.

## Commit History

Commit history is the sequence of recorded changes.

## Existing Repo Versus New Repo

In an existing repository, begin with:

```bash
git status
```

In a new isolated practice directory, `git init` creates a new repository.

> Never run `git init` blindly when you are unsure whether you are already inside a repository.

Useful check:

```bash
git rev-parse --is-inside-work-tree
```

If it prints `true`, you are inside a Git working tree.

Do not commit nested `.git` metadata into another repository.
