# Bash Scripting Cheatsheet

## Variable

```bash
name="value"
echo "$name"
```

## Path Variable

```bash
data_dir="sample-data"
file="$data_dir/orders_sample.csv"
```

## Command Substitution

```bash
count=$(wc -l < "$file")
```

## First Argument

```bash
input="$1"
```

## Argument Count

```bash
"$#"
```

## All Arguments

```bash
"$@"
```

## File Check

```bash
[ -f "$file" ]
```

## Directory Check

```bash
[ -d "$dir" ]
```

## Non-Empty File Check

```bash
[ -s "$file" ]
```

## Empty String

```bash
[ -z "$value" ]
```

## If

```bash
if [ -f "$file" ]; then
    echo "Found"
else
    echo "Missing" >&2
fi
```

## Loop

```bash
for file in "$@"
do
    echo "$file"
done
```

## Exit

```bash
exit 0
exit 1
```

## Safety

- quote variables
- validate inputs
- use safe paths
- keep scripts read-only by default
- send error messages to stderr
- test manually before scheduling
