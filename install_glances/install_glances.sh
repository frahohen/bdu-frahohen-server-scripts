#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_glances /utils/print_log.sh)
GLANCES="Glances -"

bash "${LOGGER}" info "${GLANCES} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${GLANCES} Install all required packages and glances"
apt install -y python3 python3-psutil python3-defusedxml python3-future python3-dev python3-jinja2 python3-setuptools hddtemp python3-pip lm-sensors python3-bottle
pip3 install --user 'glances[web,ip]'

bash "${LOGGER}" info "${GLANCES} Create service and start glances"
rm -f /etc/systemd/system/glances.service
cp -f ./install_glances/resources/etc/systemd/system/glances.service /etc/systemd/system/
systemctl enable glances.service
systemctl start glances.service