
# HOW-TO log to the greylog instance

create / add to

```sh
/etc/rsyslog.d/99-graylog.conf
```

## config value

```sh
# listen
*.*  action(type="omfwd" target="graylog" port="514" protocol="tcp"
            action.resumeRetryCount="100"
            queue.type="linkedList" queue.size="10000")

# ssh test
input(type="imuxsock" Socket="/var/run/sshd/dev/log" CreatePath="on")

# journald
input(type="imuxsock" Socket="/run/systemd/journal/syslog")       

# that should work in theory, but the file must be readable by the syslog user
# docker
module(load="imfile")
input(type="imfile" File="/var/log/elasticsearch/*.log" Tag="docker")
```

# docker

 - default log to json-file
 - To change it globally to journald, there has to be a change made to the file under ```/etc/docker/daemon.json```. 
 - This file may not exist. Please note that it has to be in a valid JSON format, otherwise Docker daemon will fail to start

```sh
# check log status
docker info --format '{{.LoggingDriver}}'

# contents of /etc/docker/daemon.json
{
  "log-driver": "journald",
  "log-opts": {
    "tag": "docker/{{.Name}}"
  }
}

```



restart the rsyslogd

```sh
systemctl restart rsyslog.service
```

## set timezone

```sh
sudo timedatectl set-timezone Europe/Berlin
```


## proxmox setup

```sh
# install syslog
apt install rsyslog -y

# edit the file
nano /etc/rsyslog.d/99-graylog.conf

# listen
*.*  action(type="omfwd" target="graylog" port="514" protocol="tcp"
            action.resumeRetryCount="100"
            queue.type="linkedList" queue.size="10000")

# ssh test
input(type="imuxsock" Socket="/var/run/sshd/dev/log" CreatePath="on")

# journald
input(type="imuxsock" Socket="/run/systemd/journal/syslog")

# proxmox tasks
module(load="imfile")
input(type="imfile" File="/var/log/pve/tasks/index" Tag="proxmox-task")
```