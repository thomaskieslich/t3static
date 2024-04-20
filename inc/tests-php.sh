#!/bin/bash

### PHP Tests ###
php:cs() {
    echo -e "\n ########## \n # php:cs # \n ########## \n"
    ${TEST_PATH}/vendor/bin/php-cs-fixer \
        --diff \
        --dry-run \
        --config=${CONFIGURATION_PATH}/php-cs-fixer/config.php \
        fix ${PACKAGE_PATH}/${PACKAGE_NAME} || EXIT_CODE=$?
    echo "php:cs completed"
    return $EXIT_CODE
}

php:cs:fix() {
    echo -e "\n ############## \n # php:cs:fix # \n ############## \n"
    ${TEST_PATH}/vendor/bin/php-cs-fixer \
        --diff \
        --config=${CONFIGURATION_PATH}/php-cs-fixer/config.php \
        fix ${PACKAGE_PATH}/${PACKAGE_NAME} || EXIT_CODE=$?
    echo "php:cs:fix completed"
    return $EXIT_CODE
}

php:stan() {
    echo -e "\n ############ \n # php:stan # \n ############ \n"
    ${TEST_PATH}/vendor/bin/phpstan analyse --level ${PHPSTAN_LEVEL} \
        --configuration ${CONFIGURATION_PATH}/php-stan/phpstan.neon \
        --autoload-file ${TEST_PATH}/vendor/autoload.php \
        --allow-empty-baseline \
        --generate-baseline "${TEST_PATH}/res/phpstan-${PACKAGE_NAME}-errors.neon" \
        ${PACKAGE_PATH}/${PACKAGE_NAME} || EXIT_CODE=$?

    echo "php:stan completed"
    return $EXIT_CODE
}
