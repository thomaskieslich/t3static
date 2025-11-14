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
    local message=$1
    local code=$2
    local exit_code=""

    if [[ -z "$code" || "$code" == "0" ]]; then
        exit_code="\033[1;32m(EXIT_CODE: 0)\033[0m"
    else
        exit_code="\033[1;31m(EXIT_CODE: $code)\033[0m"
    fi

    echo -e "\n\033[1;35m==> $message $exit_code\n"
}
