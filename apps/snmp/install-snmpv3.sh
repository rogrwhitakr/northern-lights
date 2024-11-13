	#! /usr/bin/env bash
	
	# vars
	snmpd_conf="/etc/snmp/snmpd.conf"
	custom_conf="/etc/snmp/snmpd.conf.d/northernlights.one.conf"
	
	# installs
	sudo apt install snmpd libsnmp-dev -y
	
	# some data
	echo "sysLocation       northernlights.one" | sudo tee "${custom_conf}"
	echo "sysContact        admin@northernlights.one" | sudo tee -a "${custom_conf}"
	echo "agentaddress      udp:161" | sudo tee -a "${custom_conf}"
	
	sudo sed --in-place 's/^agentaddress/# agentaddress/g' "${snmpd_conf}"
	
	# stop the snmpd service
	sudo systemctl stop snmpd.service
	
	# some user config
	sudo net-snmp-config --create-snmpv3-user -ro -A Uu*Ee5ZQQfA#6t -X @PoeRyjtrmN3Q5 -a SHA-512 -x AES128 zbx_monitor
	
	# restart snmpd
sudo systemctl restart snmpd.service