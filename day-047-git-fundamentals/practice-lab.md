# Create and Review a Safe Local Git History

This lab uses a disposable local copy of `practice-repo-template/`.

Do not commit nested `.git` metadata into the main repository.

## Safe Setup

```bash
cp -R practice-repo-template practice-repo
cd practice-repo
```

> Confirm the source and destination paths before copying. This copies the template; it does not delete or overwrite source files.

## Part 1 - Verify Location

```bash
pwd
ls
```

## Part 2 - Initialise Isolated Practice Repo

Before running the command, verify you are inside the disposable `practice-repo` folder. If unsure, use:

```bash
git rev-parse --show-toplevel
```

Only inside the disposable folder:

```bash
git init
```

Nested `.git` metadata must not be committed back into the main learning repository.

## Part 3 - Status

```bash
git status
```

## Part 4 - Inspect Files

```bash
ls
ls sql
ls scripts
ls docs
```

## Part 5 - Stage README Only

```bash
git add README.md
```

## Part 6 - Review Status

```bash
git status
```

## Part 7 - Review Staged Diff

```bash
git diff --staged
```

Initial-file staging may display differently across Git versions. The important idea is to inspect what is staged before committing.

## Part 8 - First Commit

```bash
git commit -m "Add practice repository README"
```

If Git asks for identity configuration, use the troubleshooting guide rather than placing personal values in the tutorial.

## Part 9 - Stage Remaining Template Files

```bash
git add sql/ scripts/ docs/ sample-data/
```

## Part 10 - Commit

```bash
git commit -m "Add sample data engineering files"
```

## Part 11 - Modify SQL Safely

Open `sql/daily_orders.sql` and change a comment or a simple readable alias. Keep the SQL SELECT-only.

## Part 12 - Check Status

```bash
git status
```

## Part 13 - Review Diff

```bash
git diff
```

## Part 14 - Stage SQL File

```bash
git add sql/daily_orders.sql
```

## Part 15 - Review Staged Diff

```bash
git diff --staged
```

## Part 16 - Commit Meaningful Change

```bash
git commit -m "Refine daily orders query comment"
```

## Part 17 - Inspect Log

```bash
git log --oneline
```

## Part 18 - Inspect Latest Commit

```bash
git show --stat HEAD
```

## Part 19 - Review Clean Status

```bash
git status
```

## Lab Checklist

- You understand repository.
- You understand untracked, modified, staged, and committed.
- You know status, diff, add, commit, log, and show.
- You created only local commits.
- You did not use remote operations.
- You did not commit secrets.
- You did not alter main repository history unintentionally.
