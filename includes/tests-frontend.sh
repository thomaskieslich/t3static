#!/bin/bash

## Tests for Frontend

css() {
  echoTestHeader "Css Linting"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    "${FULL_PACKAGE_PATH}/**/*.css" || EXIT_CODE=$?
  echoTestFooter "Css is Linted."
  return "${EXIT_CODE}"
}

css-fix() {
  echoTestHeader "Css Linting"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.css" || EXIT_CODE=$?
  echoTestFooter "Css is Linted."
  return "${EXIT_CODE}"
}

scss() {
  echoTestHeader "Scss Linting"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    "${FULL_PACKAGE_PATH}/**/*.scss" || EXIT_CODE=$?
  echoTestFooter "Scss is Linted."
  return "${EXIT_CODE}"
}

scss-fix() {
  echoTestHeader "Scss Linting Fix"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${FULL_PACKAGE_PATH}/.stylelintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.scss" || EXIT_CODE=$?
  echoTestFooter "Scss is Linted and Fixed"
  return "${EXIT_CODE}"
}

js() {
  echoTestHeader "JavaScript Linting"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    "${FULL_PACKAGE_PATH}/**/*.js" || EXIT_CODE=$?
  echoTestFooter "JavaScript is Linted."
  return "${EXIT_CODE}"
}

js-fix() {
  echoTestHeader "JavaScript Linting Fix"
  local EXIT_CODE=0
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    --fix \
    "${FULL_PACKAGE_PATH}/**/*.js" || EXIT_CODE=$?
  echoTestFooter "JavaScript is Linted and Fixed."
  return "${EXIT_CODE}"
}
