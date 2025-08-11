#!/bin/bash

source "${BASH_SOURCE%/*}/includes/util-config.sh"

### TYPO3 related Tests ###

lint:typoscript() {
    echoTestHeader "TypoScript Linting"
    "${TEST_PATH}/vendor/bin/typoscript-lint" \
        --config $(configPath 'typoscript-lint.yaml') \
        "${FULL_PACKAGE_PATH}" || EXIT_CODE=$?
    echoTestFooter "TypoScript is Linted"
    return $EXIT_CODE
}

lint:tsconfig() {
    echoTestHeader "TsConfig Linting"
    "${TEST_PATH}/vendor/bin/typoscript-lint" \
        --config $(configPath 'tsconfig-lint.yaml') \
        "${FULL_PACKAGE_PATH}" || EXIT_CODE=$?
    echoTestFooter "TsConfig is Linted"
    return $EXIT_CODE
}

fractor() {
    echoTestHeader "Fractor"
    "${TEST_PATH}/vendor/bin/fractor" process \
        --config $(configPath 'fractor.php') \
        --clear-cache \
        --dry-run || EXIT_CODE=$?
    echoTestFooter "Fractor completed"
    return $EXIT_CODE
}

fractor:fix() {
    echoTestHeader "Fractor"
    "${TEST_PATH}/vendor/bin/fractor" process \
        --config $(configPath 'fractor.php') \
        --clear-cache || EXIT_CODE=$?
    echoTestFooter "Fractor completed"
    return $EXIT_CODE
}

rector() {

    echoTestHeader "Rector"
    "${TEST_PATH}/vendor/bin/rector" process "${FULL_PACKAGE_PATH}" \
        --config $(configPath 'rector.php') \
        --clear-cache \
        --dry-run || EXIT_CODE=$?
    echoTestFooter "Rector completed"
    return $EXIT_CODE
}

rector:fix() {
    echoTestHeader "Rector"
    "${TEST_PATH}/vendor/bin/rector" process "${FULL_PACKAGE_PATH}" \
        --clear-cache \
        --config $(configPath 'rector.php') || EXIT_CODE=$?
    echoTestFooter "Rector completed"
    return $EXIT_CODE
}

typo3scan() {
    echoTestHeader "TYPO3Scan"
    "${TEST_PATH}/vendor/bin/typo3scan" scan --target ${TYPO3SCAN_TARGET} "${FULL_PACKAGE_PATH}" || EXIT_CODE=$?
    echoTestFooter "TYPO3Scan completed"
    return $EXIT_CODE
}
