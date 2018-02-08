
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