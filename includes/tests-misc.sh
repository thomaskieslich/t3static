#!/bin/bash

### Misc Tests ###
composer-validate() {
    echoTestHeader "Composer Validation"
    EXIT_CODE=0
    command composer \
        --working-dir="${FULL_PACKAGE_PATH}" \
        validate \
        --strict || EXIT_CODE=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Validated."
    return "${EXIT_CODE}"
}

composer-normalize() {
    echoTestHeader "Composer Normalize"
    EXIT_CODE=0
    command composer --working-dir="${TEST_PATH}" normalize \
        --dry-run \
        --indent-style tab \
        --indent-size 1 \
        --no-interaction \
        "${FULL_PACKAGE_PATH}/composer.json" ||
        EXIT_CODE=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Normalized. (DRY)"
    return "${EXIT_CODE}"
}

composer-normalize-fix() {
    echoTestHeader "Composer Normalize"
    EXIT_CODE=0
    command composer --working-dir="${TEST_PATH}" normalize \
        --indent-style tab \
        --indent-size 1 \
        --no-interaction \
        "${FULL_PACKAGE_PATH}/composer.json" ||
        EXIT_CODE=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Normalized. (DRY)"
    return "${EXIT_CODE}"
}

json() {
    echoTestHeader "Json Linting"
    EXIT_CODE=0
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.json" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint" || EXIT_CODE=$?
    echoTestFooter "Json is Linted."
    return "${EXIT_CODE}"
}

md() {
    echoTestHeader "Markdown Linting"
    EXIT_CODE=0
    npx --prefix "${TEST_PATH}" markdownlint-cli2 "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml" || EXIT_CODE=$?
    echoTestFooter "Markdown is Linted Exit."
    return "${EXIT_CODE}"
}

md-fix() {
    echoTestHeader "Markdown Linting with Fix"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 --fix "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    echoTestFooter "Markdown is Linted Exit."
}

yaml() {
    echoTestHeader "Yaml Linting"
    EXIT_CODE=0
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.y*ml" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi || EXIT_CODE=$?
    echoTestFooter "Yaml is Linted"
    return "${EXIT_CODE}"
}
