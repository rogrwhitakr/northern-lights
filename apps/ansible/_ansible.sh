
# edit 
# /etc/ansible/hosts
# to declare hosts
#
# [northernlights]
# server
# dns
# console
# core

# host must be contained within 
/etc/ansible/hosts

# exec simple update playbook
ansible-playbook ~/MyScripts/apps/ansible/playbook_update.yml --ask-become-pass
 
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
ansible -i ~/.ansible/hosts.yml server -m setup
ansible -i ~/.ansible/hosts.yml northernlights -m ping

# found that local ansible used python2. the corresponding machines require python2 also
# otherwise the test-ping errored out
ansible --version | grep "python version"

# maybe mitigate by using command like so: (untested)
ansible-playbook3

# this one works as of ansible 2.5, but uses the depricated --ask-sudo-pass. must be replaced by "become" method
ansible-playbook playbook_update.yml --ask-sudo-pass

# list the hosts the are going to be affected (contained within playbook hosts: <hosts>)
# TODO: how to work ONE playbook with different boxes that have different admin user creds... 
ansible-playbook playbook_update.yml --list-hosts

# there are 16!! var fields / locations that ansible reads from. it uses whatever it finds first
# so if default dir is /home/admin/apps/ansible -> this directory can contain a config file that applies (and only that?)
# i need to find some more of these redhat videos, the first one was pretty solid

# pass an extra var that has been defined in the yaml
# yaml looks like this:
# ---
# - name: Shutdown a remote computer
#   hosts: "{{ host }}"
ansible-playbook ~/MyScripts/apps/ansible/shutdown.yml --extra-vars="host=cortez" --ask-become-pass