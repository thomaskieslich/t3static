#!/bin/bash

set -x
set +e

TEST_PATH=tests/t3static
CONFIGURATION_PATH=${TEST_PATH}/config
PACKAGE_PATH=packages
PACKAGE_DEFAULT=sitepackage
TEST_DEFAULT=frontend

PHPSTAN_LEVEL=3
TYPO3SCAN_TARGET=12

# Override Defaults
if [ -f ${BASH_SOURCE%/*}/.env ]; then
    source "${BASH_SOURCE%/*}/.env"
fi

CONFIGURATION_PATH=${CONFIGURATION_PATH}
PACKAGE_PATH=${PACKAGE_PATH}
PACKAGE_NAME=${PACKAGE_DEFAULT}
TEST_TYPE=${TEST_DEFAULT}

PHPSTAN_LEVEL=${PHPSTAN_LEVEL}
TYPO3SCAN_TARGET=${TYPO3SCAN_TARGET}

# Include Test Scripts
source "${BASH_SOURCE%/*}/inc/tests-frontend.sh"
source "${BASH_SOURCE%/*}/inc/tests-php.sh"
source "${BASH_SOURCE%/*}/inc/tests-misc.sh"
source "${BASH_SOURCE%/*}/inc/tests-typo3.sh"

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

## Init Packages
install:packages() {
    cd ${TEST_PATH} || exit
    composer install --no-progress --no-interaction
    npm install --quiet
    cd ../..
}

# Get Test
case "${TEST_TYPE}" in
install)
    install:packages
    ;;
css)
    lint:css
    ;;
css-fix)
    lint:css:fix
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
    lint:scss
    lint:js
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
php)
    php:cs
    php:stan
    ;;
composer)
    lint:composer
    ;;
json)
    lint:json
    ;;
md)
    lint:md
    ;;
md-fix)
    lint:md:fix
    ;;
yaml)
    lint:yaml
    ;;
misc)
    lint:composer
    lint:json
    lint:md
    lint:yaml
    ;;
typoscript)
    lint:typoscript
    ;;
tsconfig)
    lint:tsconfig
    ;;
typo3)
    lint:typoscript
    lint:tsconfig
    ;;
all)
    lint:scss
    lint:js
    php:cs
    php:stan
    ;;
*)
    echo "use parameters (all | json | yaml | typoscript | scss | js | …)"
    ;;
esac
