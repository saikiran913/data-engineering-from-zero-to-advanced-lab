# Loops and Repetition

Loops repeat commands for several values.

## Loop Over Explicit Files

```bash
for file in \
    sample-data/customers_sample.csv \
    sample-data/orders_sample.csv
do
    echo "Reviewing: $file"
    wc -l "$file"
done
```

This repeats the same review for two known files.

## Loop Over Arguments

```bash
for file in "$@"
do
    echo "$file"
done
```

`"$@"` means all arguments, kept safely separated.

## Loop Safety

- quote `"$file"`
- validate each file
- do not loop changing commands
- be careful with wildcards
- understand how many iterations will occur

## File Catalog Example

`sample-data/file_catalog.txt` lists known sample files. A future lesson may read lists line by line. Day 046 keeps loops simple and explicit.

## Practice

1. Loop over two known CSV files.
2. Print each file name.
3. Count lines for each file.
4. Loop over `"$@"`.
5. Validate each file inside a loop.
6. Continue safely if one file is missing.
7. Count reviewed files conceptually.
8. Count missing files conceptually.
9. Explain why loops magnify mistakes.
10. Explain why destructive loop actions are avoided in Day 046.
