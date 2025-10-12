#!/bin/bash
# common.sh

loadEnv() {
    local SCRIPT_DIR="$1"

    # Check for .env file existence, if not make a copy from .env.dist
    if [ ! -f "${SCRIPT_DIR}/.env" ]; then
        if [ ! -f "${SCRIPT_DIR}/.env.dist" ]; then
            echo "ERROR: .env.dist not found"
            exit 1
        fi
        cp "${SCRIPT_DIR}/.env.dist" "${SCRIPT_DIR}/.env"
        echo "custom .env not found. copy .env.dist to .env"
    fi

    # Load environment and set up paths
    if ! source "${SCRIPT_DIR}/.env"; then
        echo "ERROR: Failed to load .env file"
        exit 1
    fi

    # Check if TEST_PATH is set and valid
    if [ -z "${TEST_PATH:-}" ]; then
        echo "ERROR: TEST_PATH is not set in .env"
        exit 1
    fi
    if [ ! -d "${TEST_PATH}" ]; then
        echo "ERROR: TEST_PATH directory does not exist: ${TEST_PATH}"
        exit 1
    fi
}
