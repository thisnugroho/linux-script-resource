# PhpMyAdmin

This script will assist you in installing phpMyAdmin, and you can start or stop it at any time using the `phpmyadmin` commands

## Requirements

- Apache2
- PHP 8.1
- Php-fpm
- MySQL 5.x + 

## Usage

```shell
curl https://raw.githubusercontent.com/thisnugroho/linux-script-resource/main/phpmyadmin/install.sh | bash
```
### Start phpmyadmin

```shell
phpmyadmin start
```

### Stop phpmyadmin

```shell
phpmyadmin stop
```


## What Does install.sh do ?

After running install.sh, it will perform the following actions:

1. Download phpMyAdmin
2. Create the /var/phpmyadmin folder and extract the downloaded phpMyAdmin archive to that location.
3. Create a phpmyadmin file and place it in /usr/bin so that it can be executed.
4. Create a Virtual Host and PHP-FPM configuration file, phpmyadmin.conf.