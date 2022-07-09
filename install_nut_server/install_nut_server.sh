#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_nut_server /utils/print_log.sh)
NUT="NUT -"

bash "${LOGGER}" info "${NUT} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${NUT} Install nut"
apt install -y nut

bash "${LOGGER}" info "${NUT} Show usb port connections"
lsusb

bash "${LOGGER}" info "${NUT} Configure default"
rm -f /etc/default/nut
cp -f ./install_nut_server/resources/etc/default/nut /etc/default/

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nut 640 ./install_nut_server/resources/etc/nut/ups.conf /etc/nut/ups.conf)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nut 640 ./install_nut_server/resources/etc/nut/upsmon.conf /etc/nut/upsmon.conf)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nut 640 ./install_nut_server/resources/etc/nut/nut.conf /etc/nut/nut.conf)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nut 640 ./install_nut_server/resources/etc/nut/upsd.users /etc/nut/upsd.users)
echo ${SOURCE_COMMAND}

SOURCE_COMMAND=$(source ${FILE_UTILS} replace_file root nut 750 ./install_nut_server/resources/etc/nut/shutdown /etc/nut/shutdown)
echo ${SOURCE_COMMAND}

bash "${LOGGER}" info "${NUT} Configure cronjob for restarting driver if usb port issues occur"
rm -f /etc/cron.d/nutups
cp -f ./install_nut_server/resources/etc/cron.d/nutups /etc/cron.d/
chmod 755 /etc/cron.d/nutups
