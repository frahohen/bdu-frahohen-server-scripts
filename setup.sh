#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)

bash "${LOGGER}" info "Execute frahohen-server setup"
# TODO: install ssh server
#su root ./install_ssh_server/install_ssh_server.sh
# TODO: install x2go or vnc
# TODO: install samba server for network file transfer
# TODO: install syncTracor required for securing/synching data on my pc  
# TODO: install virtualbox and phpvirtualbox
su root ./install_virtualbox_webapp/install_virtualbox_webapp.sh
# TODO: install nut and configure it on server
bash "${LOGGER}" info "Setup for frahohen-server complete"
