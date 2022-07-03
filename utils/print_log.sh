#!/bin/bash
# Colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NO_COLOR="\033[0m"
# Log Levels
LOG_INFO="INFO:"
LOG_ERROR="ERROR:"
LOG_WARNING="WARNING:"

LOG_LEVEL=$1
MESSAGE=$2

if [[ "${LOG_LEVEL}" == "info" ]]
then 
	printf "${GREEN}${LOG_INFO} ${MESSAGE}${NO_COLOR}\n"
elif [[ "${LOG_LEVEL}" == "warning" ]]
then 
	printf "${YELLOW}${LOG_WARNING} ${MESSAGE}${NO_COLOR}\n"
elif [[ "${LOG_LEVEL}" == "error" ]]
then 
	printf "${RED}${LOG_ERROR} ${MESSAGE}${NO_COLOR}\n"
else 
	printf "${RED}${LOG_ERROR} Log level parameter is not valid for the message you want to print${NO_COLOR}\n"
fi
