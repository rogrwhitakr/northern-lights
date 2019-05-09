# HOW TO CONFIGURE CUSTOM UNIT FILES (EXECUTED WITH PRIVILEGES)

 * CUSTOM unit files (*.service, *.timer, *.target) to
    /etc/systemd/system/

* the default unit files are found in 
    /usr/lib/systemd/system/

 * CUSTOM executables (*.sh) to
    /usr/lib/systemd/scripts/$service_name.sh

 * PERMISSINOS ON THESE FILES:
 * UNIT FILES
    chmod 622 

 * EXECS
    chmod 760