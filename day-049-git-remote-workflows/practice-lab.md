# Simulate a Safe Remote Git Collaboration Workflow

Use only disposable local practice. Do not perform real remote operations on the main learning repository.

This lab may create:

```text
remote.git
developer-a/
developer-b/
```

`remote.git` is a local bare repository used only to simulate a shared remote. Do not commit it into the main educational repository.

## Part 1 - Create Disposable Area

Create a separate practice area outside committed lesson content, then enter it.

## Part 2 - Initialise Bare Remote

```bash
git init --bare remote.git
```

A bare repository has no working tree. It is used here only as a local shared remote simulation.

## Part 3 - Clone as Developer A

```bash
git clone remote.git developer-a
cd developer-a
```

## Part 4 - Copy Template Files

Copy files from `remote-simulation-template/` into `developer-a/`. Confirm paths before copying.

## Part 5 - Initial Commit

```bash
git status
git add README.md sql/ scripts/ docs/ sample-data/
git commit -m "Add initial remote workflow practice files"
```

## Part 6 - Inspect Default Branch

```bash
git branch --show-current
```

Use the actual default branch name in your practice repository.

## Part 7 - Push Initial Branch

```bash
git push -u origin <default-branch>
```

## Part 8 - Clone as Developer B

From the disposable area:

```bash
git clone remote.git developer-b
```

## Part 9 - Developer A Creates Feature Branch

```bash
git switch -c feature/order-validation
```

## Part 10 - Commit Feature

Modify `docs/validation-notes.md`, then:

```bash
git status
git diff
git add docs/validation-notes.md
git diff --staged
git commit -m "Add order validation review note"
```

## Part 11 - Push Feature Branch

```bash
git push -u origin feature/order-validation
```

## Part 12 - Developer B Fetches

In `developer-b/`:

```bash
git fetch
git branch -vv
git log --oneline --graph --decorate --all
```

## Part 13 - Inspect Remote Feature

Look for `origin/feature/order-validation` in the graph.

## Part 14 - Developer B Updates Default Branch

Make a small documentation change, commit it, and push the default branch.

## Part 15 - Developer A Fetches

```bash
git fetch
git log --oneline --graph --decorate --all
```

## Part 16 - Inspect Divergence

Use the graph to see local feature work and updated remote default branch.

## Part 17 - Integrate Latest Default Branch

Use the merge-based Day 048 workflow according to the practice repository's branch names.

## Part 18 - Validate

Run the safe script:

```bash
bash scripts/validate_orders.sh sample-data/orders_sample.csv
```

## Part 19 - Push Feature Again

```bash
git push
```

Do not force push.

## Part 20 - Draft Pull Request Thinking

Write a short draft:

```text
Title:
Add order validation review note

Description:
Adds documentation for reviewing order validation output.

Validation:
Ran safe sample validation script.
```

## Part 21 - Developer B Reviews Conceptually

Reviewer checks:

- focused diff
- no secrets
- no generated files
- validation evidence
- clear target branch

## Part 22 - Final Checklist

- clone/fetch/pull/push concepts understood
- no real credentials used
- no real remote required
- no force push
- no rebase
- no destructive history commands
