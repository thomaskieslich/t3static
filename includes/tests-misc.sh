#!/bin/bash

### Misc Tests ###

composer-validate() {
    echoTestHeader "Composer Validation"
    run_with_exit_code command composer \
        --working-dir="${FULL_PACKAGE_PATH}" \
        validate \
        --strict
    local result=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Validated."
    return "${result}"
}

composer-normalize() {
    _composer_normalize --dry-run
}

composer-normalize-fix() {
    _composer_normalize
}

_composer_normalize() {
    local dry_run_flag="$1"
    echoTestHeader "Composer Normalize"
    run_with_exit_code command composer --working-dir="${TEST_PATH}" normalize \
        ${dry_run_flag:+"$dry_run_flag"} \
        --indent-style tab \
        --indent-size 1 \
        --no-interaction \
        "${FULL_PACKAGE_PATH}/composer.json"
    local result=$?
    echoTestFooter "${PACKAGE_NAME} Composer is Normalized.${dry_run_flag:+ (DRY)}"
    return "${result}"
}

json() {
    echoTestHeader "Json Linting"
    run_with_exit_code find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.json" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint"
    local result=$?
    echoTestFooter "Json is Linted."
    return "${result}"
}

md() {
    echoTestHeader "Markdown Linting"
    run_with_exit_code npx --prefix "${TEST_PATH}" markdownlint-cli2 "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    local result=$?
    echoTestFooter "Markdown is Linted Exit."
    return "${result}"
}

md-fix() {
    echoTestHeader "Markdown Linting with Fix"
    npx --prefix "${TEST_PATH}" markdownlint-cli2 --fix "${FULL_PACKAGE_PATH}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    echoTestFooter "Markdown is Linted Exit."
}

yaml() {
    echoTestHeader "Yaml Linting"
    run_with_exit_code find "${FULL_PACKAGE_PATH}" ! -path "*/node_modules/*" -name "*.y*ml" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi
    local result=$?
    echoTestFooter "Yaml is Linted"
    return "${result}"
}
