
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

```sh
# gemini-version of this:
# 1. Globale Module laden
module(load="imuxsock")

# 2. Inputs (Eingänge) sauber definieren
input(type="imuxsock" Socket="/var/run/sshd/dev/log" CreatePath="on" Facility="authpriv")
input(type="imuxsock" Socket="/run/systemd/journal/syslog")

# 3. Graylog-Template für erweiterte Details definieren (RFC5424 / JSON-artig)
template(name="GraylogExtended" type="string"
         string="<%PRI%>%PROTOCOL-VERSION% %TIMESTAMP:::date-rfc3339% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% [meta env=\"production\" role=\"frontend\" layer=\"os\"] %MSG%\n")

# 4. Weiterleitung (Output) mit Queue-Schutz und Tagging
*.* action(
    type="omfwd" 
    target="graylog" 
    port="514" 
    protocol="tcp"
    template="GraylogExtended"
    
    # Ausfallsicherheit & Queue-Optimierung
    action.resumeRetryCount="-1"           # Unendlich oft versuchen statt nach 100 Abbrüchen aufzugeben
    queue.type="linkedList" 
    queue.size="50000"                     # Erhöht auf 50k, da TCP bei Last blockieren kann
    queue.discardmark="45000"              # Wenn 45k erreicht, fange an, unwichtige Logs zu verwerfen
    queue.discardseverity="6"              # Verwirf Info/Debug-Logs, wenn die Queue voll läuft
    queue.checkpointinterval="100"
    queue.saveonshutdown="on"              # Logs im RAM bei System-Shutdown auf Platte sichern
)

```

```sh
# GELF Format (graylogs own format, UDP port 12201)
# 1. Benötigte Module laden (imuxsock für Inputs, omgelf für den Output)
module(load="imuxsock")
module(load="omgelf")

# 2. Inputs (Eingänge)
input(type="imuxsock" Socket="/var/run/sshd/dev/log" CreatePath="on" Facility="authpriv")
input(type="imuxsock" Socket="/run/systemd/journal/syslog")

# 3. Das GELF-Ausgabe-Format konfigurieren (Hier setzen wir die Tags!)
*.* action(
    type="omgelf"
    target="graylog"
    port="12201"                 # ACHTUNG: GELF nutzt in Graylog meist Port 12201!
    protocol="udp"               # GELF wird im Netzwerk standardmäßig via UDP betrieben

    # Hier fügst du deine benutzerdefinierten "Pre-Details" und Tags hinzu:
    # In GELF MÜSSEN eigene Felder mit einem Unterstrich beginnen!
    custom_fields=["_env", "production", "_role", "frontend", "_layer", "os"]

    # Zuverlässigkeits-Queue (Identisch zu oben, schützt den Server bei Last)
    action.resumeRetryCount="-1"
    queue.type="linkedList"
    queue.size="50000"
    queue.discardmark="45000"
    queue.discardseverity="6"
    queue.saveonshutdown="on"
)

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

- better alternative (because it is structured data) is using GELF. CONfig:

```json
{
  "log-driver": "gelf",
  "log-opts": {
    "gelf-address": "udp://graylog.fritz.box:12201",
    "tag": "{{.Hostname}}-{{.Name}}-{{.ImageName}}"
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