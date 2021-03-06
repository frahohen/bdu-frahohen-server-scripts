#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_file_browser /utils/print_log.sh)
FILEBROWSER="File Browser -"

bash "${LOGGER}" info "${FILEBROWSER} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${FILEBROWSER} Install File Browser"
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

bash "${LOGGER}" info "${FILEBROWSER} Create service and start File Browser"
rm -f /etc/systemd/system/filebrowser.service
cp -f ./install_file_browser/resources/etc/systemd/system/filebrowser.service /etc/systemd/system/
rm -f /etc/systemd/system/filebrowser.timer
cp -f ./install_file_browser/resources/etc/systemd/system/filebrowser.timer /etc/systemd/system/
systemctl daemon-reload
systemctl enable filebrowser.timer
systemctl start filebrowser.timer