# unit file manage

    [Unit]
    Description=unit-part of a systemd file
    Description=https://www.freedesktop.org/software/systemd/man/systemd.service.html

    [Service]

    Type=oneshot  
    RemainAfterExit=yes  

    # Services declared as oneshot are expected to take some action and exit immediately
    # (thus, they are not really services, no running processes remain). 
    # A common pattern for these type of service is to be defined by a setup and a teardown action.

    # we must specify RemainAfterExit=true so that systemd considers the service as active
    # after the setup action is successfully finished

    # Das RemainAfterExit=yes bewirkt (zusammen mit oneshot), 
    # dass ExecStop erst beim Stop dieser Unit ausgeführt wird.
    # Ohne diese Einstellung würde ExecStop unmittelbar nach ExecStart, 
    # also noch während des Hochfahrens, ausgeführt

    Type=forking
    PIDFile=/<path>/<to>/<PIDFILE>
    # Type=forking for unit files with ExecStart and ExecStop using existing scripts
    # Type=forking should contain PIDFile

    Type=simple
    ExecStop=/bin/kill -9 $MAINPID
    # "simple" requires a Stop-Mechanism 
    # Systemd does not forkthe prcess -> "kill -9 $MAINPID" works
    # Falls kein Stopscript vorhanden ist, kann Type=simple die einfachste Lösung sein
    # as the start process exits, then we want to ceep track of the spawned process to 
    # execStop it ?


    RestartSec=15
    Restart=always
    # restarts a service every 15 secs