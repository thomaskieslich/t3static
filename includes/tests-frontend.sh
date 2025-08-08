#!/bin/bash

## Tests for Frontend

lint:css() {
  echoTestHeader "Css Linting"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    "${FULL_PACKAGE_PATH}/**/*.css" || EXIT_CODE=$?
  echoTestFooter "Css is Linted."
}

lint:css:fix() {
  echoTestHeader "Css Linting"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.css" || EXIT_CODE=$?
  echoTestFooter "Css is Linted."
}

lint:scss() {
  echoTestHeader "Scss Linting"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    "${FULL_PACKAGE_PATH}/**/*.scss" || EXIT_CODE=$?
  echoTestFooter "Scss is Linted."
}

lint:scss:fix() {
  echoTestHeader "Scss Linting Fix"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.scss"
  echoTestFooter "Scss is Linted and Fixed"
}

lint:js() {
  echoTestHeader "JavaScript Linting"
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    "${FULL_PACKAGE_PATH}/**/*.js" || EXIT_CODE=$?
  echoTestFooter "JavaScript is Linted."
}

lint:js:fix() {
  echoTestHeader "JavaScript Linting Fix"
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.js"
  echoTestFooter "JavaScript is Linted and Fixed."
}
