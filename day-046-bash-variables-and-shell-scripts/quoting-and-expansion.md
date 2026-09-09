# Quoting and Expansion

## Double Quotes

```bash
file_path="practice files/orders.csv"
echo "$file_path"
```

Double quotes allow variable expansion while keeping spaces inside the value together.

## Single Quotes

```bash
echo '$file_path'
```

Single quotes print the text literally. The variable is not expanded.

## Unquoted Expansion

```bash
echo $file_path
```

Unquoted variables may be split into words. Wildcard characters may also be expanded. This can surprise beginners.

## Recommended Beginner Habit

> Quote variables unless you have a clear reason not to.

## Spaces in Filenames

```bash
data_file="sample data/orders sample.csv"
echo "$data_file"
```

The quotes keep the path as one value.

## Wildcards and Variables

Wildcards such as `*` can expand into matching file names. That is useful when intentional, but risky when accidental. Day 046 avoids wildcard-driven automation.

## Empty Variables

```bash
input_file=""
echo "$input_file"
```

An empty quoted variable stays one empty value. An unquoted empty variable can disappear from the command line.

## Practice Examples

1. Print a path stored in `"$input_file"`.
2. Compare `echo "$input_file"` with `echo '$input_file'`.
3. Create `folder_name="practice files"`.
4. Print `"$folder_name"`.
5. Create `message="Pipeline review"`.
6. Print `"$message"`.
7. Try `echo '$message'` and notice the literal output.
8. Create `empty_value=""`.
9. Print `"Value: $empty_value"`.
10. Explain why quoted paths are safer in scripts.
