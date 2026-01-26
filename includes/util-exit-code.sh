#!/bin/bash

# Helper function to run command with exit code handling
run_with_exit_code() {
    local exit_code=0
    "$@" || exit_code=$?
    return "${exit_code}"
}
