#!/bin/bash

#set -x
#set +e

TEST_PATH='tests/t3static'
CONFIGURATION_PATH=".config"
PACKAGE_PATH='packages'
PACKAGE_DEFAULT='sitepackage'
TEST_DEFAULT='all'

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

## Init Local
run:init() {
  cd ${TEST_PATH} || exit
  composer install --no-progress --no-interaction
  npm install
  cd ../..
}

test:init() {
  if [ -z "$(ls -A "${TEST_PATH}"/node_modules)" ] || [ -z "$(ls -A "${TEST_PATH}"/vendor)" ]; then
    echo "Please run 'tests/t3static/t3static.sh -t init' in root Directory"
    exit 1
  else
    echo "Init composer and npm ok."
  fi
}

# Get Test
case "${TEST_TYPE}" in
init)
  test:init
  run:init
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
md)
  lint:md
  ;;
md-fix)
  lint:md:fix
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
  test:init
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
  test:init
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
