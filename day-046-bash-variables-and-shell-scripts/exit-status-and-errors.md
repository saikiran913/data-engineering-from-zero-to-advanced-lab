# Exit Status and Errors

## Command Exit Status

Every command returns an exit status.

```bash
grep "ERROR" sample-data/pipeline_log.txt
echo "$?"
```

`$?` contains the previous command's exit status. Check it immediately because the next command replaces it.

## Success

`0` commonly means success.

## Failure

A non-zero value commonly means failure or a special non-success result. Exact meanings depend on the command.

## Script Exit

```bash
exit 0
```

This means the script completed successfully.

```bash
exit 1
```

This means the script stopped because something failed or required validation did not pass.

## Error Messages to stderr

```bash
echo "Input file missing" >&2
```

This sends the message to stderr, which keeps errors separate from normal output.

## Why Errors Should Be Distinct

Day 045 introduced stdout and stderr. Scripts should continue that habit so normal results and errors can be captured separately.

## Do Not Overuse `$?`

`$?` must be checked immediately. Simple `if` statements are often clearer for beginners.

## Error Handling Caution

Some Bash options can change how scripts stop on errors. For example, `set -e` is sometimes used to stop after errors, but its behaviour can surprise beginners. Advanced shell error handling comes later.
