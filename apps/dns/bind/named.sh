#! /usr/bin/bash

rm -vfr ~/named

network=192.168.150.0
dns_server_ip=192.168.150.254
subnet=255.255.255.0
gateway=xyz
domain=aurora.northern-lights.one
hostname=dns

echo -e "
network is ${RED}$network${NOC}
subnet is ${RED}$subnet${NOC}
domain is ${RED}$domain${NOC}"

########################################################################
#	creating files
########################################################################

# side note
# awking the IP address
#$(awk -F. '{print $1}' <#<< "$network")
#$(awk -F. '{print $2}' <<< "$network")
#$(awk -F. '{print $3}' <<< "$network")
#$(awk -F. '{print $4}' <<< "$network")

echo "$1st $2nd $3rd $4th"

echo -e "
${RED}creating internal and external zone files ${NOC}"

mkdir ~/named && cd ~/named

# config
touch named.conf

# internal
touch $domain.lan
touch ${3}.${2}.${1}.db 

# external
# we leave this for now
# touch $domain.wan
# touch 80.0.16.172.db

tee named.conf <<EOF
//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

options {
        # change ( listen all )
	listen-on port 53 { 127.0.0.1; 
        listen-on port 53 { any; };

        # change( if not use IPv6 )
        listen-on-v6 { none; };
        directory           "/var/named";
        dump-file           "/var/named/data/cache_dump.db";
        statistics-file     "/var/named/data/named_stats.txt";
        memstatistics-file  "/var/named/data/named_mem_stats.txt";

        # query range ( set internal server and so on )
        allow-query         { localhost; $network/24; };

        # transfer range ( set it if you have secondary DNS )
        allow-transfer      { localhost; $network/24; };

        recursion yes;

	# no fancy stuff yet
        dnssec-enable no;
        dnssec-validation no;

        /* Path to ISC DLV key */
        /* In case you want to use ISC DLV, please uncomment the following line..
        */
        //bindkeys-file "/etc/named.iscdlv.key";

        managed-keys-directory "/var/named/dynamic";
	
	# run stuff
        pid-file "/run/named/named.pid";
        session-keyfile "/run/named/session.key";

        /* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
        include "/etc/crypto-policies/back-ends/bind.config";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

#${1}.${2}.${3}.${4}
#${1}.${2}.${3}.${4}

# configure internal zone
view "internal" {
        match-clients {
                localhost;
                "${1}.${2}.${3}.${4}"/24;
        };
        zone "." IN {
                type hint;
                file "named.ca";
        };
        zone "$domain" IN {
                type master;
                file "$domain.lan";
                allow-update { none; };
        };
        zone "${3}.${2}.${1}.in-addr.arpa" IN {
                type master;
                file "${3}.${2}.${1}.db";
                allow-update { none; };
        };

# leaving these for now
# include "/etc/named.rfc1912.zones";
# include "/etc/named.root.key";
};

# no external config for now
#view "external" {
#        match-clients { any; };
#        allow-query { any; };
#        recursion no;
#        zone "$domain" IN {
#                type master;
#                file "$domain.wan";
#                allow-update { none; };
#        };
#        zone "80.0.16.172.in-addr.arpa" IN {
#                type master;
#                file "80.0.16.172.db";
#                allow-update { none; };
#        };
#};

# allow-query ? query range you permit
# allow-transfer ? the range you permit to transfer zone info
# recursion ? allow or not to search recursively
# view "internal" { *** }; ? write for internal definition
# view "external" { *** }; ? write for external definition
# For How to write for reverse resolving, Write network address reversely like follows
# 10.0.0.0/24
# network address? 10.0.0.0
# range of network? 10.0.0.0 - 10.0.0.255
# How to write? 0.0.10.in-addr.arpa
# 172.16.0.80/29
# network address? 172.16.0.80
# range of network? 172.16.0.80 - 172.16.0.87
# How to write? 80.0.16.172.in-addr.arpa
EOF

tee $domain.lan  <<EOF
// 
// 
// file /var/named/$hostname.$domain.lan
// 
// 
 

 $TTL 86400
@   IN  SOA     $hostname.$domain. root.$domain. (
        2016112201  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
        # define name server
        IN  NS      $hostname.$domain.
        # define name server's IP address
        IN  A       $dns_server_ip
        # define mail exchanger
        IN  MX 10   mail.$domain.
	# define IP address of a hostname
dlp     IN  A       ${1}.${2}.${3}.10

EOF
