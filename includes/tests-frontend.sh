#!/bin/bash

## Tests for Frontend

lint:css() {
  echo -e "\n ################ \n # Css Linting # \n ################ \n"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${PACKAGE_PATH}/${PACKAGE_NAME}/.stylelintignore" \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.css" || EXIT_CODE=$?
  echo "Css is Linted."
}

lint:css:fix() {
  echo -e "\n ################ \n # Css Linting # \n ################ \n"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.csslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.csslintignore" \
    --fix \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.css" || EXIT_CODE=$?
  echo "Css is Linted."
}

lint:scss() {
  echo -e "\n ################ \n # Scss Linting # \n ################ \n"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.scsslintignore" \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.scss" || EXIT_CODE=$?
  echo "Scss is Linted."
}

lint:scss:fix() {
  echo -e "\n #################### \n # Scss Linting Fix # \n #################### \n"
  npx --prefix "${TEST_PATH}" stylelint \
    --config "${CONFIGURATION_PATH}/.scsslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.scsslintignore" \
    --fix \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.scss"
  echo "Scss is Linted and Fixed"
}

lint:js() {
  echo -e "\n ###################### \n # JavaScript Linting # \n ###################### \n"
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.js" || EXIT_CODE=$?
  echo "JavaScript is Linted."
}

lint:js:fix() {
  echo -e "\n ###################### \n # JavaScript Linting Fix # \n ###################### \n"
  npx --prefix "${TEST_PATH}" eslint \
    --config "${CONFIGURATION_PATH}/.eslintrc.json" \
    --ignore-path "${CONFIGURATION_PATH}/.eslintignore" \
    --fix \
    "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.js"
  echo "JavaScript is Linted and Fixed."
}
