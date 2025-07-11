#!/bin/bash

### TYPO3 related Tests ###

lint:typoscript() {
    echoTestHeader "TypoScript Linting"
    "${TEST_PATH}/vendor/bin/typoscript-lint" \
        --config "${CONFIGURATION_PATH}/typoscript-lint.yaml" \
        "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echoTestFooter "TypoScript is Linted"
    return $EXIT_CODE
}

lint:tsconfig() {
    echoTestHeader "TsConfig Linting"
    "${TEST_PATH}/vendor/bin/typoscript-lint" \
        --config "${CONFIGURATION_PATH}/tsconfig-lint.yaml" \
        "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echoTestFooter "TsConfig is Linted"
    return $EXIT_CODE
}

rector() {
    echoTestHeader "Rector"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector.php" \
        --dry-run || EXIT_CODE=$?
    echoTestFooter "Rector completed"
    return $EXIT_CODE
}

rector:fix() {
    echoTestHeader "Rector"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector.php" || EXIT_CODE=$?
    echoTestFooter "Rector completed"
    return $EXIT_CODE
}

rector1() {
    echoTestHeader "Rector"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-1.php" \
        --dry-run || EXIT_CODE=$?
    echoTestFooter "Rector completed"
    return $EXIT_CODE
}

rector1:fix() {
    echoTestHeader "Rector Fix"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-1.php" || EXIT_CODE=$?
    echoTestFooter "Rector Fix completed"
    return $EXIT_CODE
}

typo3scan() {
    echoTestHeader "TYPO3Scan"
    "${TEST_PATH}/vendor/bin/typo3scan" scan --target ${TYPO3SCAN_TARGET} "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echoTestFooter "TYPO3Scan completed"
    return $EXIT_CODE
}
