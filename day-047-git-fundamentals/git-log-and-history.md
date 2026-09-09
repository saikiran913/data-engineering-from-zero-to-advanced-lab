# Git Log and History

## Full Log

```bash
git log
```

This shows commit history with details.

## Compact Log

```bash
git log --oneline
```

This shows one commit per line.

## Limit Entries

```bash
git log --oneline -5
```

This shows the latest five commits.

## Show a Commit

```bash
git show <commit-hash>
```

Use the hash shown in the log.

## Show Stats

```bash
git show --stat <commit-hash>
```

This shows which files changed and a summary of line changes.

## Commit Hash

A commit hash is a unique identifier for a commit. Abbreviated hashes are commonly shown. You do not need to memorise them.

## Read History Questions

- what changed?
- when did it change?
- why did it change?
- which files changed?

## History as Reproducibility Evidence

History helps connect a result to the exact SQL, script, config, and documentation version used at that time.
