#!/bin/bash

# retrieves the absolute path of the script path from the root directory provided
# example:
#   root directory:                         ./test_project/
#   relative path of target script folder:  ./test_project/some_folder/ => some_folder
#   realtive path of util script:           ./test_project/utils/print_log.sh => utils/print_log.sh
#   absolute path calculated:               /home/dev/test_project/
function get_absolute_path() {
    local RELATIVE_PATH_TARGET_FOLDER=$1
    local RELATIVE_PATH_UTIL_SCRIPT=$2
    local FILE_UTILS_PATH=$(dirname $(realpath "$0"))
    printf "${FILE_UTILS_PATH//${RELATIVE_PATH_TARGET_FOLDER}}${RELATIVE_PATH_UTIL_SCRIPT}\n"
}

LOGGER="./utils/print_log.sh" # currently the script that calls a function decides the absolute path
FILE_UTILS="File Utils -"

function replace_file() {
    local USER=$1
    local GROUP=$2
    local RIGHTS=$3
    local SOURCE_PATH=$4
    local DESTINATION_PATH=$5

    bash "${LOGGER}" info "${FILE_UTILS} Replace ${DESTINATION_PATH}"

    rm ${DESTINATION_PATH}
    cp ${SOURCE_PATH} ${DESTINATION_PATH}
    chmod ${RIGHTS} ${DESTINATION_PATH}
    chown ${USER}:${GROUP} ${DESTINATION_PATH}
}

# --- add functions here ---

case $1 in
    get_absolute_path) "$@"; exit;;
    replace_file) "$@"; exit;;
esac
