#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)
SET_HOSTNAME=$(source ${FILE_UTILS} get_absolute_path "" /utils/set_hostname.sh)

bash "${LOGGER}" info "Execute home-frahohen setup"
su root ./install_ssh_server/home-frahohen.install_ssh_server.sh
su root ./install_x2go_server/install_x2go_server.sh
su root ./utils/set_hostname.sh home-frahohen
bash "${LOGGER}" info "Setup for home-frahohen complete"

# Reboot is required for hostname configuration
echo "Reboot required to complete setup. Do you want to reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) bash "${LOGGER}" info "Rebooting system"; sudo systemctl reboot; break;;
        No ) exit;;
    esac
done