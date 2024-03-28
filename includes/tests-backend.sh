#!/bin/bash

## Linter
lint:composer:root() {
    echo -e "\n ############################ \n # Root Composer Validation # \n ############################ \n"
    composer validate --strict || EXIT_CODE=$?
    echo "Root Composer is Validated"
    return $EXIT_CODE
}

lint:composer:extension() {
    echo -e "\n ####################### \n # Composer Validation # \n ####################### \n"
    composer validate --working-dir "${PACKAGE_PATH}""${PACKAGE_NAME}" --with-dependencies --strict || EXIT_CODE=$?
    echo "${PACKAGE_NAME} Composer is Validated"
    return $EXIT_CODE
}

lint:json() {
    echo -e "\n ################# \n # Json Linting # \n ################# \n"
    find "${PACKAGE_PATH}${PACKAGE_NAME}" ! -path '*/node_modules/*' -name '*.json' -print0 | xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint" || EXIT_CODE=$?
    echo "Json is Linted"
    return $EXIT_CODE
}

lint:yaml() {
    echo -e "\n ################# \n # Yaml Linting # \n ################# \n"
    find "${PACKAGE_PATH}${PACKAGE_NAME}" ! -path '*/node_modules/*' -name '*.y*ml' -print0 | xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi || EXIT_CODE=$?
    echo "Yaml is Linted"
    return $EXIT_CODE
}

lint:typoscript() {
    echo -e "\n ###################### \n # TypoScript Linting # \n ###################### \n"
    if [ -d "${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TypoScript" ]; then
        "${TEST_PATH}"/vendor/bin/typoscript-lint \
            --config ${TEST_PATH}/configuration/TypoScriptLint.yaml \
            "${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TypoScript/*" || EXIT_CODE=$?
        echo "TypoScript is Linted"
        return $EXIT_CODE
    else
        echo "!!! ${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TypoScript NOT Found "
    fi
}

lint:tsconfig() {
    echo -e "\n #################### \n # TsConfig Linting # \n #################### \n"
    if [ -d "${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TsConfig" ]; then
        "${TEST_PATH}"/vendor/bin/typoscript-lint \
            --config ${TEST_PATH}/configuration/TypoScriptLint.yaml \
            "${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TsConfig/*" || EXIT_CODE=$?
        echo "TsConfig is Linted"
        #        return $EXIT_CODE
    else
        echo "!!! ${PACKAGE_PATH}${PACKAGE_NAME}/Configuration/TsConfig NOT Found "
    fi
}

### PHP ###
php:cs() {
    echo -e "\n ########## \n # php:cs # \n ########## \n"
    "${TEST_PATH}/vendor/bin/php-cs-fixer" fix "${PACKAGE_PATH}${PACKAGE_NAME}/" \
        --dry-run --using-cache no --diff --config="${TEST_PATH}"/configuration/.php-cs-fixer.php || EXIT_CODE=$?
    echo "php:cs completed"
    return $EXIT_CODE
}

php:cs:fix() {
    echo -e "\n ############## \n # php:cs:fix # \n ############## \n"
    "${TEST_PATH}/vendor/bin/php-cs-fixer" fix "${PACKAGE_PATH}${PACKAGE_NAME}/" \
    --using-cache no  --config="${TEST_PATH}"/configuration/.php-cs-fixer.php || EXIT_CODE=$?
    echo "php:cs:fix completed"
    return $EXIT_CODE
}

php:lint() {
    echo -e "\n ############ \n # php:lint # \n ############ \n"
    find "${PACKAGE_PATH}${PACKAGE_NAME}/" -name '*.php' -print0 | xargs -r -0 -n 1 -P 4 php --syntax-check || EXIT_CODE=$?
    echo "php:lint completed"
    return $EXIT_CODE
}

php:sniff() {
    echo -e "\n ############# \n # php:sniff # \n ############# \n"
    "${TEST_PATH}/vendor/bin/phpcs" --standard="${TEST_PATH}"/configuration/phpcs.xml "${PACKAGE_PATH}${PACKAGE_NAME}/" || EXIT_CODE=$?
    echo "php:sniff completed"
    return $EXIT_CODE
}

php:sniff:fix() {
    echo -e "\n ################# \n # php:sniff:fix # \n ################# \n"
    "${TEST_PATH}/vendor/bin/phpcbf" --standard="${TEST_PATH}/configuration/phpcs.xml" "${PACKAGE_PATH}${PACKAGE_NAME}/"
    echo "php:sniff:fix completed"
}

php:stan() {
    echo -e "\n ############ \n # php:stan # \n ############ \n"
    "${TEST_PATH}/vendor/bin/phpstan" analyse --level ${PHPSTAN_LEVEL} \
        --configuration "${TEST_PATH}/configuration/phpstan.neon" \
        --autoload-file "vendor/autoload.php" \
        --allow-empty-baseline \
        --generate-baseline "${TEST_PATH}/results/phpstan-${PACKAGE_NAME}-errors.neon" \
        "${PACKAGE_PATH}${PACKAGE_NAME}/" || EXIT_CODE=$?

#        --generate-baseline "${TEST_PATH}/configuration/phpstan-errors.neon" \
#        --generate-baseline "${PACKAGE_PATH}${PACKAGE_NAME}/phpstan-errors.neon" \

    echo "php:stan completed"
    return $EXIT_CODE
}

### Rector ###
rector() {
    echo -e "\n ########## \n # rector # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process ${PACKAGE_PATH}${PACKAGE_NAME} --config "${TEST_PATH}/configuration/rector.php" \
        --dry-run || EXIT_CODE=$?
    echo "rector completed"
    return $EXIT_CODE
}

rector:fix() {
    echo -e "\n ############## \n # rector:fix # \n ############## \n"
    "${TEST_PATH}/vendor/bin/rector" process ${PACKAGE_PATH}${PACKAGE_NAME} --config "${TEST_PATH}/configuration/rector.php" ||
        EXIT_CODE=$?
    echo "rector:fix completed"
    return $EXIT_CODE
}

### Rector Full with more Sets ###
rector:full() {
    echo -e "\n ########## \n # rector # \n ########## \n"
    "${TEST_PATH}/vendor/bin/rector" process ${PACKAGE_PATH}${PACKAGE_NAME} --config "${TEST_PATH}/configuration/rector-full.php" \
        --dry-run || EXIT_CODE=$?
    echo "rector completed"
    return $EXIT_CODE
}

rector:full:fix() {
    echo -e "\n ############## \n # rector:fix # \n ############## \n"
    "${TEST_PATH}/vendor/bin/rector" process ${PACKAGE_PATH}${PACKAGE_NAME} --config "${TEST_PATH}/configuration/rector-full.php" ||
        EXIT_CODE=$?
    echo "rector:fix completed"
    return $EXIT_CODE
}

### TYPO3 Scanner
### https://github.com/Tuurlijk/typo3scan
typo3scan() {
    echo -e "\n ############# \n # TYPO3Scan # \n ############# \n"
    "${TEST_PATH}/vendor/bin/typo3scan" scan --target ${TYPO3SCAN_TARGET} ${PACKAGE_PATH}${PACKAGE_NAME} || EXIT_CODE=$?
    echo "TYPO3Scan completed"
    return $EXIT_CODE
}
