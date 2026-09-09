# Gitignore Concepts

`.gitignore` tells Git which untracked files should normally stay out of staging.

## Why Ignore Files?

Ignore files such as:

- temporary outputs
- logs
- local environments
- caches
- generated files

Credentials and secrets should not merely rely on ignore rules. They should not be placed in repository files.

## Safe Example

```text
practice-output/
*.tmp
*.log
.env
```

## Important Warning

> `.gitignore` prevents untracked matching files from being staged normally, but it does not remove secrets that were already committed.

Secret-history cleanup is advanced and out of scope.

## Tracked Files Stay Tracked

If Git already tracks a file, adding it to `.gitignore` later does not automatically stop tracking it. That cleanup is a later topic.

## Beginner Habit

Use `git status` before staging. If a file looks temporary, generated, private, or secret-like, pause before adding it.
