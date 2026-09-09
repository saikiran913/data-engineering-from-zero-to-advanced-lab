# Pull Fundamentals

## Pull

```bash
git pull
```

Pull means fetch plus integrate into the current branch.

## Check Status First

```bash
git status
```

Understand local changes before integrating remote work.

## Possible Pull Outcomes

| Outcome | Meaning |
|---|---|
| Already up to date | No new remote work to integrate |
| Fast-forward | Local branch moves forward to remote state |
| Merge | Local and remote histories are combined |
| Conflict | Git needs a human decision |

## Configuration Note

Pull behaviour can vary by configuration. Day 049 uses merge-based beginner thinking and avoids rebase workflows.

## Safer Inspection Habit

When unsure:

```bash
git fetch
git log --oneline --graph --decorate --all
```

Inspect first, then integrate according to team policy.
