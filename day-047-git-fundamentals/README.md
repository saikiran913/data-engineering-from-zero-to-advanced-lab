# Day 047 — Git Fundamentals

Day 047 introduces repositories, status, diffs, staging, commits, logs, and reproducible work.

Day 046 created reusable Bash scripts. Day 047 introduces version control so scripts, SQL, documentation, and configuration can be tracked over time. Git provides history, reviewability, and reproducibility.

Git commands are largely the same across Linux, macOS, Windows Git Bash, and PowerShell. File paths and shell syntax may differ, but Git concepts remain the same.

## Learning Objectives

By the end of this day, you should understand:

- what version control is
- what Git is
- what GitHub is
- Git versus GitHub
- what a repository is
- what `.git` means conceptually
- working tree and working directory
- tracked, untracked, modified, staged, and committed files
- commit history, commit hashes, commit messages, and HEAD
- why Git has a staging area
- what `git status`, `git diff`, and `git diff --staged` show
- what `git add`, `git commit`, `git log`, and `git show` do
- what `git init` means conceptually
- why not to run `git init` blindly inside an existing repository
- why `git add <file>` is often safer than broad staging for beginners
- why commits should be small and logical
- why secrets, credentials, confidential data, and generated files should not be committed
- what `.gitignore` means conceptually
- how Git history supports reproducible Data Engineering work

## Why Git Matters for Data Engineers

Data Engineers use Git to:

- track SQL changes
- track Bash and Python scripts
- track data-quality rules
- track pipeline configuration
- review changes before deployment
- reproduce earlier versions
- understand who changed what conceptually
- collaborate later
- support code review later
- document technical evolution

## Required Safety Warnings

> Git records changes, but it does not automatically protect sensitive information. Never commit passwords, API keys, tokens, private credentials, or confidential data.

> Check `git status` and `git diff` before every commit so you understand exactly what will be recorded.

> Avoid using broad staging commands blindly. `git add .` can stage more files than intended, so beginners should understand the repository state first.

> Do not initialize a new Git repository inside an existing repository unless you intentionally want a nested repository. Day 047 should use the existing learning repository for concepts and a clearly isolated practice example for `git init`.

## Recommended Learning Order

1. `notes.md`
2. `git-vs-github.md`
3. `repository-anatomy.md`
4. `git-status-and-working-tree.md`
5. `git-diff-and-review.md`
6. `staging-area.md`
7. `commits-and-messages.md`
8. `git-log-and-history.md`
9. `gitignore-concepts.md`
10. `reproducible-work.md`
11. inspect `practice-repo-template/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review `git-fundamentals-cheatsheet.md`
15. complete `practice-questions.md`
16. read `beginner-summary.md`
17. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Git | Version control tool |
| GitHub | Hosting and collaboration platform built around Git repositories |
| Repository | Project folder with Git history |
| Working tree | Current project files you can see and edit |
| Tracked | Git already knows about the file |
| Untracked | Git does not yet track the file |
| Modified | Tracked file changed since last commit |
| Staged | Selected for the next commit |
| Staging area | Place where selected changes wait before commit |
| Commit | Recorded logical change |
| Commit hash | Identifier for a commit |
| HEAD | Current checked-out commit conceptually |
| History | Sequence of commits |
| Diff | View of line-level changes |
| `.gitignore` | Rules for files Git should normally ignore |
| Reproducibility | Ability to trace which version produced a result |

## Safe-Learning Note

Remote Git workflows are intentionally out of scope. Day 047 does not teach push, pull, branching, merging, rebasing, or pull requests. Do not commit nested `.git` metadata. Practice uses an isolated local copy of `practice-repo-template/`.

## Navigation

- Previous Day: [Day 046 - Bash Variables and Shell Scripts](../day-046-bash-variables-and-shell-scripts/)
- Next Day: [Day 048 - Git Branching and Merging](../day-048-git-branching-and-merging/)
- [Back to Main Learning Path](../README.md)
