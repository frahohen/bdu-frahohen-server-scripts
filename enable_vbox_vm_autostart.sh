#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path "" /utils/print_log.sh)
VBOX_VM_AUTOSTART="VBOX VM autostart -"

# get all the available vms by name as list
VM_NAME_LIST=$(sudo -u vbox VBoxManage list vms | sudo -u vbox grep -o -P '(?<=").*(?=")')

bash "${LOGGER}" info "${VBOX_VM_AUTOSTART} Display list of available VMs with name and UUID"
VBoxManage list vms

bash "${LOGGER}" info "${VBOX_VM_AUTOSTART} Create list options. Please choose the vm to apply to autostart to:"
bash "${LOGGER}" warning "${VBOX_VM_AUTOSTART} Note: Make sure the VM is shutdown before continuing!"
declare -a options_array
options_array=(${VM_NAME_LIST})
select option in "${options_array[@]}";
do
	VM_NAME=$option
	break;
done

# get the id of the chosen vm
VM_ID=$(VBoxManage list vms | grep -F "${VM_NAME}" | grep -o -P '(?<={).*(?=})')

bash "${LOGGER}" info "${VBOX_VM_AUTOSTART} Autostart will be set for '${VM_NAME}' with id '${VM_ID}'"
VBoxManage setproperty autostartdbpath /etc/vbox
VBoxManage modifyvm ${VM_ID} --autostart-enabled on --autostart-delay 120
VBoxManage modifyvm ${VM_ID} --autostop-type acpishutdown

bash "${LOGGER}" info "${VBOX_VM_AUTOSTART} Restart vboxautostart-service"
sudo -i -u root service vboxautostart-service restart
bash "${LOGGER}" info "${VBOX_VM_AUTOSTART} Autostart for ${VM_NAME} is enabled"
