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
rector)
  rector
  ;;
rector-fix)
  rector:fix
  ;;
typo3scan)
  typo3scan
  ;;
backend)
  lint:composer
  lint:json
  lint:yaml
  lint:md
  lint:typoscript
  lint:tsconfig
  php:cs
  php:stan
  rector
  typo3scan
  ;;
all)
  lint:scss
  lint:js
  lint:composer
  lint:json
  lint:yaml
  lint:md
  lint:typoscript
  lint:tsconfig
  php:cs
  php:stan
  rector
  typo3scan
  ;;
*)
  echo "use parameters (all | json | yaml | typoscript | scss | js | …)"
  ;;
esac
