# Merge Conflicts

## Why Conflicts Happen

Conflicts happen when branches change the same area differently and Git cannot safely decide the final result.

Main changes:

```text
Allowed statuses: COMPLETED, PENDING
```

Feature changes:

```text
Allowed statuses: COMPLETED, PENDING, CANCELLED
```

If both changes affect the same line, Git may ask for a human decision.

## Conflict Markers

```text
<<<<<<< HEAD
Allowed statuses: COMPLETED, PENDING
=======
Allowed statuses: COMPLETED, PENDING, CANCELLED
>>>>>>> feature/order-validation
```

`<<<<<<< HEAD` starts the current branch version.

`=======` separates the versions.

`>>>>>>> feature/order-validation` ends the incoming branch version.

## Conflict Is Not Corruption

Git stopped to protect the file. The user decides final content.

## `git status` During Conflict

```bash
git status
```

Status shows unmerged paths and files needing resolution.

## Do Not Blindly Choose One Side

Business logic should determine the final content.

## Conflict Types Conceptually

- same-line edit
- nearby edit
- delete/modify conflict

Advanced conflict types come later.
