# Day 049 Notes - Git Remote Workflows

## Local Repository

A local repository is the Git repository on your machine. It contains your working tree, local commits, branches, and Git metadata.

## Remote Repository

A remote repository is a shared copy of a repository. It may live on a hosting provider or in another shared location.

## `origin`

`origin` is the common default name Git gives to the remote created by clone. It is a name, not magic.

## Clone

Clone creates a local repository from a remote repository:

```bash
git clone <repository-url>
```

## Fetch

Fetch downloads remote branch information without integrating it into the current branch:

```bash
git fetch
```

## Pull

Pull means fetch plus integrate into the current branch:

```bash
git pull
```

Because pull can change files, check status first.

## Push

Push publishes local commits to a remote repository:

```bash
git push
```

## Remote-Tracking Branches

Remote-tracking branches are local references to remote state, such as `origin/main` or `origin/feature/order-validation`.

## Upstream and Tracking

An upstream branch is the remote branch your local branch tracks. It helps Git know where to push and pull by default.

## Ahead, Behind, and Diverged

Ahead means local has commits remote does not. Behind means remote has commits local does not. Diverged means both sides have different commits.

## Pull Request Thinking

A pull request is a review proposal. It has a source branch, target branch, explanation, validation evidence, and reviewer discussion. It is not a core Git object.

## Safe Mental Model

```text
status
→ fetch
→ inspect
→ integrate
→ validate
→ push
```
