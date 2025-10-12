#!/bin/bash

### Misc Tests ###
lint:composer() {
    echoTestHeader "Composer Validation"
    composer validate --working-dir "${FULL_PACKAGE_PATH}" --with-dependencies --strict || EXIT_CODE=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Validated."
    return $EXIT_CODE
}

lint:json() {
    echoTestHeader "Json Linting"
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.json" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint" || EXIT_CODE=$?
    echoTestFooter "Json is Linted."
    return $EXIT_CODE
}

lint:md() {
    echoTestHeader "Markdown Linting"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml" || EXIT_CODE=$?
    echoTestFooter "Markdown is Linted Exit."
    return $EXIT_CODE
}

lint:md:fix() {
    echoTestHeader "Markdown Linting with Fix"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 --fix "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    echoTestFooter "Markdown is Linted Exit."
}

lint:yaml() {
    echoTestHeader "Yaml Linting"
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.y*ml" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi || EXIT_CODE=$?
    echoTestFooter "Yaml is Linted"
    return $EXIT_CODE
}
