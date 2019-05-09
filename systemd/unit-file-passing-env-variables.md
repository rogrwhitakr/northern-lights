# How to pass enviroanment variables to systemd units

    [Unit]
    Description=default usage example for environment variables
  
1. put them into the unit file

        [Service]
        Environment=NORTHERNLIGHTS_PASS=aurora
        Environment=NORTHERNLIGHTS_PORT=8484


2. add them to a file (format = key/value)

        [Service]
        EnvironmentFile=/home/admin/aurora/ambers.env
    
3. current best practive is to edit the unit file

        sudo systemctl edit borg-backup.service
    
    insert the environment variable like so

        [Service]
        Environment="SECRET=pGNqduRFkB4K9C2vijOmUDa2kPtUhArN"
    
    file edited:

    /etc/systemd/system/<edited.service>.d/override.conf