# Staging Area

## Why Staging Exists

The staging area lets you choose exact changes for the next commit.

## Stage One File

```bash
git add sql/daily_orders.sql
```

This stages one intended file.

## Stage a Directory

```bash
git add docs/
```

This stages changes under a directory.

## Broad Staging

```bash
git add .
```

> `git add .` stages all matching changes under the current path, so inspect `git status` first.

For beginners, explicit staging is often safer.

## Check Staged State

```bash
git status
git diff --staged
```

## Staging Is Not Committing

```text
modified → staged → committed
```

`git add` selects changes. `git commit` records them.

Unstaging commands are a later topic. Today, pause and seek review if the staged set is not what you intended.
