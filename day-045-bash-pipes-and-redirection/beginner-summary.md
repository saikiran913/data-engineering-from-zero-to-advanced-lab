# Beginner Summary

Day 045 introduced Bash pipes and redirection. Bash commands communicate through streams. `stdin` is input, `stdout` is normal output, and `stderr` is error output. File descriptors name these streams conceptually: `0` for stdin, `1` for stdout, and `2` for stderr.

The pipe operator `|` connects commands. It sends stdout from the command on the left into stdin of the command on the right. A common Data Engineering pattern is:

```bash
grep "ERROR" sample-data/pipeline_log.txt | wc -l
```

This filters error lines, then counts them.

Redirection sends output to files. `>` writes stdout to a target file and can overwrite existing content. `>>` appends stdout to the end of a file. `<` can provide file input. `2>` redirects stderr, and `2>>` appends stderr. `2>&1` combines stderr with stdout conceptually.

Command order matters. `sort | uniq` is common because `uniq` normally works on adjacent duplicates. `grep | wc -l` is common because filtering before counting answers a specific question.

`cut` can select simple delimited fields, but it is not a full CSV parser. Quoted commas, embedded delimiters, multiline fields, and nested structures need proper parsers.

`tee` can display output and write it to a file at the same time, but it can also overwrite files unless append mode is used.

Always inspect paths before redirecting. Never redirect into source files. Keep Day 045 practice outputs inside `practice-output/`.

Mental model:

```text
What is the input?
→ Which command should process it?
→ Should output continue to another command?
→ Should stdout be displayed or saved?
→ Where should stderr go?
→ Is the target path safe?
```

Required warnings:

> The `>` operator can overwrite an existing file. Always check the target path before redirecting output.

> Use a dedicated practice directory for redirection exercises. Never practise by redirecting into important source, configuration, or project files.

> Shell text-processing commands are useful for simple inspection and transformation, but they are not reliable substitutes for proper CSV, JSON, or structured-data parsers when quoting, embedded delimiters, multiline fields, or nested structures are involved.

> Error redirection and combined output can hide important failures if used carelessly. Always inspect captured error output before assuming a command succeeded.

Day 046 will deepen safe text processing and log investigation without introducing destructive shell automation.

