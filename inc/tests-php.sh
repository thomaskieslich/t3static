#!/bin/bash

### PHP ###
php:cs() {
  echo -e "\n ########## \n # php:cs # \n ########## \n"
  ${TEST_PATH}/vendor/bin/php-cs-fixer \
    --diff \
    --dry-run \
    --config=${CONFIGURATION_PATH}/.php-cs-fixer.php \
    fix ${PACKAGE_PATH}/${PACKAGE_NAME} || EXIT_CODE=$?
  echo "php:cs completed"
  return $EXIT_CODE
}

php:cs:fix() {
  echo -e "\n ############## \n # php:cs:fix # \n ############## \n"
  ${TEST_PATH}/vendor/bin/php-cs-fixer \
    --diff \
    --config=${TEST_PATH}/${CONFIGURATION_PATH}/.php-cs-fixer.php \
    fix ${PACKAGE_PATH}/${PACKAGE_NAME} || EXIT_CODE=$?
  echo "php:cs completed"
  return $EXIT_CODE
}

php:stan() {
  echo -e "\n ############ \n # php:stan # \n ############ \n"
  "${TEST_PATH}/vendor/bin/phpstan" analyse --level ${PHPSTAN_LEVEL} \
    --configuration "${TEST_PATH}/configuration/phpstan.neon" \
    --autoload-file "vendor/autoload.php" \
    --allow-empty-baseline \
    --generate-baseline "${TEST_PATH}/results/phpstan-${PACKAGE_NAME}-errors.neon" \
    "${PACKAGE_PATH}${PACKAGE_NAME}/" || EXIT_CODE=$?

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

### TYPO3 Scanner
typo3scan() {
  echo -e "\n ############# \n # TYPO3Scan # \n ############# \n"
  "${TEST_PATH}/vendor/bin/typo3scan" scan --target ${TYPO3SCAN_TARGET} ${PACKAGE_PATH}${PACKAGE_NAME} || EXIT_CODE=$?
  echo "TYPO3Scan completed"
  return $EXIT_CODE
}
