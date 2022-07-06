#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)

bash "${LOGGER}" info "Execute frahohen-server setup"
su root ./install_ssh_server/install_ssh_server.sh
su root ./install_x2go_server/install_x2go_server.sh
su root ./install_syncthing/install_syncthing.sh
su root ./install_virtualbox_webapp/install_virtualbox_webapp.sh
# TODO: install nut and configure it on server
bash "${LOGGER}" info "Setup for frahohen-server complete"
