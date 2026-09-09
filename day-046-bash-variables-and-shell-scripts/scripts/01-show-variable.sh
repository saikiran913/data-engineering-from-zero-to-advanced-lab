#!/usr/bin/env bash

# Purpose: demonstrate variable assignment, path construction, and quoted expansion.

data_dir="sample-data"
file_name="orders_sample.csv"
full_path="$data_dir/$file_name"

printf 'Data directory: %s\n' "$data_dir"
printf 'File name: %s\n' "$file_name"
printf 'Full path: %s\n' "$full_path"
printf 'Quoted path is ready for safe command use.\n'

exit 0
