# default configuration

STRAUBING UDM PRO settings:

```
root@Straubing-SEE:~# cat /etc/syslog-ng/conf.d/udapi-server-remote.conf
#
# Generated automatically by ubios-udapi-server
#

destination d_udapi_server_remote { network("graylog.northern-lights.one" transport("udp") port(1514)); };
rewrite r_udapi_server_remote_prefix { set("Straubing-SEE $PROGRAM", value("PROGRAM")); };
filter f_udapi_server_remote_filter { level(debug .. emerg); };
log {
  source(s_src);
  filter(f_udapi_server_remote_filter);
  rewrite(r_udapi_server_remote_prefix);
  destination(d_udapi_server_remote);
};
```