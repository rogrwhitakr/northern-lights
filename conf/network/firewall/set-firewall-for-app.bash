#! /usr/bin/env bash

# source the printer
# source ~/.bashrc.d/printer.bash
# source ~/northern-lights/script/helpers/printer.bash

# _name=jenkins
# _port=8080

echo -e "this script creates a firewall opening for an application.\nIt creates a service, uses default tcp-out port bindings for this new service.\nAnything more advanced, use \"firewall-cmd\"."

# service name
read -rsp $'set name: ' _name
# parameter expansion: repaceing spaces with dashes, as spaces not allowed by firewall-cmd
_name=${_name//[^a-zA-Z_0-9]/-}
echo -e "set name to \"${_name}\""

# ports
read -rsp $'set port(s):\n-> separate all ports by a space !\n' _port
echo -e "set port(s) to \"${_port}\""
echo -e "setting firewall opening for service ${_name} on port(s) ${_port}"
echo -e "sudo may be required"
read -rp $'Continue (Y/N) : ' -ei $'Y' _continue

if [[ "${_continue^^}" == "Y" ]]; then

    echo -e "Firewall Status:"
    sudo firewall-cmd --state

    echo -e "adding service for ${_name}:"

    if [[ "$(sudo firewall-cmd --list-services | grep "${_name}")" ]]; then
        echo -e "service \"${_name}\" already exists"
    else
        sudo firewall-cmd --permanent --new-service="${_name}"
    fi

    echo -e "adding description to service for ${_name}:"
    sudo firewall-cmd --permanent --service="${_name}" --set-short=""${_name}" Service Ports"
    sudo firewall-cmd --permanent --service="${_name}" --set-description="port exceptions for application "${_name}" created by $USER on $(date)"

    # adding ports
    # unquoted port argument expands the string
    for i in ${_port}; do
        sudo firewall-cmd --permanent --service="${_name}" --add-port="${i}"/tcp
    done

    # add the service to the default zone
    sudo firewall-cmd --permanent --add-service="${_name}"
    #    sudo firewall-cmd --zone=public --add-service=http --permanent
    sudo firewall-cmd --reload
    sudo firewall-cmd --info-service="${_name}"

else
    echo -e "Exiting by choice"
    exit 0
fi
