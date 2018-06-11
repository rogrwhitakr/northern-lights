#! /usr/bin/env bash

remote_user="admin"
vm="IAV.Cortez"

# query local status ?

systemctl status virtual-machines.service

if [[ "$?" != "0" ]]; then
    echo "nuffingk!"
else
    echo "tru"
fi    

# copy bulk / whole directories
scp -r ~/MyScripts ${remote_user}@${vm}:~/

# this does not have the option of excluding
# stackoverflow suggestions:
# using find
# although it already does what i want it to do, hmmm

echo "done"