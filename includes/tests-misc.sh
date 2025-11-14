#!/bin/bash

### Misc Tests ###
 composer() {
     echoTestHeader "Composer Validation"
     command composer validate --working-dir "${FULL_PACKAGE_PATH}" --with-dependencies --strict || EXIT_CODE=$?
     echoTestFooter "Composer is Validated." "${EXIT_CODE}"
     return "${EXIT_CODE}"
 }

json() {
    echoTestHeader "Json Linting"
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.json" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint" || EXIT_CODE=$?
    echoTestFooter "Json is Linted." "${EXIT_CODE}"
    return "${EXIT_CODE}"
}

md() {
    echoTestHeader "Markdown Linting"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml" || EXIT_CODE=$?
    echoTestFooter "Markdown is Linted Exit." "${EXIT_CODE}"
    return "${EXIT_CODE}"
}

md-fix() {
    echoTestHeader "Markdown Linting with Fix"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 --fix "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    local EXIT_CODE=$?
    echoTestFooter "Markdown is Linted Exit." "${EXIT_CODE}"
    return "${EXIT_CODE}"
}

yaml() {
    echoTestHeader "Yaml Linting"
    find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.y*ml" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi || EXIT_CODE=$?
    echoTestFooter "Yaml is Linted" "${EXIT_CODE}"
    return "${EXIT_CODE}"
}
