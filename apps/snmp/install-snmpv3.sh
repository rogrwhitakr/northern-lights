#! /usr/bin/env bash

run_as_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "script $(basename "$0") must be run as root." >&2
        exit 1
    fi
    echo "executing script $(basename "$0")"
}

# Call the function
run_as_root

# vars
snmpd_conf="/etc/snmp/snmpd.conf"

# installs
dnf install net-snmp -y

# remove datas
sed --in-place 's/^sysLocation/# sysLocation/g' "${snmpd_conf}"
sed --in-place 's/^sysContact/# sysContact/g' "${snmpd_conf}"

# some data
echo " " | tee --append "${snmpd_conf}"
echo "########################### northern-lights.one ##########################" | tee --append "${snmpd_conf}"
echo " " | tee --append "${snmpd_conf}"

grep -qxF 'sysLocation       $(hostname).northern-lights.one' "${snmpd_conf}" || echo "sysLocation       $(hostname).northern-lights.one" | tee --append "${snmpd_conf}"
grep -qxF 'sysContact        admin@northern-lights.one' "${snmpd_conf}" || echo "sysContact        admin@northern-lights.one" | tee --append "${snmpd_conf}"
grep -qxF 'agentaddress      udp:161,udp6:[::1]:161' "${snmpd_conf}" || echo "agentaddress      udp:161,udp6:[::1]:161" | tee --append "${snmpd_conf}"

echo " " | tee --append "${snmpd_conf}"
echo "##########################################################################" | tee --append "${snmpd_conf}"


# stop the snmpd service
systemctl stop snmpd.service

# some user config
net-snmp-create-v3-user -ro -A Uu*Ee5ZQQfA#6t -X @PoeRyjtrmN3Q5 -a SHA-512 -x AES128 zbx_monitor

# add the snmp ports to the firewall, make sure beforhand that firewalld is running
systemctl restart firewalld.service
firewall-cmd --permanent --service=snmp --add-port=161/udp --add-port=161/tcp
firewall-cmd --permanent --service=snmptls --add-port=10161/udp --add-port=10161/tcp

# restart for effect
systemctl restart firewalld.service

# restart snmpd
systemctl restart snmpd.service