#!/bin/bash

# Path to this file (for list_test_types to scan itself)
SCRIPT_PATH="${BASH_SOURCE[0]}"

# Return a list of all valid TEST_TYPE options by parsing this file
list_tests() {
    grep -hE '^[[:space:]]*[a-z0-9_-]+\(\)' "${SCRIPT_PATH%/*}"/tests-* |
        sed -E 's/^[[:space:]]*([a-z0-9_-]+)\(\).*/\1/' |
        grep -v '^_' |
        sort -u
}
