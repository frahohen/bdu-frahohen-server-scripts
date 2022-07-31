#!/bin/bash
# General
FILE_UTILS="./utils/file_utils.sh"
LOGGER=$(source ${FILE_UTILS} get_absolute_path install_dashy /utils/print_log.sh)
DASHY="Dashy -"

bash "${LOGGER}" info "${DASHY} Re-index and fetch all available packages"
apt update -y

bash "${LOGGER}" info "${DASHY} Install Nodejs"
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt install -y nodejs

bash "${LOGGER}" info "${DASHY} Installed Nodejs version:"
node -v

bash "${LOGGER}" info "${DASHY} Installed npm version:"
npm -v

bash "${LOGGER}" info "${DASHY} Install build-essential for npm"
apt install -y build-essential

bash "${LOGGER}" info "${DASHY} Install yarn"
npm install -g yarn

bash "${LOGGER}" info "${DASHY} Installed yarn version:"
yarn -v

bash "${LOGGER}" info "${DASHY} Download dashy"
git clone https://github.com/Lissy93/dashy.git /etc/dashy

bash "${LOGGER}" info "${DASHY} Configure dashy"
sed -i 's/\"scripts\": {/& \n    \"start-modified": "PORT=24000 node server",/' /etc/dashy/package.json
rm -f /etc/dashy/public/conf.yml
cp -f ./install_dashy/resources/etc/dashy/public/conf.yml /etc/dashy/public/

bash "${LOGGER}" info "${DASHY} Create service"
rm -f /etc/systemd/system/dashy.service
cp -f ./install_dashy/resources/etc/systemd/system/dashy.service /etc/systemd/system/
rm -f /etc/systemd/system/dashy.timer
cp -f ./install_dashy/resources/etc/systemd/system/dashy.timer /etc/systemd/system/

bash "${LOGGER}" info "${DASHY} Build dashy"
cd /etc/dashy
yarn
yarn build

bash "${LOGGER}" info "${DASHY} Start dashy"
systemctl enable dashy.timer
systemctl start dashy.timer