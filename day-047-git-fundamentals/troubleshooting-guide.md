# Troubleshooting Guide

## Troubleshooting Flow

```text
1. pwd
2. git rev-parse --show-toplevel
3. git status
4. git diff
5. git diff --staged
6. inspect files
7. act only after repository state is understood
```

## `fatal: not a git repository`

You may be in the wrong directory, or the folder may not have been initialised as a repository. Use `pwd`, `ls`, and the repository-root command to orient yourself.

## Accidentally Ran `git init` in Wrong Folder

Stop. Do not make further changes. Understand whether nested metadata was created. Seek review before deleting metadata. Day 047 does not teach destructive cleanup commands.

## Git Asks for User Name or Email

Git needs identity information to create commits. Use the appropriate name/email for your own environment or follow your organisation's policy. Do not place credentials in repository files.

## Nothing to Commit

Possible reasons:

- no changes exist
- changes were already committed
- you are in the wrong directory

## File Not Shown in Status

Possible reasons:

- file is ignored
- file is outside the repository
- file is unchanged

## `git diff` Shows Nothing

Possible reasons:

- file is untracked
- change is already staged
- no change exists

## `git diff --staged` Shows Nothing

Nothing is staged.

## Commit Message Editor Opened Unexpectedly

This can happen when `git commit` is run without `-m`. Day 047 uses:

```bash
git commit -m "message"
```

## Large Unexpected Staged Set

Stop. Inspect status. Do not commit blindly. Recovery and unstaging commands are outside Day 047; seek review.

## Secret Appears in Diff

Do not commit. Remove the secret from the file safely. If it has already been exposed externally, rotate the credential. History cleanup is advanced and out of scope.

## Wrong Repository

Use:

```bash
git rev-parse --show-toplevel
```

Then confirm the path is the repository you intended.
