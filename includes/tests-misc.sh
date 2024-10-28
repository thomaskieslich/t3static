#!/bin/bash

### Misc Tests ###
lint:composer() {
    echo -e "\n ####################### \n # Composer Validation # \n ####################### \n"
    composer validate --working-dir "${PACKAGE_PATH}/${PACKAGE_NAME}" --with-dependencies --strict || EXIT_CODE=$?
    echo "${PACKAGE_NAME} Composer is Validated."
    return $EXIT_CODE
}

lint:json() {
    echo -e "\n ################# \n # Json Linting # \n ################# \n"
    find "${PACKAGE_PATH}/${PACKAGE_NAME}" ! -path "*/node_modules/*" -name "*.json" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/jsonlint" || EXIT_CODE=$?
    echo "Json is Linted."
    return $EXIT_CODE
}

lint:md() {
    echo -e "\n ################ \n # Markdown Linting # \n ################ \n"
    npx markdownlint-cli2 "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml" || EXIT_CODE=$?
    echo "Markdown is Linted Exit."
    return $EXIT_CODE
}

lint:md:fix() {
    echo -e "\n ################ \n # Markdown Linting with Fix # \n ################ \n"
    npx markdownlint-cli2 --fix "${PACKAGE_PATH}/${PACKAGE_NAME}/**/*.md" \
        --config "${CONFIGURATION_PATH}/.markdownlint-cli2.yaml"
    echo "Markdown is Linted Exit."
}

lint:yaml() {
    echo -e "\n ################# \n # Yaml Linting # \n ################# \n"
    find "${PACKAGE_PATH}/${PACKAGE_NAME}" ! -path "*/node_modules/*" -name "*.y*ml" -print0 |
        xargs --null -r php "${TEST_PATH}/vendor/bin/yaml-lint" --ansi || EXIT_CODE=$?
    echo "Yaml is Linted"
    return $EXIT_CODE
}
