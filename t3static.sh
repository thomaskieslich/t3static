#!/bin/bash

# include util scripts
source "${BASH_SOURCE%/*}/includes/util-echo.sh"
source "${BASH_SOURCE%/*}/includes/util-choose-options.sh"
source "${BASH_SOURCE%/*}/includes/util-test-types.sh"

#set -x
#set +e

TEST_PATH=t3static
CONFIGURATION_PATH=${TEST_PATH}/config
PACKAGE_PATH=packages

PHPSTAN_LEVEL=4
TYPO3SCAN_TARGET=13

# Override Defaults from .env
if [ -f ${BASH_SOURCE%/*}/.env ]; then
    source "${BASH_SOURCE%/*}/.env"
fi

CONFIGURATION_PATH=${CONFIGURATION_PATH}
PACKAGE_PATH=${PACKAGE_PATH}

PHPSTAN_LEVEL=${PHPSTAN_LEVEL}
TYPO3SCAN_TARGET=${TYPO3SCAN_TARGET}

# Include Test Scripts
source "${BASH_SOURCE%/*}/includes/tests-frontend.sh"
source "${BASH_SOURCE%/*}/includes/tests-php.sh"
source "${BASH_SOURCE%/*}/includes/tests-misc.sh"
source "${BASH_SOURCE%/*}/includes/tests-typo3.sh"

# set default values if not filled already
if [ -z "${PACKAGE_NAME}" ]; then
  PACKAGE_NAME=${PACKAGE_DEFAULT}
fi
if [ -z "${TEST_TYPE}" ]; then
  TEST_TYPE=${TEST_DEFAULT}
fi

# Get CLI Options
while getopts "p:t:" option; do
    case $option in p)
        PACKAGE_NAME=$OPTARG
        ;;
    t)
        TEST_TYPE=$OPTARG
        ;;
    *) ;;
    esac
done

# only choose selection, if $TEST_TYPE is not install
if [[ "$TEST_TYPE" != "install" ]]; then
    choose_package_if_empty
    choose_test_if_empty
fi


echoInfo "Test: ${TEST_TYPE}"
echoInfo "Package: ${PACKAGE_NAME}"

## Init Packages
install:packages() {
    cd ${TEST_PATH} || exit
    rm -f composer.lock package-lock.json
    composer install --no-progress --no-interaction
    npm install --quiet
    cd ../..
}

# Get Test
run_test
