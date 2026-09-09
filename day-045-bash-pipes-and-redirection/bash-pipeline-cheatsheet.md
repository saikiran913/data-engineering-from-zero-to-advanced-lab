# Bash Pipeline Cheatsheet

## Streams

```text
0 stdin
1 stdout
2 stderr
```

## Pipe

```bash
command1 | command2
```

## Overwrite stdout

```bash
command > file.txt
```

Warning: `>` can replace existing file content.

## Append stdout

```bash
command >> file.txt
```

## Redirect stderr

```bash
command 2> errors.txt
```

## Append stderr

```bash
command 2>> errors.txt
```

## Combine stderr With stdout

```bash
command > all.txt 2>&1
```

## Read From stdin

```bash
command < input.txt
```

## Common Safe Pipeline

```bash
grep "ERROR" log.txt | wc -l
```

## Safety Checklist

- Check `pwd`.
- Inspect output first.
- Keep write targets inside `practice-output/`.
- Never overwrite source files.
- Review captured errors.
- Remember that Bash and PowerShell syntax differ.

