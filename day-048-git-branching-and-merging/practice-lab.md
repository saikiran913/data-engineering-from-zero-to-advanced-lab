# Create, Merge, and Resolve a Safe Local Git Branch

Use a disposable local copy of `practice-repo-template/`.

Do not commit nested `.git` metadata back into the main repository. Use no remote operations, no rebase, and no destructive history commands.

## Setup

```bash
pwd
git rev-parse --is-inside-work-tree
cp -R practice-repo-template practice-repo
cd practice-repo
```

If you are already inside a Git work tree, do not initialise another repository there unless you are using a truly isolated copy for practice and understand it must not be committed back into the parent repository.

## Part 1 - Initialise Practice Repo Safely

```bash
git init
```

## Part 2 - Create Initial Commit

```bash
git add README.md sql/ scripts/ docs/ sample-data/
git commit -m "Add initial practice files"
```

## Part 3 - Confirm Current Branch

```bash
git branch --show-current
```

If Git created `master` instead of `main`, do not force rename it for this lab. Use whatever default branch your local Git created.

For the rest of the lab, replace:

```text
<default-branch>
```

with your actual branch name.

## Part 4 - Create Feature Branch

```bash
git switch -c feature/order-validation
```

## Part 5 - Modify Feature File

Edit `docs/validation-notes.md` and add a short note about reviewing unexpected statuses.

## Part 6 - Review and Commit

```bash
git status
git diff
git add docs/validation-notes.md
git diff --staged
git commit -m "Add order status validation guidance"
```

## Part 7 - Compare Branch Graph

```bash
git log --oneline --graph --decorate --all
```

## Part 8 - Switch to Default Branch

```bash
git switch <default-branch>
```

## Part 9 - Merge Feature Branch

```bash
git merge feature/order-validation
```

## Part 10 - Validate Clean Merge

```bash
git status
git log --oneline --graph --decorate --all
```

Read `docs/validation-notes.md` and confirm the final content is correct.

## Part 11 - Create Conflict Scenario

Create a branch:

```bash
git switch -c feature/status-note
```

Modify the allowed-status line in `docs/validation-notes.md` to:

```text
COMPLETED, PENDING, CANCELLED
```

Commit:

```bash
git add docs/validation-notes.md
git commit -m "Add cancelled status to validation notes"
```

Switch back:

```bash
git switch <default-branch>
```

Modify the same allowed-status line differently:

```text
COMPLETED, PENDING, REFUNDED
```

Commit:

```bash
git add docs/validation-notes.md
git commit -m "Add refunded status to validation notes"
```

## Part 12 - Merge Conflicting Branch

```bash
git merge feature/status-note
```

## Part 13 - Inspect Conflict

```bash
git status
```

Open `docs/validation-notes.md` and inspect the markers.

## Part 14 - Resolve Manually

Choose a sensible final line:

```text
COMPLETED, PENDING, CANCELLED, REFUNDED
```

Remove all conflict markers.

## Part 15 - Validate File

Read the file and confirm the final text is valid.

## Part 16 - Stage Resolved File

```bash
git add docs/validation-notes.md
```

## Part 17 - Complete Merge

```bash
git commit -m "Resolve status note merge conflict"
```

## Part 18 - Inspect History Graph

```bash
git log --oneline --graph --decorate --all
```

## Part 19 - Final Status

```bash
git status
```

## Lab Checklist

- You know the current/default branch.
- You created a feature branch.
- You committed feature work.
- You merged cleanly.
- You created a safe conflict.
- You resolved the conflict manually.
- You removed markers.
- You staged the resolved file.
- You validated the final state.
- You used no destructive commands.
- You used no remote commands.
