#!/usr/bin bash

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# ------------------ install LAMP environment on Fedora 21-23 ------------------ 
dnf install -y httpd mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt 

# ------------------ download Wordpress ------------------
cd /tmp
wget http://wordpress.org/latest.tar.gz

# ------------------ extract ------------------
tar -xvzf latest.tar.gz -C /var/www/html


# ------------------ enable, start mysql ------------------
systemctl enable mariadb.service
systemctl start mariadb.service
systemctl status mariadb.service
pause