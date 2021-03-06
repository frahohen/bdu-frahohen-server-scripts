#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path utils /utils/print_log.sh)
SET_HOSTNAME="Set Hostname -"

HOSTNAME=$1

bash "${LOGGER}" info "${SET_HOSTNAME} Configure hostname in /etc/hostname"
hostnamectl set-hostname ${HOSTNAME}

bash "${LOGGER}" info "${SET_HOSTNAME} Configure hostname in /etc/hosts"
# remove lines that contain the following entries
#   localhost
#   hostname
#   router-frahohen
#   router-magenta
sed -i '/127.0.0.1/d' /etc/hosts
sed -i '/192.168.1.1/d' /etc/hosts
sed -i '/192.168.0.1/d' /etc/hosts

# add the entries in the following order:
#   localhost
#   hostname
#   router-frahohen
#   router-magenta
sed -i "1s/^/192.168.0.1     router-magenta\n/" /etc/hosts
sed -i "1s/^/192.168.1.1     router-frahohen\n/" /etc/hosts
sed -i "1s/^/127.0.0.1       $HOSTNAME\n/" /etc/hosts
sed -i "1s/^/127.0.0.1       localhost\n/" /etc/hosts

bash "${LOGGER}" info "${SET_HOSTNAME} Apply hostname configuration"
invoke-rc.d hostname.sh start