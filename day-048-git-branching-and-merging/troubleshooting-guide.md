# Troubleshooting Guide

## Troubleshooting Flow

```text
1. pwd
2. git rev-parse --show-toplevel
3. git branch --show-current
4. git status
5. git log --oneline --graph --decorate --all
6. inspect diff/conflict markers
7. act only after state is understood
```

## `fatal: not a git repository`

You are probably in the wrong directory, or the practice repo has not been initialised.

## Wrong Current Branch

Use:

```bash
git branch --show-current
git status
```

Then pause before editing or merging.

## Branch Already Exists

Use the existing branch if it is the intended one, or choose a different meaningful branch name. Do not delete blindly.

## Cannot Switch Branches Because of Local Changes

Stop. Inspect status and diff. Commit or resolve work intentionally. Stash is out of scope for Day 048.

## Merge Says Already Up to Date

The target branch already contains the source branch changes.

## Merge Fast-Forwarded Unexpectedly

This is normal when the target branch has no separate commits after the branch point.

## Merge Conflict Appears

Use the conflict workflow: status, open file, understand both versions, edit final content, remove markers, validate, stage, commit.

## Conflict Markers Remain

Search the file for marker text:

```text
<<<<<<<
=======
>>>>>>>
```

Remove markers only after choosing final content.

## `git add` After Conflict Feels Unusual

After a conflict, `git add` marks the file as resolved.

## `git commit` After Conflict

The commit completes the merge resolution.

## History Graph Looks Different

Git topology can vary depending on default branch name, commit order, and whether a merge was fast-forward.

## Default Branch Is `master`, Not `main`

Both are possible. Use whatever default branch your practice repository created.

## Accidentally Merged From Wrong Branch

Stop. Inspect history and status. Do not use destructive recovery commands. Seek review before changing history.

## Nested Repository Warning

Use:

```bash
git rev-parse --show-toplevel
```

Confirm you are in the intended disposable practice repository before initialising or merging.
