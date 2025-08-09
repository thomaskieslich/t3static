#!/bin/bash

# several functions to handle all utilizations of config stuff


# we have the CONFIG-constants and the relative path to config file as argument
# check if CONFIGURATION_PATH has the wanted configuration file otherwise use the base path
configPath() {
  if [[ -f "${CONFIGURATION_PATH}/$1" ]]; then
    printf '%s\n' "${CONFIGURATION_PATH}/$1"
    return 0
  else
    printf '%s\n' "${CONFIGURATION_BASE_PATH}/$1"
    return 0
  fi
}
