#! /usr/bin/env bash
# explainer for the IP command

looping through ip command objects:

objects=("link" "address" "addrlabel" "route" "rule" "neigh"
	"ntable" "tunnel" "tuntap" "maddress" "mroute" "mrule"
	"monitor" "xfrm" "netns" "l2tp" "fou" "macsec" "tcp_metrics"
	"token" "netconf" "ila" "vrf" "sr")

echo -e "there are ${#objects[@]} objects:"
for object in "${objects[@]}"; do
	echo "Object: $object"
    ip ${object}
done
