#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path utils /utils/print_log.sh)
SET_MOUNT_POINTS="Set Mount Points -"

FRAHOHEN_ROOT="/media/frahohen"
MOUNTPOINT="/media/frahohen/data-001-4tb"
# /dev/sda
DEVSDA="/dev/sda"
ESCAPED_DEVSDA="\/dev\/sda"
# /dev/sda /media/frahohen/data-001-4tb/ ext4 defaults 1 1
FSTABMOUNT="${DEVSDA} ${MOUNTPOINT}/ ext4 defaults 1 1"

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Unmount all mount points affected"
umount ${MOUNTPOINT}

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Configure mount points in /etc/fstab"
# remove lines with /dev/sda
sed -i "/${ESCAPED_DEVSDA}/d" /etc/fstab
# add at the end of the file the mount points
echo "${FSTABMOUNT}" >> /etc/fstab

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Create frahohen media folder"
mkdir ${FRAHOHEN_ROOT}

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Create mount point folders"
mkdir ${MOUNTPOINT}

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Mount storages"
mount -t ext4 ${DEVSDA} ${MOUNTPOINT}/

bash "${LOGGER}" info "${SET_MOUNT_POINTS} Apply rights for installed applications"
chown -R vbox:users ${FRAHOHEN_ROOT}/
chown -R vbox:users ${MOUNTPOINT}/
chmod 775 ${FRAHOHEN_ROOT}
chmod 775 ${MOUNTPOINT}
