# SYSTEMCTL

listing available unit files

```
systemctl list-unit-files 
```

list timers
```
systemctl list-timers 
systemctl list-timers --all
```

to start and enable a timer create the symlink:

```
sudo systemctl enable borg-backup.timer
sudo systemctl start borg-backup.timer
```

edit a unit file 

```
sudo systemctl edit borg-backup.service
```

has also a --full option

```
sudo systemctl edit --full nginx.service
```

Displaying a Unit File

```
systemctl cat postgresql.service
```

listing dependencies

```
systemctl list-dependencies sshd.service
```

check unit properties

```
systemctl show sshd.service
systemctl show postgresql.service
```

Masking and Unmasking Units
ability to mark a unit as completely unstartable, automatically or manually, by linking it to /dev/null.

```
sudo systemctl mask nginx.service
```

get the default target of the system

```
systemctl get-default
```
set a different default target
for example: graphical desktop -> boot into that by default

```
systemctl set-default graphical.target
```
