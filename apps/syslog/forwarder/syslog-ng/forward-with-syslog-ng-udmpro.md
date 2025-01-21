# log using syslog-ng to the greylog instance

modify

```sh
/etc/syslog-ng/conf.d/udapi-server-remote.conf
```

```sh
    destination d_udapi_server_remote { network("192.168.0.225" transport("tcp") port(1514)); };
    rewrite r_udapi_server_remote_prefix { set("asder $PROGRAM", value("PROGRAM")); };
    filter f_udapi_server_remote_filter { level(debug .. emerg); };
    log {
      source(s_src);
      filter(f_udapi_server_remote_filter);
      rewrite(r_udapi_server_remote_prefix);
      destination(d_udapi_server_remote);
};
```

modify

```sh
/etc/syslog-ng/conf.d/ulogd.conf
```

this is the default
```sh
# Generated automatically by ubios-udapi-server
source s_ulogd { file("/var/log/ulog/syslogemu.log"); };
log { source(s_ulogd); destination(d_udapi_server_remote); };
```

```sh
source s_ulogd {file("/var/log/ulog/syslogemu.log"); };
filter f_ulogd {not match("-RET-"); };
log {source(s_ulogd); filter(f_ulogd); destination(d_udapi_server_remote); };
```