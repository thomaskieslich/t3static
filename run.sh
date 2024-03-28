#!/bin/bash

#set -x
#set +e

TEST_PATH='tests/t3static'
PACKAGE_PATH='packages/'
PACKAGE_DEFAULT='sitepackage'
TEST_DEFAULT='all'

PHPSTAN_LEVEL=3
TYPO3SCAN_TARGET=12

# Override Defaults
if [ -f ${BASH_SOURCE%/*}/.env ]; then
    source "${BASH_SOURCE%/*}/.env"
fi

PACKAGE_PATH=${PACKAGE_PATH}
PACKAGE_NAME=${PACKAGE_DEFAULT}
TEST_TYPE=${TEST_DEFAULT}

PHPSTAN_LEVEL=${PHPSTAN_LEVEL}
TYPO3SCAN_TARGET=${TYPO3SCAN_TARGET}

# Include Test Scripts
source "${BASH_SOURCE%/*}/includes/tests-frontend.sh"
source "${BASH_SOURCE%/*}/includes/tests-backend.sh"

# Get Options
while getopts "p:t:" option; do
    case $option in
    p)
        PACKAGE_NAME=$OPTARG
        ;;
    t)
        TEST_TYPE=$OPTARG
        ;;
    *) ;;
    esac
done

## Init Local
run:init() {
    cd tests/t3static || exit
    rm -f composer.lock
    rm -f package-lock.json
    composer install --no-progress
    npm install
    cd ../..
}

test:init() {
    if [ -z "$(ls -A "${TEST_PATH}"/node_modules)" ] || [ -z "$(ls -A "${TEST_PATH}"/vendor)" ]; then
        echo "Please run 'tests/t3static/run.sh -t init' in root Directory"
        exit 1
    else
        echo "Init composer and npm ok."
    fi
}

# Get Test
case "${TEST_TYPE}" in
init)
    run:init
    ;;
scss)
    lint:scss
    ;;
scss-fix)
    lint:scss:fix
    ;;
js)
    lint:js
    ;;
js-fix)
    lint:js:fix
    ;;
frontend)
    test:init
    lint:scss
    lint:js
    ;;
composer)
    lint:composer
    ;;
json)
    lint:json
    ;;
yaml)
    lint:yaml
    ;;
typoscript)
    lint:typoscript
    ;;
tsconfig)
    lint:tsconfig
    ;;
php-cs)
    php:cs
    ;;
php-cs-fix)
    php:cs:fix
    ;;
php-stan)
    php:stan
    ;;
backend)
    test:init
    lint:composer
    lint:json
    lint:yaml
    lint:typoscript
    lint:tsconfig
    php:cs
    php:stan
    ;;
*)
    echo "use parameters (all | json | yaml | typoscript | scss | js | …)"
    ;;
esac
