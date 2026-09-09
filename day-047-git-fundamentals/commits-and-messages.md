# Commits and Messages

## What a Commit Is

A commit records a logical change in repository history.

## Commit Command

```bash
git commit -m "Add daily order validation query"
```

The `-m` option provides the commit message directly.

## Good Commit Message Qualities

- concise
- purpose-focused
- clear to a future reader
- one logical change
- imperative style is acceptable

## Bad Commit Message Examples

```text
changes
update
stuff
final
misc
```

These do not explain intent.

## Small Logical Commits

Good:

```text
Commit 1: Add order validation SQL
Commit 2: Add validation documentation
```

Poor:

```text
One giant commit with SQL, unrelated formatting, temporary logs, and private notes
```

## Commit Prerequisites

Git may require identity configuration:

```bash
git config user.name
git config user.email
```

If Git asks for identity configuration, use the appropriate name/email for your own environment or follow your organisation's policy. Do not commit credentials.

## Local Commit

> A local commit remains local until a remote operation is performed.

Remote operations are out of scope for Day 047.
