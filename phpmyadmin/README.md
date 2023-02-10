# PhpMyAdmin

## Config Apache2
```apache2
<VirtualHost 161.97.174.226:9292>
	SuexecUserGroup "#33" "#33"
	ServerName 161.97.174.226
	DocumentRoot /var/www/pamin
	ErrorLog /var/log/apache2/pamin_error.log
	CustomLog /var/log/apache2/pamin_access.log combined
	DirectoryIndex index.php index.php4 index.php5 index.htm index.html
	<Directory /var/www/pamin>
		Options -Indexes +IncludesNOEXEC +SymLinksIfOwnerMatch +ExecCGI
	        allow from all
	        AllowOverride All Options=ExecCGI,Includes,IncludesNOEXEC,Indexes,MultiViews,SymLinksIfOwnerMatch
	        Require all granted
	</Directory>
    	RemoveHandler .php5.6
	RemoveHandler .php7.2
	RemoveHandler .php7.3
	RemoveHandler .php7.4
	RemoveHandler .php8.1
	<FilesMatch \.php$>
		SetHandler proxy:unix:/var/php-fpm/pamin.sock|fcgi://localhost
	</FilesMatch>
	php_admin_value engine Off

</VirtualHost>

```

## Script to manage

```bash
#! /bin/bash

case $1 in
    start)
        sudo a2ensite pamin && sudo service apache2 restart
        ;;
    restart)
        sudo service apache2 restart
        ;;
    stop)
        sudo a2dissite pamin && sudo service apache2 restart
        ;;
esac
```

Put this script on `/usr/bin/pamin`, then change the permission with following command:

```shell
sudo chmod +x /usr/bin/pamin
```
