#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_syncthing /utils/print_log.sh)
SYNCTHING="Syncthing -"

bash "${LOGGER}" info "${SYNCTHING} Install prerequisites"
apt install -y gnupg2 curl apt-transport-https

bash "${LOGGER}" info "${SYNCTHING} Install APT keys"
curl -s https://syncthing.net/release-key.txt | apt-key add -

REPO_SYNCTHING="deb https://apt.syncthing.net/ syncthing release"
FILE_SOURCE_LIST="/etc/apt/sources.list.d/syncthing.list"

bash "${LOGGER}" info "${SYNCTHING} Add repository \"${REPO_SYNCTHING}\" to file \"${FILE_SOURCE_LIST}\""
echo "" >> "${FILE_SOURCE_LIST}"
echo "#Syncthing repository" >> "${FILE_SOURCE_LIST}"
echo "${REPO_SYNCTHING}" | tee "${FILE_SOURCE_LIST}" > /dev/null

bash "${LOGGER}" info "${SYNCTHING} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${SYNCTHING} Install syncthing"
apt install -y syncthing

bash "${LOGGER}" info "${SYNCTHING} Show installed syncthing version"
syncthing --version

bash "${LOGGER}" info "${SYNCTHING} Configure syncthing service"
rm -f /etc/systemd/system/syncthing@.service
cp -f ./install_syncthing/resources/etc/systemd/system/syncthing@.service /etc/systemd/system/

bash "${LOGGER}" info "${SYNCTHING} Reload systemd deamon and syncthing service"
systemctl daemon-reload
systemctl start syncthing@root
systemctl enable syncthing@root
