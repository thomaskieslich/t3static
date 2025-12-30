#!/bin/bash

# Path to this file (for list_test_types to scan itself)
SCRIPT_PATH="${BASH_SOURCE[0]}"

# Return a list of all valid TEST_TYPE options by parsing this file
list_tests() {
    find "${SCRIPT_PATH%/*}" -maxdepth 1 -type f -name "tests-*" -print0 |
        xargs -0 grep -h -E '^[[:space:]]*[a-z0-9_-]+\(\)' |
        sed -E 's/^[[:space:]]*([a-z0-9_-]+)\(\).*/\1/' |
        sort -u
}
