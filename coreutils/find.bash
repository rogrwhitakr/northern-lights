#!/usr/bin/env bash

# seach the root for all files containing the word 'profile'
sudo find / -name *profile*

# seach and exec 
sudo find / -name pg_hba.conf -exec nano {} \;

# find from loacl all files
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