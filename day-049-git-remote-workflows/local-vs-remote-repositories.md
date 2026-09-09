# Local vs Remote Repositories

| Local repository | Remote repository |
|---|---|
| Lives on your machine | Lives in a shared location |
| Has local branches and commits | Has shared branches and commits |
| Can work offline for local history | Helps collaboration |
| Uses working tree files | May not have your local working tree |
| Push sends commits outward | Fetch/pull brings remote state inward |

## Local History

Local commits are recorded on your machine first. They are not automatically shared.

## Remote or Shared History

Remote history is the shared history others may fetch, pull, or review.

## `origin` Convention

`origin` commonly points to the remote repository created by `git clone`.

## Multiple Remotes Conceptually

A repository can have more than one remote, but Day 049 focuses on one remote named `origin`.

## Remote Is Not Just Backup

A remote repository supports collaboration and shared history. It should not be treated as the only backup plan for all data.
