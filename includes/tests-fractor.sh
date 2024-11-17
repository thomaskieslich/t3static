#!/bin/bash

## Tests with fractor

fractor() {
    echo -e "\n ########## \n # Fractor # \n ########## \n"
    cd ${TEST_PATH}
    "./vendor/bin/fractor" process \
        --config "config/fractor.php" \
        --dry-run || EXIT_CODE=$?
    echo "Fractor completed"
    cd ..
    return $EXIT_CODE
}
