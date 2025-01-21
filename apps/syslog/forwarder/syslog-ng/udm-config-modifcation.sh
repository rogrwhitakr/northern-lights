#! /usr/bin/env bash

printf "start"

# vars
syslog_remote_conf="/etc/syslog-ng/conf.d/udapi-server-remote.conf"

# file looks like this after initializing of the remote logging server settings via UI.
# we change:
# the protocol
# the destination address to IP, bc the UDM does not seem to be able to query the set dns server, and only uses the local resolver (which does not know the graylog server)

##
## Generated automatically by ubios-udapi-server
##
#
#destination d_udapi_server_remote { network("graylog.northern-lights.one" transport("udp") port(1514)); };
#rewrite r_udapi_server_remote_prefix { set("Pforzheim-SEE $PROGRAM", value("PROGRAM")); };
#filter f_udapi_server_remote_filter { level(debug .. emerg); };
#log {
#  source(s_src);
#  filter(f_udapi_server_remote_filter);
#  rewrite(r_udapi_server_remote_prefix);
#  destination(d_udapi_server_remote);
#};

sed --in-place 's/graylog.northern-lights.one/192.168.0.81/g' "${syslog_remote_conf}"
sed --in-place 's/udp/tcp/g' "${syslog_remote_conf}"

############################################################################################

ulogd_conf="/etc/syslog-ng/conf.d/ulogd.conf"

# restart snmpd
systemctl restart syslog-ng.service

printf "complete"
exit 0