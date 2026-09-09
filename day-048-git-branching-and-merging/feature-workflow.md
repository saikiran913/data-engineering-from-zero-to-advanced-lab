# Feature Workflow

Example feature: add order-status validation documentation.

## Step 1 - Start on Default Branch

```bash
git status
git branch --show-current
```

Confirm the working tree is understood before creating a branch.

## Step 2 - Create Feature Branch

```bash
git switch -c feature/order-status-validation
```

## Step 3 - Edit One File

Edit:

```text
docs/validation-notes.md
```

Keep the change focused on order-status validation.

## Step 4 - Review Changes

```bash
git status
git diff
```

## Step 5 - Validate Work

Read the file and confirm the wording is correct. For SQL or Bash changes, run safe local checks when possible.

## Step 6 - Stage the File

```bash
git add docs/validation-notes.md
```

## Step 7 - Review Staged Diff

```bash
git diff --staged
```

## Step 8 - Commit

```bash
git commit -m "Add order status validation notes"
```

The commit exists on the feature branch. The default branch has not changed yet.

## Step 9 - Inspect Log

```bash
git log --oneline
```

## Step 10 - Compare With Default Branch

```bash
git diff main..feature/order-status-validation
```

Replace `main` with the actual default branch name if needed.
