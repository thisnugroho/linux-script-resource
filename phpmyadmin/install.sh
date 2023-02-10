#! /bin/bash

# 9292 is Used ?
if lsof -Pi :9292 -sTCP:LISTEN -t >/dev/null; then
  echo "PORT 9292 is already in used"
  exit 1
fi

# mysql exists ?
if ! type mysql >/dev/null 2>&1; then
  printf "\n\nMYSQL not installed, you need mysql to use this script\n\n"
  exit 1
fi

PMA_LATEST_VERSION_INFO_URL="https://www.phpmyadmin.net/home_page/version.php"
PMA_LANGUAGE='english'
PMA_VERSION=$(wget -q -O /tmp/pma_lastest.html $PMA_LATEST_VERSION_INFO_URL && sed -ne '1p' /tmp/pma_lastest.html);
PMA_FILE=phpMyAdmin-${PMA_VERSION}-${PMA_LANGUAGE}.tar.gz
DOWNLOAD_LINK="https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/$PMA_FILE"
PAMIN_SERVICE="https://raw.githubusercontent.com/thisnugroho/linux-script-resource/main/phpmyadmin/phpmyadmin"
PAMIN_SERVICE_FILE="$(basename -- $PAMIN_SERVICE)"
FILE_NAME="$(basename -- $DOWNLOAD_LINK)"
FOLDER_NAME="${FILE_NAME%.*}"
SERVER_IP="$(hostname -I | cut -d' ' -f1)"

install() {
  sudo apt-get install wget unzip -y
  wget "$DOWNLOAD_LINK"
  unzip "$FILE_NAME"
  mkdir -p /var/pamin
  mv "$FOLDER_NAME"/* /var/pamin/
  rm "$FILE_NAME"

  wget "$PAMIN_SERVICE"
  sudo mv "$PAMIN_SERVICE_FILE" /usr/bin
  sudo chmod +x 

  printf "\n\n Now you can start pamin\n"
  printf "phpmyadmin start\n"
  printf "Access : $SERVER_IP:9292\n"
}

installPamin
