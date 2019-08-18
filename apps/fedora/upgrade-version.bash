#start upgrade process
sudo dnf upgrade --refresh -y

# install the plugin if needed
sudo dnf install dnf-plugin-system-upgrade -y

# download all new things
sudo dnf system-upgrade download --releasever=30 --allowerasing -y

# in case of curl error
sudo dnf system-upgrade download --releasever=30 --allowerasing -y --nogpgcheck

# do the update
sudo dnf system-upgrade reboot