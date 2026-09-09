# Git Diff and Review

## `git diff`

`git diff` shows unstaged changes.

```bash
git diff
```

## `git diff --staged`

`git diff --staged` shows staged changes.

```bash
git diff --staged
```

## What a Diff Contains

A diff can show file paths, context lines, removed lines, and added lines.

```diff
- WHERE order_status = 'complete'
+ WHERE order_status = 'COMPLETED'
```

The removed line starts with `-`. The added line starts with `+`.

## Why Review Diffs?

Review diffs to catch:

- accidental edits
- secrets
- debug output
- unrelated changes
- business-logic mistakes

## Untracked File Content

`git diff` does not automatically show the content of every untracked file. Use `git status` to notice untracked files and inspect them before staging.

## Review Checklist Before Staging

- correct file?
- correct logic?
- no secrets?
- no generated junk?
- no unrelated edits?

## Review Checklist Before Commit

- staged diff matches the commit purpose?
- message explains the change?
- status contains only intended staged files?
