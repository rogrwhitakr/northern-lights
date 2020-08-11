#! /usr/bin/env bash

if [[ -z ${1} ]]; then
    printf "you must provide a file!" 
    exit 1
fi

# delete lines that have "host down" 
sed -i '/host down/d' $1

# delete status info
sed -i '/^Ping Scan Timing/d' $1
sed -i '/^Scanning/d' $1

sed -i '/^Initiating Ping Scan/d' $1
sed -i '/^Completed Ping Scan/d' $1

sed -i '/^Initiating Parallel DNS resolution/d' $1
sed -i '/^Completed Parallel DNS resolution/d' $1

# delete lines that have "host is up" 
sed -i '/Host is up/d' $1

# delete intro line 
sed -i '/Starting Nmap/d' $1

# delete empties
sed -i '/^$/d' $1

# remove the "report for ..:"
sed -i 's/Nmap\ scan\ report\ for\ //' $1

# delete the last two lines
sed -i '$d' $1
sed -i '$d' $1

column -t $1
