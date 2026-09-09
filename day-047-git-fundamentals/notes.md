# Day 047 Notes - Git Fundamentals

## What Is Version Control?

Version control records change history. It helps compare versions, understand why work changed, reproduce previous states, and support collaboration later.

Without version control, changes may live only as loose files such as `final.sql`, `final_v2.sql`, and `final_really_final.sql`. Git gives those changes a clear history.

## What Is Git?

Git is a distributed version control system. A local Git repository contains project files and history on your machine. Git can work without GitHub.

## What Is GitHub?

GitHub is a hosted collaboration platform built around Git repositories. It helps teams share repositories, review code, and collaborate remotely. GitHub is not the same thing as Git.

## Basic Git Workflow

```text
working tree
→ staging area
→ commit
→ history
```

## Working Tree

The working tree is the current checked-out project files. These are the files you can inspect and edit.

## Untracked

An untracked file is a new file Git does not yet track.

## Modified

A modified file is a tracked file that changed since the last commit.

## Staged

A staged change has been selected for the next commit.

## Commit

A commit is a recorded logical change. It includes a hash, author, date, message, and the changes recorded at that moment.

## HEAD

HEAD is a pointer to the current checked-out commit conceptually. Beginners can think of it as "where the repository currently is in history".

## Repository

A repository is a project managed by Git. The `.git` folder stores repository metadata and history conceptually. Do not manually edit `.git`.

## Reproducibility

Git helps Data Engineers know which version of SQL, Bash, Python, configuration, or documentation produced a result. This is important when investigating issues later.

## Safe Workflow

```text
git status
→ edit
→ git status
→ git diff
→ git add intended-file
→ git status
→ git diff --staged
→ git commit
→ git log --oneline
```

## Small Commits

A small commit has one logical purpose. Small commits are easier to review, explain, and understand later.

## Commit Messages

Good examples:

```text
Add order validation query
Fix customer join logic
Document staging checks
```

Poor examples:

```text
changes
update
stuff
final
```
