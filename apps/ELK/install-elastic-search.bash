#! /usr/bin/env bash

# how to install elastic-search of fedora

# Step 1: installing requires escalation priviledge -> thus running as root
rootcheck() {
	if [ "$(id -u)" != "0" ]; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}

rootcheck

# Step 2: Add ELK repository
cat <<EOF | tee /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# After adding the repo, import GPG key:
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Clear and update your dnf package index.
dnf clean all -v
dnf makecache

# Step 3: Install Elasticsearch, java
dnf -y install elasticsearch java-openjdk-devel java-openjdk

# service
systemctl enable --now elasticsearch.service 

# Step 4: Install and Configure Kibana
dnf -y install kibana

# service
systemctl enable --now kibana

# firewall
firewall-cmd --add-port=5601/tcp --permanent
firewall-cmd --add-port=9200/tcp --permanent
firewall-cmd --reload

# Step 5: logstash 
dnf -y install logstash

# Step 6: Install other ELK tools – Bonus
# Filebeat: Lightweight Shipper for Logs. It helps you keep the simple things simple by offering a lightweight way to forward and centralize logs and files
# Metricbeat: Collect metrics from your systems and services. From CPU to memory, Redis to NGINX, and much more, Metricbeat is a lightweight way to send system and service statistics.
# Packetbeat: Lightweight Shipper for Network Data
# Heartbeat: Lightweight Shipper for Uptime Monitoring. It helps you monitor services for their availability with active probing
# Auditbeat: Lightweight shipper that helps you audit the activities of users and processes on your systems

dnf install -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic