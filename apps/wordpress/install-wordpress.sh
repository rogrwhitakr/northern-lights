#!/bin/sh -

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#check command avaiability

if [ -n "$(command -v yum)" ]; then
	installer="$(command -v yum)"
fi	

if [ -n "$(command -v apt-get)" ];then
	installer="$(command -v yum)"
fi

if [ -n "$(command -v dnf)" ];then
	installer="$(command -v dnf)"
fi

echo "the installer is $installer."

read -rsp "KCCO ? Press [ENTER]: "


# ------------------ install LAMP environment ------------------ 
$installer install httpd community-mysql-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt
#httpd mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt 

read -rsp "KCCO ? Press [ENTER]: "

exit 0
# ------------------ download Wordpress ------------------
cd /tmp
wget http://wordpress.org/latest.tar.gz

# ------------------ extract ------------------
#tar -xvzf latest.tar.gz -C /var/www/html


# ------------------ enable, start mysql ------------------
systemctl start mysqld.service
systemctl enable mysqld.service
 
#pause
exit
# ------------------ Create MySQL Database WordPress ------------------
#mysql -u root -p
#CREATE USER wordpress@localhost IDENTIFIED BY "wordpress";
#CREATE DATABASE wordpress;
#GRANT ALL ON wordpress.* TO wordpress@localhost;
#FLUSH PRIVILEGES;
#EXIT;

# ------------------ edit the web server configuration ------------------
#nano /etc/httpd/conf/httpd.conf
#insert

#	<VirtualHost *:80>
#	  ServerAdmin root@localhost
#	  DocumentRoot /var/www/html/wordpress
#	  ServerName <machine_name>
#	  ErrorLog /var/log/httpd/wordpress-error-log
#	  CustomLog /var/log/httpd/wordpress-acces-log common
#	</VirtualHost>
#
# ------------------ edit hosts
#nano /etc/hosts
# ------------------ insert 
#127.0.0.1  wordpress

# configure wordpress
#cd /var/www/html/wordpress
#cp wp-config-sample.php wp-config.php

# edit database settings
#	nano wp-config.php
#
#	/** The name of the database for WordPress */
#	define('DB_NAME', 'database_name_here');
#
#	/** MySQL database username */
#	define('DB_USER', 'username_here');
#
#	/** MySQL database password */
#	define('DB_PASSWORD', 'password_here');
#
#	/** MySQL hostname */
#	define('DB_HOST', 'localhost');
#
#	/** Database Charset to use in creating database tables. */
#	define('DB_CHARSET', 'utf8');
#
#	/** The Database Collate type. Don't change this if in doubt. */
#	define('DB_COLLATE', '');