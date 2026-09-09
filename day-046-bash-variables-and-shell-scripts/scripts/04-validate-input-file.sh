#!/usr/bin/env bash

# Purpose: demonstrate safe checks before reading an input file.

if [ "$#" -lt 1 ]; then
    echo "Usage: bash scripts/04-validate-input-file.sh <input-file>" >&2
    exit 1
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
    echo "File not found: $input_file" >&2
    exit 1
fi

if [ ! -s "$input_file" ]; then
    echo "File exists but is empty: $input_file" >&2
    exit 1
fi

printf 'Validation passed: %s\n' "$input_file"
printf 'The file exists and is not empty.\n'

exit 0
