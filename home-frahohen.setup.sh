#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)

bash "${LOGGER}" info "Execute home.frahohen setup"
su root ./install_ssh_server/home-frahohen.install_ssh_server.sh
su root ./install_x2go_server/install_x2go_server.sh
bash "${LOGGER}" info "Setup for home.frahohen complete"
