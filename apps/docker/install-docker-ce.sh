!# /usr/bin/env bash

# this script installs docker-ce 

# we remove old versions
sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine

# Set up the repository
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# install
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# add admin user to docker group

# manage group to allow users non-sudo docker control
sudo groupadd docker

# add user to docker group (unsure if complete!!)
useradd -aG docker

# start service
sudo systemctl start docker