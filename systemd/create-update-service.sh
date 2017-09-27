# bin/sh

# functions
# check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# possible values
# OnUnitActiveSec= defines a timer relative to when the unit the timer is activating was last activated

# Parsing Time Spans
# When parsing, systemd will accept the same time span syntax. 
# If no time unit is specified, generally seconds are assumed
# non-English names for the time units are not accepted.
# Separating spaces may be omitted. 
# The following time units are understood:
# 	usec, us
# 	msec, ms
# 	seconds, second, sec, s
# 	minutes, minute, min, m
# 	hours, hour, hr, h
# 	days, day, d
# 	weeks, week, w
# 	months, month, M (defined as 30.44 days)
# 	years, year, y (defined as 365.25 days)
#
# Examples for valid time span specifications:
# 
# 	2 h
# 	2hours
# 	48hr
# 	1y 12month
# 	55s500ms
# 	300ms20s 5day

timer_on_unit_active_sec=35min
service_name="daily-update"

service_file="/etc/systemd/system/$service_name.service"
service_timer="/etc/systemd/system/$service_name.timer"
service_script="/usr/lib/systemd/scripts/$service_name.sh"

rm -f $service_file
rm -f $service_timer
rm -f $service_script

sleep 2

if [ ! -f "$service_file" ]; then
	touch "$service_file"
	echo "created $service_file"
	tee "$service_file" > /dev/null <<EOF
[Unit]
Description=$service_name
After=syslog.target
After=network.target
After=timers.target

[Service]
Type=simple
ExecStart="$service_script" --timer
EOF
	if [ ! -w "$service_file" ]; then
		chmod 622 "$service_file"
	fi	
fi

if [ ! -f "$service_timer" ]; then
	touch "$service_timer"
	echo "created $service_timer"
tee "$service_timer" > /dev/null <<EOF
[Unit]
Description=Runs $service_name.sh script every $timer_on_unit_active_sec

[Timer]
OnBootSec=10min
OnUnitActiveSec=$timer_on_unit_active_sec

[Install]
WantedBy=multi-user.target
EOF
	if [ ! -w "$service_timer" ]; then
		chmod -R 622 "$service_timer"
	fi
fi

if [ ! -f "$service_script" ]; then
	touch "$service_script"
	echo "created script $service_script"
tee "$service_script" > /dev/null <<EOF
#! /bin/sh

log="/var/log/daily-update.log"

if [ ! -f "$log" ]; then
        touch $log
        echo "$DATE"
        echo "Log for daily-update-timer created." >> $log
fi

echo "$DATE" >> $log
dnf update -y

EOF
	if [ ! -x "$service_script" ]; then
		chmod 740 "$service_script"
	fi	
fi

ls -lah $service_file
ls -lah $service_timer
ls -lah $service_script

exit 0