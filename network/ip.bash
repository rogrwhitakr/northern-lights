#! /usr/bin/env bash
# explainer for the IP command

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

# looping through ip command objects
echo -e "${GREEN}looping through ip command objects${NOC}"

objects=("link" "address" "addrlabel" "route" "rule" "neigh"
	"ntable" "tunnel" "tuntap" "maddress" "mroute" "mrule"
	"monitor" "xfrm" "netns" "l2tp" "fou" "macsec" "tcp_metrics"
	"token" "netconf" "ila" "vrf" "sr")

echo -e "${RED}there are ${#objects[@]} objects${NOC}"
for object in "${objects[@]}"; do
	echo -e "${RED}Object: $object${NOC}"
	ip ${object}
done

# needs to move to another pleece
iw dev | awk '$1=="Interface"{print $2}'
