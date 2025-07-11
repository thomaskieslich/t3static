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
    install)
        install:packages
        ;;

    # tests-frontend
    css)
        lint:css
        ;;
    css-fix)
        lint:css:fix
        ;;
    scss)
        lint:scss
        ;;
    scss-fix)
        lint:scss:fix
        ;;
    js)
        lint:js
        ;;
    js-fix)
        lint:js:fix
        ;;

    # tests-php
    php-cs)
        php:cs
        ;;
    php-cs-fix)
        php:cs:fix
        ;;
    php-stan)
        php:stan
        ;;
    php-stan-baseline)
        php:stan:baseline
        ;;

    # tests-misc
    composer)
        lint:composer
        ;;
    json)
        lint:json
        ;;
    md)
        lint:md
        ;;
    md-fix)
        lint:md:fix
        ;;
    yaml)
        lint:yaml
        ;;

    # tests-typo3
    typoscript)
        lint:typoscript
        ;;
    tsconfig)
        lint:tsconfig
        ;;
    rector)
        rector
        ;;
    rector-fix)
        rector:fix
        ;;
    typo3scan)
        typo3scan
        ;;

    # grouped collections
    frontend)
        lint:css
        lint:scss
        lint:js
        ;;
    misc)
        lint:composer
        lint:json
        lint:md
        lint:yaml
        ;;
    php)
        php:cs
        php:stan
        ;;
    typo3)
        lint:typoscript
        lint:tsconfig
        rector
        typo3scan
        ;;
    backend)
        lint:composer
        lint:json
        lint:md
        lint:yaml
        php:cs
        php:stan
        lint:typoscript
        lint:tsconfig
        rector
        typo3scan
        ;;
    all)
        lint:css
        lint:scss
        lint:js
        lint:composer
        lint:json
        lint:md
        lint:yaml
        php:cs
        php:stan
        lint:typoscript
        lint:tsconfig
        rector
        typo3scan
        ;;
    *)
        echo "Unknown TEST_TYPE: '${TEST_TYPE}'"
        echo "Use one of the following:"
        list_tests
        ;;
    esac
}
