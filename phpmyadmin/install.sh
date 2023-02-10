#! /bin/bash

# mysql exists ?
if ! type mysql >/dev/null 2>&1; then
  printf "\n\nMYSQL not installed, you need mysql to use this script\n\n"
  exit 1
fi

# apache2 exists ?
if ! type apache2 >/dev/null 2>&1; then
  printf "\n\nApache2 not installed, you need mysql to use this script\n\n"
  exit 1
fi

PMA_LATEST_VERSION_INFO_URL="https://www.phpmyadmin.net/home_page/version.php"
PMA_LANGUAGE='english'
PMA_VERSION=$(wget -q -O /tmp/pma_lastest.html $PMA_LATEST_VERSION_INFO_URL && sed -ne '1p' /tmp/pma_lastest.html);
PMA_FILE=phpMyAdmin-${PMA_VERSION}-${PMA_LANGUAGE}.tar.gz
PHPMYADMIN_DOWNLOAD_LINK="https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/$PMA_FILE"
PHPMYADMIN_EXECUTE_FILE="https://raw.githubusercontent.com/thisnugroho/linux-script-resource/main/phpmyadmin/phpmyadmin"
APACHE_CONF="https://raw.githubusercontent.com/thisnugroho/linux-script-resource/main/phpmyadmin/phpmyadmin-apache2.conf"
APACHE_CONF="https://raw.githubusercontent.com/thisnugroho/linux-script-resource/main/phpmyadmin/phpmyadmin-fpm.conf"
PHPMYADMIN="$(basename -- $PHPMYADMIN_EXECUTE_FILE)"
FOLDER_NAME="${PMA_FILE%.*}"
SERVER_IP="$(hostname -I | cut -d' ' -f1)"

install() {
  sudo apt-get install wget unzip -y 
  wget "$PHPMYADMIN_DOWNLOAD_LINK"
  sudo mkdir -p /var/phpmyadmin && mkdir -p /var/php-fpm
  sudo mv "$PMA_FILE" /var/phpmyadmin && sudo cd /var/phpmyadmin && sudo tar xvf "/var/phpmyadmin/$PMA_FILE" --strip-components 1
  sudo rm "/var/phpmyadmin/$PMA_FILE"
  
  sudo wget "$APACHE_CONF" -O /etc/apache2/sites-available/phpmyadmin.conf
  sudo wget "$FPM_CONF" -O /etc/apache2/php/8.1/fpm/pool.d/phpmyadmin-fpm.conf

  wget "$PHPMYADMIN_EXECUTE_FILE"
  sudo mv "$PHPMYADMIN" /usr/bin
  sudo chmod +x /usr/bin/phpmyadmin

  printf "\n\n Now you can start PhpMyAdmin\n"
  printf "phpmyadmin start\n"
  printf "Access : $SERVER_IP:9292\n"
}

install
