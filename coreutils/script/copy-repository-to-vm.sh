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

echo "done"