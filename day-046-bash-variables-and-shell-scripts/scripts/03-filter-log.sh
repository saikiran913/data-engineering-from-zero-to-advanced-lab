#!/usr/bin/env bash

# Purpose: filter a supplied log file by a supplied search term and count matches.

if [ "$#" -lt 2 ]; then
    echo "Usage: bash scripts/03-filter-log.sh <log-file> <search-term>" >&2
    exit 1
fi

log_file="$1"
search_term="$2"

if [ ! -f "$log_file" ]; then
    echo "Log file not found: $log_file" >&2
    exit 1
fi

printf 'Log file: %s\n' "$log_file"
printf 'Search term: %s\n' "$search_term"
printf 'Matching lines are case-sensitive:\n'

grep "$search_term" "$log_file"
match_count=$(grep "$search_term" "$log_file" | wc -l)

printf 'Match count: %s\n' "$match_count"

exit 0
