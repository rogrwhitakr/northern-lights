#!/bin/bash
#################################################
# Setup Fedora 23 Gnome3 with xRDP via XFCE4
#################################################

# install the XFCE4 desktop
sudo dnf groupinstall xfce-desktop

# open standard RDP ports
sudo firewall-cmd --add-port=3389/tcp
sudo firewall-cmd --permanent --add-port=3389/tcp

# install TigerVNC and xRDP
sudo dnf install tigervnc tigervnc-server
sudo dnf install xrdp

# stop disabling SELinux
sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman

# enable xRDP service
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman

# start xRDP service
sudo systemctl start xrdp-sesman
sudo systemctl start xrdp.service

# set XFCE4 desktop for RDP connections
sudo echo "startxfce4" > ~/.Xclients
sudo chmod +x ~/.Xclients
sudo systemctl restart xrdp.service
