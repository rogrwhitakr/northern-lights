
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

# get ansible system info
ansible all -m setup

# get only the setup info for server "server", taken from inventory file
ansible -i ~/.ansible/hosts.yaml server -m setup
