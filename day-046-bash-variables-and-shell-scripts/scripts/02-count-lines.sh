#!/usr/bin/env bash

# Purpose: count lines in a supplied input file after safe validation.

if [ "$#" -lt 1 ]; then
    echo "Usage: bash scripts/02-count-lines.sh <input-file>" >&2
    exit 1
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
    echo "File not found: $input_file" >&2
    exit 1
fi

line_count=$(wc -l < "$input_file")

printf 'Input file: %s\n' "$input_file"
printf 'Line count: %s\n' "$line_count"

exit 0
