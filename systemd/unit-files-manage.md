# HOW-TO configure custom system and user unit files

## system unit file (executed with privileges)

move unit files (*.service, *.timer, *.target) go to 

    /etc/systemd/system/

CUSTOM executables (bash, python scripts) go to

    /usr/lib/systemd/scripts/script.py

default unit files are found in 

    /usr/lib/systemd/system/

Permissions must be:

    * unit files
      chmod 622 
    * executables
      chmod 760

## user unit file

location:

units live in 

    ~/.config/systemd/user/<servicename>.service
    ~/.config/systemd/user/<servicename>.timer (in case of timer)

commands:

    systemctl --user daemon-reload
    systemctl --user <action> <unit file>


[unit::service]

requires an absolute path in the service file

    ExecStart=/home/admin/.config/systemd/user/user-backup.bash --timer

## Timer

requires two service files:

1. unit.service
2. unit.timer

service file syntax:

    [Service]
    Type=simple
    ExecStart="<service_script> --timer

timer file syntax

    [Timer]
    OnBootSec=1min
    OnUnitActiveSec=5min

commands:

    systemctl --user enable unit.timer
    systemctl --user start unit.timer

## Unit file syntax

check using systemd verify

    systemd-analyze verify "${unit}"