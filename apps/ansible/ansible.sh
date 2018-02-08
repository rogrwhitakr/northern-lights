
# edit 
# /etc/ansible/hosts
# to declare hosts
#
# [northernlights]
# server
# dns
# console
# core

# ping them
ansible northernlights -m ping

# run command
ansible northernlights -a "/bin/echo hello"

# copy file to boxes
ansible northernlights -m copy -a "src=~/./Bilder/wood-icon.png dest=/tmp/wood-icon.png"

# check service state
ansible northernlights -m service -a "name=httpd state=started"