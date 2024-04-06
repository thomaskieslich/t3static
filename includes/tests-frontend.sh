#!/bin/bash

## Tests based on npm Packages

lint:scss() {
    echo -e "\n ################ \n # Scss Linting # \n ################ \n"
    cd "${TEST_PATH}" || exit
    if [ -d "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/Scss" ]; then
        npx stylelint "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/Scss/**/*.scss" || EXIT_CODE=$?
        echo "Scss is Linted Exit: $EXIT_CODE"
        cd ../..
        return $EXIT_CODE
    else
        echo "!!! ../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/Scss NOT Found "
        cd ../..
        return 2
    fi
}

lint:scss:fix() {
    echo -e "\n #################### \n # Scss Linting Fix # \n #################### \n"
    cd "${TEST_PATH}" || exit
    npx stylelint "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/Scss/**/*.scss" --fix # -f verbose
    echo "Scss is Linted and Fixed"
    cd ../..
}

lint:js() {
    echo -e "\n ###################### \n # JavaScript Linting # \n ###################### \n"
    pwd
    cd "${TEST_PATH}" || exit
    if [ -d "../../${PACKAGE_PATH}${PACKAGE_NAME}/Resources/Public/JavaScript" ]; then
        npx eslint --config configuration/.eslintrc.json \
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

lint:md() {
    echo -e "\n ################ \n # Markdown Linting # \n ################ \n"
    npx markdownlint-cli2 "${PACKAGE_PATH}${PACKAGE_NAME}/**/*.md" \
        --config "${TEST_PATH}/configuration/.markdownlint-cli2.yaml" || EXIT_CODE=$?
    echo "Markdown is Linted Exit: $EXIT_CODE"
    return $EXIT_CODE
}

lint:md:fix() {
    echo -e "\n ################ \n # Markdown Linting # \n ################ \n"
    npx markdownlint-cli2 --fix "${PACKAGE_PATH}${PACKAGE_NAME}/**/*.md" "#node_modules"
}
