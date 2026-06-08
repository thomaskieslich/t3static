#!/bin/bash

# Get the parent directory (t3static) from the includes directory
SCRIPT_DIR="$(cd "${BASH_SOURCE%/*}/.." && pwd)"

source "${BASH_SOURCE%/*}/run-common.sh"
loadEnv "${SCRIPT_DIR}"

if [ -n "${TEST_PATH_DOCKER}" ]; then
  TEST_PATH="${TEST_PATH_DOCKER}"
fi

CONFIGURATION_PATH="${TEST_PATH}/${CONFIGURATION_PATH}"

# include Util scripts
for _src in util-echo util-choose-options util-exit-code util-test-types; do
    source "${BASH_SOURCE%/*}/${_src}.sh" || { echo "ERROR: Failed to source ${_src}.sh" >&2; exit 1; }
done

# include Test Scripts
for _src in tests-frontend tests-php tests-misc tests-typo3; do
    source "${BASH_SOURCE%/*}/${_src}.sh" || { echo "ERROR: Failed to source ${_src}.sh" >&2; exit 1; }
done

# Handle common typo: --list-test instead of --list-tests
if [[ "${1:-}" == "--list-test" ]]; then
    echo "ERROR: Did you mean '--list-tests' (with trailing 's')?" >&2
    exit 1
fi

# list tests as list
if [[ "$1" == "--list-tests" ]]; then
    list_tests
    exit 0
fi

# set default values if not filled already
if [ -z "${PACKAGE_NAME}" ]; then
  PACKAGE_NAME="${PACKAGE_DEFAULT}"
fi
if [ -z "${TEST_TYPE}" ]; then
  TEST_TYPE="${TEST_DEFAULT}"
fi

# Get CLI Options
while getopts ":p:t:" option; do
    case $option in
        p)
            if [ -z "$OPTARG" ]; then
                echo "ERROR: -p requires a package name" >&2; exit 1
            fi
            PACKAGE_NAME="$OPTARG"
            ;;
        t)
            if [ -z "$OPTARG" ]; then
                echo "ERROR: -t requires a test type" >&2; exit 1
            fi
            TEST_TYPE="$OPTARG"
            ;;
        :)
            echo "ERROR: Option -$OPTARG requires an argument" >&2; exit 1
            ;;
        \?)
            echo "ERROR: Unknown option -$OPTARG" >&2; exit 1
            ;;
    esac
done

# choose selection package and test
choose_package_if_empty
choose_test_if_empty

# Full path to Package
FULL_PACKAGE_PATH="$(pwd)/${PACKAGE_PATH}/${PACKAGE_NAME}"

# Remove unnecessary slashes and export
FULL_PACKAGE_PATH="${FULL_PACKAGE_PATH//\/\///}"

#  to use in php with getenv('FULL_PACKAGE_PATH')
export FULL_PACKAGE_PATH

echoInfo "Test: ${TEST_TYPE}"
echoInfo "Package: ${PACKAGE_NAME}"

validate_test() {
    local test_name="$1"

    if [[ ! "$test_name" =~ ^[a-zA-Z0-9_.-]+$ ]]; then
        echo "Error: Invalid test name '$test_name'" >&2
        return 1
    fi

    local is_available=false
    for available_test in "${AVAILABLE_TESTS[@]}"; do
        if [[ "$test_name" == "$available_test" ]]; then
            is_available=true
            break
        fi
    done

    if [[ "$is_available" == false ]]; then
        echo "Error: Test '$test_name' is not in available tests list" >&2
        return 1
    fi

    return 0
}

# Prepare and run Tests
IFS=',' read -ra TESTS <<<"$TEST_TYPE"
if [[ ${#TESTS[@]} -gt 0 ]]; then
    AVAILABLE_TESTS=()
    while IFS= read -r line; do
        AVAILABLE_TESTS+=("$line")
    done < <(list_tests)

    for test_item in "${TESTS[@]}"; do
        current_test="${test_item// /}"

        if validate_test "$current_test"; then
            echo "Processing: $current_test"
            "$current_test"
        else
            echo "Error: Cannot execute invalid test '$current_test'" >&2
            exit 1
        fi
    done
fi
