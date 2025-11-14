#!/bin/bash

# several functions to output echos in more visual way

# Example (color blue):
# ==> Test: rector
echoInfo() {
    echo -e "\n\033[1;34m==> $1\033[0m\n"
}

# Example (color magenta):
# ----------
# > Rector <
# ----------
echoTestHeader() {
    local text="$1"
    local line="> $text <"
    local width=${#line}
    local border=$(printf '%*s' "$width" | tr ' ' '-')
    echo -e "\033[1;35m$border\n$line\n$border\033[0m"
}

# Example (color magenta):
# ==> Rector completed
echoTestFooter() {
    if [[ -n "$2" ]]; then
        local exit_message=""
        local output=""
        case "$2" in
        1) exit_message="General error" ;;
        2) exit_message="Misuse of shell builtin" ;;
        126) exit_message="Command cannot be executed" ;;
        127) exit_message="Command not found" ;;
        130) exit_message="Script interrupted by user (CTRL+C)" ;;
        *) exit_message="Unknown error" ;;
        esac
        local color="\033[1;31m" # Red for errors
        output=$(echo -e "${color}EXIT_CODE: $2 - $exit_message\033[0m")
    else
        local color="\033[1;32m" # Green for success
        output=$(echo -e "${color}Success\033[0m")
    fi

    echo -e "\n\033[1;35m==> $1: $output\033[0m\n"
}
