# bin/sh

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

RED='\033[0;31m'
NOC='\033[0m' 	

service_name=daily-update
timer_on_unit_active_sec=12h

rm -f /etc/systemd/system/$service_name.service
rm -f /etc/systemd/system/$service_name.timer
rm -f /usr/lib/systemd/scripts/$service_name.sh

sleep 2

if [ ! -f /etc/systemd/system/$service_name.service ]; then
	touch /etc/systemd/system/$service_name.service
	echo "created $service_name.service"
	
	if [ ! -w /etc/systemd/system/$service_name.service ]; then
		chmod -R 622 /etc/systemd/system/$service_name.service
	fi	
fi

if [ ! -f /etc/systemd/system/$service_name.timer ]; then
	touch /etc/systemd/system/$service_name.timer
	echo "created $service_name.timer"

	if [ ! -w /etc/systemd/system/$service_name.timer ]; then
		chmod -R 622 /etc/systemd/system/$service_name.timer
	fi
fi

if [ ! -f /usr/lib/systemd/scripts/$service_name.sh ]; then
	touch /usr/lib/systemd/scripts/$service_name.sh
	echo "created script usr/lib/systemd/scripts/$service_name.sh"
	if [ ! -x /usr/lib/systemd/scripts/$service_name.sh ]; then
		chmod -R 760 /usr/lib/systemd/scripts/$service_name.sh
	fi	
fi

#chmod -R 622 /etc/systemd/system/$service_name.service
#chmod -R 622 /etc/systemd/system/$service_name.timer
#chmod -R 740 /usr/lib/systemd/scripts/$service_name.sh


tee /etc/systemd/system/$service_name.service > /dev/null <<EOF
[Unit]
Description=$service_name
After=syslog.target
After=network.target
After=timers.target

[Service]
Type=simple
ExecStart=/usr/lib/systemd/scripts/$service_name.sh --timer
EOF

tee /usr/lib/systemd/scripts/$service_name.sh > /dev/null <<EOF
#!/bin/sh -
dnf update -y
echo -e "my nigrow"
EOF

tee /etc/systemd/system/$service_name.timer > /dev/null <<EOF
[Unit]
Description=Runs $service_name.sh script every $timer_on_unit_active_sec

[Timer]
OnBootSec=10min
OnUnitActiveSec=$timer_on_unit_active_sec

[Install]
WantedBy=multi-user.target
EOF

echo -e "${RED}permissions on files:${NOC}"

ls -lah /etc/systemd/system/$service_name.timer
ls -lah /etc/systemd/system/$service_name.service
ls -lah /usr/lib/systemd/scripts/$service_name.sh