# HOW TO CONFIGURE CUSTOM UNIT FILES (EXECUTED WITH PRIVILEGES)

CUSTOM unit files (*.service, *.timer, *.target) go to 
   /etc/systemd/system/

default unit files are found in 
    /usr/lib/systemd/system/

CUSTOM executables (*.bash, python scripts) go to
    /usr/lib/systemd/scripts/script.py

Permissions must be:
+ unit files
  chmod 622 

+ executables
  chmod 760