#!/bin/bash

### TYPO3 related Tests ###

lint:typoscript() {
    echo -e "\n ###################### \n # TypoScript Linting # \n ###################### \n"
        "${TEST_PATH}/vendor/bin/typoscript-lint" \
            --config "${CONFIGURATION_PATH}/typoscript-lint.yaml" \
            "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
        echo "TypoScript is Linted"
        return $EXIT_CODE
}

lint:tsconfig() {
    echo -e "\n ###################### \n # TsConfig Linting # \n ###################### \n"
        "${TEST_PATH}/vendor/bin/typoscript-lint" \
            --config "${CONFIGURATION_PATH}/tsconfig-lint.yaml" \
            "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
        echo "TsConfig is Linted"
        return $EXIT_CODE
}

rector-1() {
    echo -e "\n ########## \n # Rector v1 # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-1.php" \
        --dry-run || EXIT_CODE=$?
    echo "Rector completed"
    return $EXIT_CODE
}

rector-1:fix() {
    echo -e "\n ########## \n # Rector Fix # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-1.php" || EXIT_CODE=$?
    echo "Rector Fix completed"
    return $EXIT_CODE
}

rector-2() {
    echo -e "\n ########## \n # Rector v2 # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-2.php" \
        --dry-run -vv || EXIT_CODE=$?
    echo "Rector completed"
    return $EXIT_CODE
}

rector-2:fix() {
    echo -e "\n ########## \n # Rector Fix # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process "${PACKAGE_PATH}/${PACKAGE_NAME}" \
        --config "${CONFIGURATION_PATH}/rector-2.php" || EXIT_CODE=$?
    echo "Rector Fix completed"
    return $EXIT_CODE
}

typo3scan() {
    echo -e "\n ############# \n # TYPO3Scan # \n ############# \n"
    "${TEST_PATH}/vendor/bin/typo3scan" scan --target ${TYPO3SCAN_TARGET} "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echo "TYPO3Scan completed"
    return $EXIT_CODE
}
