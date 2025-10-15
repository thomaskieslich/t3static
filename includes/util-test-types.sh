#!/bin/bash

# Path to this file (for list_test_types to scan itself)
SCRIPT_PATH="${BASH_SOURCE[0]}"

# Return a list of all valid TEST_TYPE options by parsing this file
list_tests() {
    grep -E '^[[:space:]]*[a-z0-9_-]+\)' "$SCRIPT_PATH" \
        | sed -E 's/^[[:space:]]*([a-z0-9_-]+)\).*/\1/' \
        | grep -v '^\*' \
        | sort -u
}

# Run the test defined in TEST_TYPE
run_test() {

    case "${TEST_TYPE}" in
    # tests-frontend
    css)
        css
        ;;
    css-fix)
        css-fix
        ;;
    scss)
        scss
        ;;
    scss-fix)
        scss-fix
        ;;
    js)
        js
        ;;
    js-fix)
        js-fix
        ;;

    # tests-php
    php-cs)
        php-cs
        ;;
    php-cs-fix)
        php-cs-fix
        ;;
    php-stan)
        php-stan
        ;;
    php-stan-baseline)
        php-stan-baseline
        ;;

    # tests-misc
    composer)
        composer
        ;;
    json)
        json
        ;;
    md)
        md
        ;;
    md-fix)
        md-fix
        ;;
    yaml)
        yaml
        ;;

    # tests-typo3
    typoscript)
        typoscript
        ;;
    tsconfig)
        tsconfig
        ;;
    fractor)
        fractor
        ;;
    fractor-fix)
            fractor-fix
            ;;
    rector)
        rector
        ;;
    rector-fix)
        rector-fix
        ;;
    typo3scan)
        typo3scan
        ;;

    *)
        echo "Unknown TEST_TYPE: '${TEST_TYPE}'"
        echo "Use one of the following:"
        list_tests
        ;;
    esac
}
