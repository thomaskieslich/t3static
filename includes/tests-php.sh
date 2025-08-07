#!/bin/bash

### PHP Tests ###
php:cs() {
    echoTestHeader "php:cs"
    "${TEST_PATH}/vendor/bin/php-cs-fixer" \
        --diff \
        --dry-run \
        --using-cache=no \
        --config="${CONFIGURATION_PATH}/php-cs-fixer/coding-standards.php" \
        fix "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echoTestFooter "php:cs completed"
    return $EXIT_CODE
}

php:cs:fix() {
    echoTestHeader "php:cs:fix"
    "${TEST_PATH}/vendor/bin/php-cs-fixer" \
        --diff \
        --using-cache=no \
        --config="${CONFIGURATION_PATH}/php-cs-fixer/coding-standards.php" \
        fix "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?
    echoTestFooter "php:cs:fix completed"
    return $EXIT_CODE
}

php:stan() {
    echoTestHeader "php:stan"
    "${TEST_PATH}/vendor/bin/phpstan" analyse --level "${PHPSTAN_LEVEL}" \
        --configuration "${CONFIGURATION_PATH}/php-stan/phpstan.neon" \
        --autoload-file "vendor/autoload.php" \
        "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?

    echoTestFooter "php:stan completed"
    return $EXIT_CODE
}

php:stan:baseline() {
    echoTestHeader "php:stan"
    "${TEST_PATH}/vendor/bin/phpstan" analyse --level "${PHPSTAN_LEVEL}" \
        --configuration "${CONFIGURATION_PATH}/php-stan/phpstan.neon" \
        --autoload-file "vendor/autoload.php" \
        --allow-empty-baseline \
        --generate-baseline "${TEST_PATH}/results/phpstan-${PACKAGE_NAME}-errors.neon" \
        "${PACKAGE_PATH}/${PACKAGE_NAME}" || EXIT_CODE=$?

    echoTestFooter "php:stan completed"
    return $EXIT_CODE
}
