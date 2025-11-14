#!/bin/bash

# Get the parent directory (t3static) from the includes directory
SCRIPT_DIR="${BASH_SOURCE%/*}/.."

# Check for .env file existence, if not make a copy from .env.dist
if [ ! -f "${SCRIPT_DIR}/.env" ]; then
    cp "${SCRIPT_DIR}/.env.dist" "${SCRIPT_DIR}/.env"
    echo 'custom .env not found. copy .env.dist to .env'
fi

# get Environment Settings
source "${SCRIPT_DIR}/.env"

# Check if TEST_PATH_DOCKER is set and override TEST_PATH if needed
if [ -n "$TEST_PATH_DOCKER" ]; then
    TEST_PATH="${TEST_PATH_DOCKER}"
fi

# set CONFIGURATION_PATH depend on TEST_PATH
CONFIGURATION_PATH="${TEST_PATH}/${CONFIGURATION_PATH}"

# include util scripts
source "${BASH_SOURCE%/*}/util-echo.sh"
source "${BASH_SOURCE%/*}/util-choose-options.sh"
source "${BASH_SOURCE%/*}/util-test-types.sh"

# include Test Scripts
source "${BASH_SOURCE%/*}/tests-frontend.sh"
source "${BASH_SOURCE%/*}/tests-php.sh"
source "${BASH_SOURCE%/*}/tests-misc.sh"
source "${BASH_SOURCE%/*}/tests-typo3.sh"

# list tests as list
if [[ "$1" == "--list-tests" ]]; then
    list_tests
    exit 0
fi

# set default values if not filled already
if [ -z "${PACKAGE_NAME}" ]; then
    PACKAGE_NAME=${PACKAGE_DEFAULT}
fi
if [ -z "${TEST_TYPE}" ]; then
    TEST_TYPE=${TEST_DEFAULT}
fi

# Get CLI Options
while getopts "p:t:" option; do
    case $option in p)
        PACKAGE_NAME=$OPTARG
        ;;
    t)
        TEST_TYPE=$OPTARG
        ;;
    *) ;;
    esac
done

# choose selection package and test
choose_package_if_empty
choose_test_if_empty

# Full path to Package
FULL_PACKAGE_PATH=$(pwd)/${PACKAGE_PATH}/${PACKAGE_NAME}

# Remove unnecessary slashes and export
# shellcheck disable=SC2001
FULL_PACKAGE_PATH=$(echo "$FULL_PACKAGE_PATH" | sed 's|//\{1,\}|/|g')

#  to use in php with getenv('FULL_PACKAGE_PATH')
export FULL_PACKAGE_PATH

echoInfo "Test: ${TEST_TYPE}"
echoInfo "Package: ${PACKAGE_NAME}"

# Prepare and run Tests
IFS=',' read -ra TESTS <<<"$TEST_TYPE"
if [[ ${#TESTS[@]} -gt 0 ]]; then
    # Get available tests as an array
    AVAILABLE_TESTS=()
    while IFS= read -r line; do
        AVAILABLE_TESTS+=("$line")
    done < <(list_tests)

    # Function to check if a test is available
    is_test_available() {
        local test_name="$1"
        for available_test in "${AVAILABLE_TESTS[@]}"; do
            if [[ "$test_name" == "$available_test" ]]; then
                return 0
            fi
        done
        return 1
    }

    for test_item in "${TESTS[@]}"; do
        # Remove whitespace
        current_test=$(echo "$test_item" | xargs)

        if is_test_available "$current_test"; then
            echo "Processing: $current_test"
            # Execute the test command (ensure it's safe)
            "$current_test"
        else
            echo "Error: Unknown test type '$current_test'" >&2
            exit 1
        fi
    done
fi
