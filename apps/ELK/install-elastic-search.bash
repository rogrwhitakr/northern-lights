#! /usr/bin/env bash

# functions
print() {
	case "${1^^}" in
	RED)
		printf '\033[0;31m%s\033[0m\n' "${2}"
		;;
	YELLOW)
		printf '\e[33m%s\033[0m\n' "${2}"
		;;
	GREEN)
		printf '\e[0;32m%s\033[0m\n' "${2}"
		;;
	LINE)
		separator="-"            # separator default
		line="["                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		if ([[ ! -z "$2" ]] && [[ "${#2}" == 1 ]]); then # set custom the separator (length must be 1)
			separator="${2}"
		fi
		for ((i = 1; i <= "${term_size}-2"; i++)); do # make the line
			line+="${separator}"
		done
		line+="]"
		printf '%s\n' "${line}" # regurgitate to terminal
		;;
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac
}

rootcheck() {
	if [ "$(id -u)" != "0" ]; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}

#############################
# exec

print line
print green "# install elasticsearch on Fedora: $hostname"
print line

print red "# Step 1: installing requires escalation priviledge -> thus running as root"
rootcheck

print red "# Step 2: Add ELK repository"
cat <<EOF | tee /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
type=rpm-md
EOF

print red "# import GPG key"
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

print line
print red "# Clear and update dnf package index"
dnf clean all -v
dnf makecache

print yellow "# Step 3: Install Elasticsearch, java"
dnf -y install elasticsearch java-openjdk-devel java-openjdk

print yellow "# Step 4: Install Kibana"
dnf -y install kibana

print yellow "# Step 5: install logstash" 
dnf -y install logstash

print yellow "# Step 6: Install other ELK tools"
# Filebeat: Lightweight Shipper for Logs. It helps you keep the simple things simple by offering a lightweight way to forward and centralize logs and files
# Metricbeat: Collect metrics from your systems and services. From CPU to memory, Redis to NGINX, and much more, Metricbeat is a lightweight way to send system and service statistics.
# Packetbeat: Lightweight Shipper for Network Data
# Heartbeat: Lightweight Shipper for Uptime Monitoring. It helps you monitor services for their availability with active probing
# Auditbeat: Lightweight shipper that helps you audit the activities of users and processes on your systems
dnf install -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic

print line
print red "# Step 7: add firewall rules, unit files and rules"

# firewall
firewall-cmd --add-port=5601/tcp --permanent
firewall-cmd --add-port=9200/tcp --permanent
firewall-cmd --reload

# services
systemctl enable --now kibana.service
systemctl enable --now elasticsearch.service 
systemctl enable --now logstash.service 

print line
print green "# Complete"
print line