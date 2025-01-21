# Modifications to the ulog forwarder (UDM Pro)

- filter added to only allow the "denied" or "dropped" notices
- pattern for the log file:

```
    This part contains the relevant information: [WAN_IN-RET-3006]
    The pattern is as follows: [$INTERFACE_$CHAIN-$RESULT-$RULENUMBER]
    So this tells me: You have a rule in the Internet interface (WAN) on the "INcoming" chain. 
    It got "RETurned" aka accepted and the rule that wrote that log is the rule 3006 - which you will find when looking into Internet / IN.
    $INTERFACE, $CHAIN and $RULENUMBER should be self explaining.

    $RESULT codes are:

    RET = Accepted
    D = Dropped
    R = Rejected
```

rule

```sh
source s_ulogd {file("/var/log/ulog/syslogemu.log"); };
filter f_ulogd {not match("-RET-"); };
log {source(s_ulogd); filter(f_ulogd); destination(d_udapi_server_remote); };
```

possible addition to explicitly name other elements

```sh
filter f_ulogd { not match("-RET-" value("MESSAGE")) or match("-D-" value("MESSAGE")) match("-R-" value("MESSAGE")); };
```

log example

```log
UDM-Pro [LAN_LOCAL-RET-2147483647] DESCR="no rule description" IN=wgsts1000 OUT= MAC= SRC=192.168.0.92 DST=192.168.51.170 LEN=40 TOS=00 PREC=0x00 TTL=127 ID=4182 DF PROTO=TCP SPT=56040 DPT=22 SEQ=1035551519 ACK=2019387833 WINDOW=1024 ACK URGP=0 UID=0 GID=0 MARK=40000                                                                                                                                                                                         May 14 13:12:11 UDM-Pro [LAN_LOCAL-RET-2147483647] DESCR="no rule description" IN=wgsts1000 OUT= MAC= SRC=192.168.0.225 DST=192.168.6.1 LEN=52 TOS=00 PREC=0x00 TTL=62 ID=11002 DF PROTO=TCP SPT=1514 DPT=39543 SEQ=1950149923 ACK=1989825980 WINDOW=52883 ACK URGP=0 UID=0 GID=0 MARK=40000                                                                                                                                                                                        May 14 13:12:11 UDM-Pro [LAN_LOCAL-RET-2147483647] DESCR="no rule description" IN=wgsts1000 OUT= MAC= SRC=192.168.0.225 DST=192.168.6.1 LEN=52 TOS=00 PREC=0x00 TTL=62 ID=11003 DF PROTO=TCP SPT=1514 DPT=39543 SEQ=1950149923 ACK=1989827348 WINDOW=52883 ACK URGP=0 UID=0 GID=0 MARK=40000                                                                                                                                                                                        May 14 13:12:11 UDM-Pro [LAN_LOCAL-RET-2147483647] DESCR="no rule description" IN=wgsts1000 OUT= MAC= SRC=192.168.0.225 DST=192.168.6.1 LEN=52 TOS=00 PREC=0x00 TTL=62 ID=11004 DF PROTO=TCP SPT=1514 DPT=39543 SEQ=1950149923 ACK=1989828716 WINDOW=52883 ACK URGP=0 UID=0 GID=0 MARK=40000       
UDM-Pro [LAN_LOCAL-RET-2147483647] DESCR="no rule description" IN=wgsts1002 OUT= MAC= SRC=192.168.6.5 DST=224.0.0.5 LEN=84 TOS=00 PREC=0xC0 TTL=1 ID=27327 PROTO=89 MARK=60000
UDM-Pro [WAN_LOCAL-D-2147483647] DESCR="[WAN_LOCAL]Block All Other Tra" IN=ppp0 OUT= MAC=45:00:00:28:ae:33:00:00:f4:06:c0:45:c2:1a:87:9d:57:8a:b7:14:aa:70:47:c5:7b:0e SRC=194.26.135.157 DST=87.138.183.20 LEN=40 TOS=00 PREC=0x00 TTL=244 ID=44595 PROTO=TCP SPT=43632 DPT=18373 SEQ=2064539362 ACK=0 WINDOW=1024 SYN URGP=0 MARK=1a0000
```