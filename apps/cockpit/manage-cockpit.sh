#!/bin/bash

RED='\033[0;31m'
NOC='\033[0m' 

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#get certificate entry
remotectl certificate

if [ -f ( remotectl certificate | grep 'self-signed' ) ] ; then
	echo -e removing `remotectl certificate`
	read -n1 -p "Press enter to continue"
	
echo -e 
read -n1 -p "Press enter to continue"

CERT_FILE=/etc/pki/tls/certs/${hostname).pem
KEY_FILE=/etc/pki/tls/private/${hostname).key

getcert request -f ${CERT_FILE} -k ${KEY_FILE} -C "sed -n w/etc/cockpit/ws-certs.d/50-from-certmonger.cert ${CERT_FILE} ${KEY_FILE}"