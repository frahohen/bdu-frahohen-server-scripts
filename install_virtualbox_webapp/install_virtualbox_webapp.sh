#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_virtualbox_webapp /utils/print_log.sh)
VIRTUALBOXWEBAPP="VirtualBox WebApp -"

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install APT keys"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -

REPO_VIRTUALBOX="deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bullseye contrib"
FILE_SOURCE_LIST="/etc/apt/sources.list.d/virtualbox.list"

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Add repository \"${REPO_VIRTUALBOX}\" to file \"${FILE_SOURCE_LIST}\""
echo "" >> "${FILE_SOURCE_LIST}"
echo "#VirtualBox repository" >> "${FILE_SOURCE_LIST}"
echo "${REPO_VIRTUALBOX}" | tee "${FILE_SOURCE_LIST}" > /dev/null

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install linux headers"
apt install linux-headers-$(uname -r) dkms

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install virtualbox"
apt install -y virtualbox-6.1

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Prepare latest virtualbox extensions pack"
LatestVirtualBoxVersion=$(wget -qO - http://download.virtualbox.org/virtualbox/LATEST.TXT) && wget "http://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack"
https://www.virtualbox.org/download/hashes/${LatestVirtualBoxVersion}/SHA256SUMS

bash "${LOGGER}" info "${SSHSERVER} Install expect if not already installed"
apt install -y expect

bash "${LOGGER}" info "${SSHSERVER} Install virtualbox extensions pack"
expect ./install_virtualbox_webapp/expect_virtualbox_extension.sh ${LatestVirtualBoxVersion}

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Add a user which will be used for phpvirtualbox configuration later"
VboxUser="vbox"
VboxPassword="vbox"
expect ./install_virtualbox_webapp/expect_adduser.sh ${VboxUser} ${VboxPassword}
usermod -aG vboxusers vbox
systemctl status vboxdrv

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install prerequisites for nginx"
apt install -y curl gnupg2 ca-certificates lsb-release

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install nginx"
apt install -y nginx
systemctl enable nginx
ufw allow 'Nginx Full'

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install php"
apt install -y php7.4-fpm php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip php7.4-soap php7.4-imap

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Install unzip, download phpvirtualbox, unzip folder, rename phpvirtualbox and copy configuration"
apt install unzip
wget "https://github.com/phpvirtualbox/phpvirtualbox/archive/develop.zip"
unzip develop.zip
mv phpvirtualbox-develop phpvirtualbox
cp -f ./install_virtualbox_webapp/resources/phpvirtualbox/config.php ./phpvirtualbox/

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Move folder phpvirtualbox, apply access and configure autostart"
rm -rf /var/www/phpvirtualbox/
mv -f phpvirtualbox /var/www/
chown -R 998:996 /var/www/phpvirtualbox
chmod -R 755 /var/www/phpvirtualbox/
rm -f /etc/default/virtualbox
cp -f ./install_virtualbox_webapp/resources/etc/default/virtualbox /etc/default/
rm -f /etc/vbox/autostart.cfg
cp -f ./install_virtualbox_webapp/resources/etc/vbox/autostart.cfg /etc/vbox/
chgrp vboxusers /etc/vbox
chmod 1775 /etc/vbox

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Restart vbox services"
systemctl daemon-reload
systemctl restart vboxdrv
systemctl restart vboxweb-service

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Create user for webgui"
WebGUIUser="phpvirtualbox-webgui"
WebGUIPassword="phpvirtualbox"
expect ./install_virtualbox_webapp/expect_adduser.sh ${WebGUIUser} ${WebGUIPassword}

bash "${LOGGER}" info "${VIRTUALBOXWEBAPP} Copy configuration for nginx/php, apply access and restart services"
rm -f /etc/nginx/sites-available/phpvirtualbox-webgui 
cp -f ./install_virtualbox_webapp/resources/etc/nginx/sites-available/phpvirtualbox-webgui /etc/nginx/sites-available/
rm -f /etc/php/7.4/fpm/pool.d/phpvirtualbox-webgui.conf
cp -f ./install_virtualbox_webapp/resources/etc/php/7.4/fpm/pool.d/phpvirtualbox-webgui.conf /etc/php/7.4/fpm/pool.d/
ln -s /etc/nginx/sites-available/phpvirtualbox-webgui /etc/nginx/sites-enabled
chown -R www-data /var/www/html
chown -R www-data /var/www/phpvirtualbox
systemctl daemon-reload
systemctl restart nginx
systemctl restart php7.4-fpm
