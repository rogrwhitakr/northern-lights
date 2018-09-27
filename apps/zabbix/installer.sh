#!/bin/bash

set -e
set -x

ZABBIX_DB=zabbix
ZABBIX_DB_HOST=zabbix
ZABBIX_DB_USER=zabbix
ZABBIX_DB_PASSWORD=zabbix

# make sure the script is not run as root
is_root() {
	if [[ "$(id -u)" == "0" ]]; then
		return true
	fi
}

if [[ is_root != true ]]; then 
echo -e "gna"
  exit 1
fi

# install the ZABBIX Stuff
dnf install -y zabbix-server-mysql zabbix-web-mysql mod_ssl mariadb-server

# add the timezone -> Europe/Berlin in my case
timezone=$(timedatectl | grep "Time zone:" | awk -F':' '{ print $2 }' | awk '{ print $1 }')
sed -e 's/^post_max_size = .*/post_max_size = 16M/g' \
	-e 's/^max_execution_time = .*/max_execution_time = 300/g' \
	-e 's/^max_input_time = .*/max_input_time = 300/g' \
	-e "s:^;date.timezone =.*:date.timezone = \"${timezone}\":g" \
	-i /etc/php.ini

# enable mariadb -> will aready be in place
systemctl enable mariadb
systemctl start mariadb

cat <<EOF | mysql -uroot
CREATE DATABASE IF NOT EXISTS '${ZABBIX_DB}';
GRANT ALL PRIVLEGES ON '${ZABBIX_DB}'.* to '${ZABBIX_DB_USER}'@'localhost' IDENTIFIED BY '{ZABBIX_DB_PASSWORD}';
EXIT
EOF

# import sql schema and data
# shellcheck disable=SC2002

for sql in schema.sql images.sql data.sql; do
	cat /usr/share/zabbix-mysql/"${sql}" | mysql -u"${ZABBIX_DB_USER}" -p"${ZABBIX_DB_PASSWORD}" "${ZABBIX_DB}"
done

sed -e 's/# ListenPort=.*/ListenPort=10051/g' \
	-e "s/# DBPassword=.*/DBPassword=${ZABBIX_DB_PASSWORD}/g" \
	-i /etc/zabbix_server.conf

# Skip setup.php
cat <<EOF | tee /etc/zabbix/web/zabbix.conf.php
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = '${ZABBIX_DB}';
\$DB['USER']     = '${ZABBIX_DB_USER}';
\$DB['PASSWORD'] = '${ZABBIX_DB_PASSWORD}';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = '';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
EOF

firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload

cat <<EOF >zabbix-server.te
module zabbix-server 1.0;
require {
  type zabbix_t;
  class process setrlimit;
}
#============= zabbix_t ==============
allow zabbix_t self:process setrlimit;
EOF

# unsure what this does
checkmodule -M -m -o zabbix-server.mod zabbix-server.te
semodule_package -m zabbix-server.mod -o zabbix-server.pp
semodule -i zabbix-server.pp
rm -f zabbix-server.te zabbix-server.mod zabbix-server.pp

setsebool -P httpd_can_connect_zabbix 1

# enable the web server
systemctl enable httpd zabbix-server-mysql
systemctl restart httpd zabbix-server

# This Hostname is used for Host name in
# Configuration -> Hosts -> Create Host.

install-zabbix-client(){
if (is_root)
# i should trap this...
dnf install -y zabbix-agent
sed -e "s/^Hostname=.*/Hostname=localhost/g" -i /etc/zabbix_agentd.conf
systemctl enable zabbix-agent
systemctl start zabbix-agent
}