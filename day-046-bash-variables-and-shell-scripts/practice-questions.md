# Practice Questions

## Section A - Concept Checks

1. What is a shell variable?
2. How do you assign `name` the value `orders` in Bash?
3. Why should there be no spaces around `=`?
4. What is variable expansion?
5. Why are path variables usually quoted?
6. What do double quotes do?
7. What do single quotes do?
8. What is command substitution?
9. What does `$(pwd)` do?
10. What is a shell script?
11. What is a shebang?
12. Why does Day 046 run scripts with `bash script.sh`?
13. What does `$0` usually contain?
14. What does `$1` mean?
15. What does `$2` mean?
16. What does `$#` mean?
17. What does `$@` represent?
18. What does `$?` contain?
19. What does `-f` test?
20. What does `-d` test?
21. What does `-s` test?
22. What does `-z` test?
23. Why validate arguments before processing?
24. Why should errors go to stderr?
25. What does exit code `0` commonly mean?
26. What does a non-zero exit code commonly mean?
27. Why can loops be risky?
28. What is a dry run?
29. What does idempotency mean at a beginner level?
30. Why should automation be tested manually before scheduling?

## Section B - Predict the Output

1. `file_name="orders_sample.csv"; echo "$file_name"`
2. `file_name="orders_sample.csv"; echo '$file_name'`
3. `data_dir="sample-data"; file_name="orders_sample.csv"; echo "$data_dir/$file_name"`
4. `line_count=$(wc -l < sample-data/orders_sample.csv); echo "$line_count"`
5. `error_count=$(grep "ERROR" sample-data/pipeline_log.txt | wc -l); echo "$error_count"`
6. `input_file=""; if [ -z "$input_file" ]; then echo "missing"; fi`
7. `if [ -f sample-data/orders_sample.csv ]; then echo "found"; fi`
8. `if [ -d sample-data ]; then echo "folder found"; fi`
9. `bash scripts/02-count-lines.sh`
10. `bash scripts/02-count-lines.sh sample-data/orders_sample.csv`
11. `bash scripts/03-filter-log.sh sample-data/pipeline_log.txt WARN`
12. `bash scripts/04-validate-input-file.sh sample-data/does-not-exist.csv`
13. `for file in sample-data/customers_sample.csv sample-data/orders_sample.csv; do echo "$file"; done`
14. `echo "$?"` immediately after a script exits with validation failure

## Section C - Fix the Variable

1. `file_name = "orders_sample.csv"`
2. `echo "file_name"`
3. `echo '$file_name'` when the value is expected
4. `wc -l $input_file`
5. `input_file=$1`
6. `for file in $@`
7. `line_count=wc -l sample-data/orders_sample.csv`
8. `echo Input file: $input_file`
9. `if [ -f $input_file ]; then`
10. `if [ -z $input_file ]; then`
11. `search_term="ERROR"; grep search_term sample-data/pipeline_log.txt`
12. `data_dir="C:/Users/example/private-folder"`
13. `echo "File not found"`
14. `$?` checked after several unrelated commands

## Section D - Complete the Script

1. Assign `data_dir` to `sample-data`.
2. Assign `orders_file` to `"$data_dir/orders_sample.csv"`.
3. Print the order file path.
4. Store the line count of `orders_file`.
5. Print the line count.
6. Validate that at least one argument was supplied.
7. Store the first argument in `input_file`.
8. Check that `input_file` is a file.
9. Print usage to stderr.
10. Exit with `1` after failed validation.
11. Filter `ERROR` lines from a supplied log file.
12. Store match count using command substitution.
13. Loop over all supplied arguments.
14. Print a final reviewed/missing summary.

## Section E - Safe or Unsafe?

1. A script counts lines in a sample CSV.
2. A script validates an argument before reading it.
3. A script quotes every path variable.
4. A script loops over supplied files and prints line counts.
5. A script changes important source files by default.
6. A script runs from a private absolute path.
7. A script prints errors to stderr.
8. A script exits non-zero when a required file is missing.
9. A beginner script is scheduled before manual testing.
10. A script uses a dry-run message to explain a future change.
11. A script assumes `$1` exists without checking `$#`.
12. A script stores a count with `$(...)` after testing the command.

## Section F - Build a Mini Script

1. Build a script that prints a stored orders file path.
2. Build a script that accepts one file and counts lines.
3. Build a script that accepts a log file and search term.
4. Build a script that validates a directory argument.
5. Build a script that loops over supplied file arguments.
6. Build a script that prints usage when no argument is supplied.
7. Build a script that prints errors to stderr.
8. Build a script that exits `0` on success and `1` on validation failure.

## Section G - Mini Case Study

Design a safe script that:

1. accepts a directory
2. validates it
3. reviews known sample files
4. counts lines
5. counts WARN and ERROR lines
6. prints a summary
7. returns success or failure
8. modifies no source data

## Answer Key

### Section A

1. A named value stored in the shell.
2. `name="orders"`.
3. Spaces make Bash read the line differently.
4. Replacing a variable reference with its value.
5. To protect paths with spaces and avoid unwanted splitting.
6. They allow expansion and keep text together.
7. They keep text literal.
8. Running a command and capturing stdout.
9. Captures or prints the current directory depending on use.
10. A file of reusable shell commands.
11. The first line naming the intended shell.
12. To avoid permission-management practice.
13. The script name.
14. The first argument.
15. The second argument.
16. Argument count.
17. All positional arguments.
18. The previous command's exit status.
19. A regular file.
20. A directory.
21. A non-empty file.
22. An empty string.
23. To stop early with clear errors.
24. To keep errors separate from normal output.
25. Success.
26. Failure or non-success.
27. They repeat mistakes quickly.
28. A preview without changing data.
29. Running safely more than once without unexpected side effects.
30. Automation repeats behaviour, so it must be trusted first.

### Section B

1. Prints `orders_sample.csv`.
2. Prints `$file_name` literally.
3. Prints `sample-data/orders_sample.csv`.
4. Prints the line count for the orders file.
5. Prints the number of `ERROR` lines.
6. Prints `missing`.
7. Prints `found`.
8. Prints `folder found`.
9. Prints a usage message to stderr and exits non-zero.
10. Prints the input file and line count.
11. Prints matching WARN lines and a match count.
12. Prints a file-not-found error and exits non-zero.
13. Prints each listed file path.
14. Usually prints a non-zero value if checked immediately.

### Section C

1. `file_name="orders_sample.csv"`.
2. `echo "$file_name"`.
3. `echo "$file_name"`.
4. `wc -l "$input_file"`.
5. `input_file="$1"`.
6. `for file in "$@"`.
7. `line_count=$(wc -l < sample-data/orders_sample.csv)`.
8. `echo "Input file: $input_file"`.
9. `if [ -f "$input_file" ]; then`.
10. `if [ -z "$input_file" ]; then`.
11. `grep "$search_term" sample-data/pipeline_log.txt`.
12. Use a relative path such as `data_dir="sample-data"`.
13. `echo "File not found" >&2`.
14. Check `$?` immediately after the command you care about.

### Section D Sample Answers

```bash
data_dir="sample-data"
orders_file="$data_dir/orders_sample.csv"
echo "$orders_file"
line_count=$(wc -l < "$orders_file")
echo "Line count: $line_count"
```

```bash
if [ "$#" -lt 1 ]; then
    echo "Usage: bash script.sh <input-file>" >&2
    exit 1
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
    echo "File not found: $input_file" >&2
    exit 1
fi
```

```bash
grep "ERROR" "$log_file"
match_count=$(grep "ERROR" "$log_file" | wc -l)
```

```bash
reviewed_count=0
missing_count=0

for file in "$@"
do
    if [ -f "$file" ]; then
        reviewed_count=$((reviewed_count + 1))
    else
        missing_count=$((missing_count + 1))
    fi
done

echo "Reviewed: $reviewed_count"
echo "Missing: $missing_count"
```

### Section E

1. Safe.
2. Safe.
3. Safe.
4. Safe.
5. Unsafe.
6. Unsafe for public learning material.
7. Safe.
8. Safe.
9. Unsafe.
10. Safe.
11. Unsafe.
12. Safe.

### Section F

Use the scripts in `scripts/` as model answers: `01-show-variable.sh`, `02-count-lines.sh`, `03-filter-log.sh`, `04-validate-input-file.sh`, `05-review-multiple-files.sh`, and `06-safe-summary.sh`.

### Section G

`scripts/06-safe-summary.sh` is a complete safe example. It accepts a directory, validates it, reviews known files, counts lines, counts WARN and ERROR lines, prints a summary, exits appropriately, and modifies no source data.
