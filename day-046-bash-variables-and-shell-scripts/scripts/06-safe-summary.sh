#!/usr/bin/env bash

# Purpose: summarize known Day 046 sample files without modifying source data.

if [ "$#" -lt 1 ]; then
    echo "Usage: bash scripts/06-safe-summary.sh <sample-data-directory>" >&2
    exit 1
fi

data_dir="$1"

if [ ! -d "$data_dir" ]; then
    echo "Directory not found: $data_dir" >&2
    exit 1
fi

customers_file="$data_dir/customers_sample.csv"
orders_file="$data_dir/orders_sample.csv"
log_file="$data_dir/pipeline_log.txt"
status_file="$data_dir/status_values.txt"

printf 'Current directory: %s\n' "$(pwd)"
printf 'Sample directory: %s\n' "$data_dir"

for input_file in "$customers_file" "$orders_file" "$log_file" "$status_file"
do
    if [ -f "$input_file" ]; then
        line_count=$(wc -l < "$input_file")
        printf 'Line count for %s: %s\n' "$input_file" "$line_count"
    else
        echo "Expected sample file missing: $input_file" >&2
        exit 1
    fi
done

error_count=$(grep "ERROR" "$log_file" | wc -l)
warn_count=$(grep "WARN" "$log_file" | wc -l)

printf 'ERROR lines: %s\n' "$error_count"
printf 'WARN lines: %s\n' "$warn_count"
printf 'Summary completed without changing source files.\n'

exit 0
