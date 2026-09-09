# Git Status and the Working Tree

`git status` is the first safety command.

```bash
git status
```

It tells you what Git sees.

## Clean Working Tree

Simplified wording:

```text
nothing to commit, working tree clean
```

This means there are no tracked changes waiting.

## Untracked File

An untracked file is new. Git sees it but does not track it yet.

## Modified File

A modified file is tracked and changed since the last commit.

## Staged File

A staged file has changes selected for the next commit.

## Multiple States

A file can have staged and unstaged changes conceptually if it was edited again after staging.

## Short Status

```bash
git status --short
```

This gives a compact state summary. Full `git status` is usually clearer for beginners.

## Safe Habit

Run `git status` before editing, before staging, before committing, and after committing.

## Practice Interpretation

| Scenario | Meaning |
|---|---|
| `nothing to commit` | No changes waiting |
| `README.md` listed as modified | A tracked README changed |
| `notes.md` listed as untracked | New file not yet tracked |
| `sql/daily_orders.sql` staged | Selected for next commit |
| Modified file not staged | Change exists but is not selected |
| Staged file changed again | Both staged and unstaged versions may exist |
| New `.env` appears | Do not commit secrets |
| Generated log appears | Usually do not commit generated output |
| Only docs changed | Commit may be documentation-only |
| SQL and related docs changed | They may belong in one logical commit |
| Many unrelated files changed | Pause and inspect carefully |
| Clean after commit | Recorded changes are now in history |
