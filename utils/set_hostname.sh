#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path utils /utils/print_log.sh)
SET_HOSTNAME="Set Hostname -"

HOSTNAME=$1

bash "${LOGGER}" info "${SET_HOSTNAME} Configure hostname in /etc/hostname"
hostnamectl set-hostname ${HOSTNAME}

bash "${LOGGER}" info "${SET_HOSTNAME} Configure hostname in /etc/hosts"
# remove lines with localhost and hostname
sudo sed '/127.0.0.1/d' /etc/hosts

# add at the beginning of the file localhost and hostname
sed -i '1s/^/127.0.0.1       ${HOSTNAME}\n/' /etc/hosts
sed -i '1s/^/127.0.0.1       localhost\n/' /etc/hosts

bash "${LOGGER}" info "${SET_HOSTNAME} Apply hostname configuration"
invoke-rc.d hostname.sh start