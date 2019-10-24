#! /usr/bin/env bash

# source the printer
# source ~/.bashrc.d/printer.bash
# source ~/northern-lights/script/helpers/printer.bash

# _name=jenkins
# _port=8080

echo -e "this function does xy"

read -rsp $'set name:\n' _name
echo -e "set name to \"${_name}\""
read -rsp $'set port: \n' _port
echo -e "set port to \"${_port}\""
echo -e "setting fireall opening for service ${_name} on port ${_port}"
echo -e "sudo may be required"
read -rp $'Continue (Y/N) : ' -ei $'Y' _continue;

if [[ "${_continue^^}" == "Y" ]]; then

    echo -e "Firewall Status:"
    sudo firewall-cmd --state

    echo -e "adding service for ${_name}:"

    if [[ "$(sudo firewall-cmd --list-services | grep "${_name}")" ]]; then
        echo -e "service \"${_name}\" already exists"
    else
        sudo firewall-cmd --permanent --new-service="${_name}"
    fi

    echo -e "adding service for ${_name}:"
    sudo firewall-cmd --permanent --service="${_name}" --set-short=""${_name}" Service Ports"
    sudo firewall-cmd --permanent --service="${_name}" --set-description=""${_name}" service firewalld port exceptions"
    sudo firewall-cmd --permanent --service="${_name}" --add-port="${_port}"/tcp
    sudo firewall-cmd --permanent --service="${_name}" --add-port=42345/tcp
    sudo firewall-cmd --permanent --add-service="${_name}"
#    sudo firewall-cmd --zone=public --add-service=http --permanent
    sudo firewall-cmd --reload
    sudo firewall-cmd --info-service="${_name}"

else
    echo -e "Exiting by choice"
    exit 0
fi


