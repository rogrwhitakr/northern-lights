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
# dnf5
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

# install
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# add admin user to docker group

# manage group to allow users non-sudo docker control
sudo groupadd docker

# add user to docker group (unsure if complete!!)
sudo usermod -aG docker $(id -un)

# start service
sudo systemctl start docker


# docker forward to rsyslog
# - default log to json-file
# - To change it globally to journald, there has to be a change made to the file under ```/etc/docker/daemon.json```. 
# - This file may not exist. Please note that it has to be in a valid JSON format, otherwise Docker daemon will fail to start

# check log status
docker info --format '{{.LoggingDriver}}'

# add contents to /etc/docker/daemon.json
sudo nano /etc/docker/daemon.json

{
  "log-driver": "journald",
  "log-opts": {
    "tag": "docker/{{.Name}}"
  }
}
