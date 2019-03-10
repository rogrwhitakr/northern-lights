#start upgrade process
sudo dnf upgrade --refresh -y

# install the plugin if needed
sudo dnf install dnf-plugin-system-upgrade -y

# download all new things
sudo dnf system-upgrade download --releasever=29 --allowerasing -y

# do the update
sudo dnf system-upgrade reboot