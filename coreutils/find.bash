#!/usr/bin/env sh

# seach the root for all files containing the word 'profile'
sudo find / -name *profile*

# seach and exec 
sudo find / -name pg_hba.conf -exec nano {} \;

# find from local all files
find . -type f
find . -type f -name "*.sh"

# do a multiple name search
find . -type f \( -name "*.css" -or -name "*.html" \)

# delete every single file, excluding directories, below the current working directory
find . ! -type d -delete
find . ! -type d -exec rm '{}'	  

# find logs that are not owned or group-owned by root
# remove guid if necessary
# most just own the file to write to it but dont bother to set this guid
sudo find /var/log -type f ! -gid 0 ! -uid 0 -exec ls -lah {} \;

# find all files within web server directory not owned or group owned by web server user apache
find /var/www/html -type f ! -uid $(id -u "apache") ! -gid $(id -g "apache") -print
find /var/www/html -type f ! -uid $(id -u "apache") ! -gid $(id -g "apache") -exec chown apache.apache {} \;

# find backup log, that is sized > 1, < 2 MB
sudo find . -name data_backup.log -size +1M -not -size +2M