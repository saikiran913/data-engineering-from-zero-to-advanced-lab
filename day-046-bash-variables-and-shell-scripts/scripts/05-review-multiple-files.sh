#!/usr/bin/env bash

# Purpose: loop through supplied files, validate each one, and print line counts.

if [ "$#" -lt 1 ]; then
    echo "Usage: bash scripts/05-review-multiple-files.sh <file-1> [file-2 ...]" >&2
    exit 1
fi

reviewed_count=0
missing_count=0

for input_file in "$@"
do
    printf 'Reviewing: %s\n' "$input_file"

    if [ -f "$input_file" ]; then
        line_count=$(wc -l < "$input_file")
        printf 'Line count: %s\n' "$line_count"
        reviewed_count=$((reviewed_count + 1))
    else
        echo "Missing file: $input_file" >&2
        missing_count=$((missing_count + 1))
    fi
done

printf 'Reviewed: %s\n' "$reviewed_count"
printf 'Missing: %s\n' "$missing_count"

if [ "$missing_count" -gt 0 ]; then
    exit 1
fi

exit 0
