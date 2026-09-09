# Branch Fundamentals

## List Branches

```bash
git branch
```

This lists local branches.

## Show Current Branch

```bash
git branch --show-current
```

This prints the branch you are currently on.

## HEAD Concept

HEAD is the current position in the repository. Beginners can think of it as "where Git is looking right now".

## Branch Pointer Concept

A branch name points to a commit. As new commits are added on that branch, the pointer moves forward.

## Same Commit, Multiple Branches

Two branches can point to the same commit before one branch receives new commits.

## Branch Names

Good examples:

```text
feature/order-validation
fix/customer-join
docs/update-readme
```

Avoid vague names:

```text
test
stuff
new
final
```

Branch naming conventions vary by team.

## Branch Is Not a Folder

A branch is not a folder. It is a named line of Git history.

## Branch Is Not a Full Duplicate Repository

A branch is not a full copy of the repository. Git stores history efficiently and moves between branch states.
