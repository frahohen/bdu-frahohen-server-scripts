#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_x2go_server /utils/print_log.sh)
X2GOSERVER="X2GO Server -"

bash "${LOGGER}" info "${X2GOSERVER} Re-index and fetch all available packages"
apt update -y
bash "${LOGGER}" info "${X2GOSERVER} Install X2GO server"
apt install -y xfce4 x2goserver x2goserver-xsession
