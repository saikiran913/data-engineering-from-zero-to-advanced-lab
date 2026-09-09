# Conflict Resolution Guide

## Step 1 - Stop and Inspect

```bash
git status
```

Understand which files need resolution.

## Step 2 - Open Conflicted File

Open the file listed by Git.

## Step 3 - Find Markers

Search for:

```text
<<<<<<<
=======
>>>>>>>
```

## Step 4 - Understand Both Versions

Ask:

- what did the target branch intend?
- what did the feature branch intend?
- what should final business logic be?

## Step 5 - Edit Final Content Manually

Choose the final content and remove all markers.

## Step 6 - Validate Syntax and Business Logic

For SQL:

- read or run the query safely
- check grain
- check filters
- check joins

For Bash:

- inspect the script
- run on sample data if safe

## Step 7 - Mark Resolved

```bash
git add path/to/resolved-file
```

## Step 8 - Check Status

```bash
git status
```

## Step 9 - Complete Merge Commit

```bash
git commit -m "Resolve order validation merge conflict"
```

Git may prepopulate a merge message in some contexts. Day 048 uses a clear message for simplicity.

## Step 10 - Inspect History

```bash
git log --oneline --graph --decorate --all
```

## Resolution Checklist

- no conflict markers
- intended logic preserved
- source files valid
- resolved file staged
- status clean after commit
