# bin/sh

RED='\033[0;31m'
NOC='\033[0m' 

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

dnf install bind bind-utils -y

network=192.168.150.0
subnet=255.255.255.0
domain=northernlights


tee /etc/named.conf > /dev/null EOF

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
        dnssec-enable yes;
        dnssec-validation yes;

        /* Path to ISC DLV key */
        /* In case you want to use ISC DLV, please uncomment the following line..
        */
        //bindkeys-file "/etc/named.iscdlv.key";

        managed-keys-directory "/var/named/dynamic";

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

# change all from here
view "internal" {
        match-clients {
                localhost;
                $network/24;
        };
        zone "." IN {
                type hint;
                file "named.ca";
        };
        zone "srv.world" IN {
                type master;
                file "srv.world.lan";
                allow-update { none; };
        };
        zone "0.0.10.in-addr.arpa" IN {
                type master;
                file "0.0.10.db";
                allow-update { none; };
        };
include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
};
view "external" {
        match-clients { any; };
        allow-query { any; };
        recursion no;
        zone "srv.world" IN {
                type master;
                file "srv.world.wan";
                allow-update { none; };
        };
        zone "80.0.16.172.in-addr.arpa" IN {
                type master;
                file "80.0.16.172.db";
                allow-update { none; };
        };
};

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
