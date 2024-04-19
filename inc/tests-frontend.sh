#!/bin/bash

## Tests for Frontend

lint:scss() {
  echo -e "\n ################ \n # Scss Linting # \n ################ \n"
  npx --prefix ${TEST_PATH} stylelint "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.scss" \
    -c ${TEST_PATH}/${CONFIGURATION_PATH}/.stylelintrc.json
  echo "Scss is Linted Exit: $EXIT_CODE"
}

lint:scss:fix() {
  echo -e "\n #################### \n # Scss Linting Fix # \n #################### \n"
  cd "${TEST_PATH}" || exit
  npx stylelint "../../${PACKAGE_PATH}${PACKAGE_NAME}/**/*.scss" --fix
  echo "Scss is Linted and Fixed"
  cd ../..
}

lint:js() {
  echo -e "\n ###################### \n # JavaScript Linting # \n ###################### \n"
  cd "${TEST_PATH}" || exit
  if [ -d "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/JavaScript" ]; then
    npx eslint \
      --config configuration/.eslintrc.json \
      --ignore-path configuration/.eslintignore \
      "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/JavaScript/**/*.js" || EXIT_CODE=$?
    echo "JavaScript is Linted Exit: $EXIT_CODE"
    cd ../..
    return $EXIT_CODE
  else
    echo "!!! ../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/JavaScript NOT Found "
    cd ../..
    return 2
  fi
}

lint:js:fix() {
  echo -e "\n ########################## \n # JavaScript Linting Fix # \n ########################## \n"
  cd "${TEST_PATH}" || exit
  npx eslint --config configuration/.eslintrc.json \
    --ignore-path configuration/.eslintignore \
    "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/JavaScript/**/*.js" --fix
  cd ../..
  echo "JavaScript is Linted and Fixed"
}
