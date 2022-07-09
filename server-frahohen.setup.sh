#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)

bash "${LOGGER}" info "Execute server.frahohen setup"
su root ./install_ssh_server/server-frahohen.install_ssh_server.sh
su root ./install_x2go_server/install_x2go_server.sh
su root ./install_syncthing/install_syncthing.sh
su root ./install_virtualbox_webapp/install_virtualbox_webapp.sh
su root ./install_nut_server/install_nut_server.sh
bash "${LOGGER}" info "Setup for server.frahohen complete"

# Reboot is required for the nut server setup
echo "Reboot required to complete nut server setup. Do you want to reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) bash "${LOGGER}" info "Rebooting system"; sudo systemctl reboot; break;;
        No ) exit;;
    esac
done


