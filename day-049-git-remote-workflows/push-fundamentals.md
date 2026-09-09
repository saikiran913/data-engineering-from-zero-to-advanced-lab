# Push Fundamentals

## First Push for a Feature Branch

```bash
git push -u origin feature/order-validation
```

This publishes the local branch and sets upstream tracking.

## Later Push

```bash
git push
```

After upstream tracking exists, Git usually knows where to push.

## Command Parts

| Part | Meaning |
|---|---|
| `origin` | Remote name |
| `feature/order-validation` | Branch being published |
| `-u` | Set upstream tracking |

## Push Rejection

A push can be rejected if the remote has work your local branch does not contain. Treat rejection as a safety signal, not a reason to force changes.

## Safe Pre-Push Checklist

1. confirm current branch
2. confirm clean status
3. review log
4. check for secrets
5. check for large or generated files
6. complete validation
7. confirm scope is focused
