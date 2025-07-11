# Prompt the user to choose a folder from PACKAGE_PATH if PACKAGE_NAME is empty
choose_package_if_empty() {
    # Check if PACKAGE_NAME is empty
    if [ -z "${PACKAGE_NAME}" ]; then
        echoInfo "PACKAGE_NAME is empty."
        echoInfo "Please choose a folder:"

        # Read all folder names in PACKAGE_PATH into an array
        IFS=$'\n' read -d '' -r -a folders < <(find "${PACKAGE_PATH}" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort && printf '\0')

        # Exit if no folders are found
        if [ ${#folders[@]} -eq 0 ]; then
            echoInfo "No folders found in ${PACKAGE_PATH}."
            exit 1
        fi

        # Print numbered folder list
        for i in "${!folders[@]}"; do
            printf "%3d) %s\n" $((i+1)) "${folders[$i]}"
        done

        # Prompt user to enter a valid number selection
        while true; do
            read -rp "Enter number (1-${#folders[@]}): " selection
            if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#folders[@]} ]; then
                PACKAGE_NAME="${folders[$((selection-1))]}"
                break
            else
                echoInfo "Invalid input. Please enter a number between 1 and ${#folders[@]}."
            fi
        done
    fi
}

# Prompt the user to select a TEST_TYPE if TEST_TYPE is empty
choose_test_if_empty() {
    if [ -z "${TEST_TYPE}" ]; then
        echoInfo "TEST_TYPE is empty."
        echoInfo "Please choose a test:"

        mapfile -t test_types < <(list_tests)

        if [ ${#test_types[@]} -eq 0 ]; then
            echoInfo "No test types found."
            exit 1
        fi

        for i in "${!test_types[@]}"; do
            printf "%3d) %s\n" $((i+1)) "${test_types[$i]}"
        done

        while true; do
            read -rp "Enter number (1-${#test_types[@]}): " selection
            if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#test_types[@]} ]; then
                TEST_TYPE="${test_types[$((selection-1))]}"
                break
            else
                echoInfo "Invalid input. Please enter a number between 1 and ${#test_types[@]}."
            fi
        done
    fi
}
