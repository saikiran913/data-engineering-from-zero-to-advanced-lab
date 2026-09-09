# Fetch Fundamentals

## Fetch

```bash
git fetch
```

Fetch downloads remote references. It does not automatically change the current working branch.

## Fetch a Named Remote

```bash
git fetch origin
```

This fetches from the remote named `origin`.

## Inspect After Fetch

```bash
git log --oneline --graph --decorate --all
```

This helps show local branches and remote-tracking branches.

## Why Fetch Is Useful

Fetch is useful when you want to inspect remote changes before integrating them.

## Important Distinction

Fetch updates remote-tracking references such as `origin/main`. It does not automatically make your current branch contain those commits.
