# Synchronisation and Divergence

## In Sync

```text
local main:  A---B
origin/main: A---B
```

Both point to the same history.

## Local Ahead

```text
origin/main: A---B
local main:  A---B---C
```

Local has commit `C` that remote does not.

## Local Behind

```text
local main:  A---B
origin/main: A---B---C
```

Remote has commit `C` that local does not.

## Diverged

```text
local main:  A---B---D
origin/main: A---B---C
```

Both sides have different new commits after `B`.

## Safe Flow

```text
status
→ fetch
→ inspect graph
→ compare
→ integrate according to team policy
→ validate
→ push
```

## Push Rejection

Push rejection often means remote has work your local branch does not contain. It protects shared history from being overwritten accidentally.
