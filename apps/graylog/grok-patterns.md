# GROKs

UFW

```
%{SYSLOGTIMESTAMP:timestamp} %{SYSLOGHOST:hostname} %{DATA:program}:\[%{NUMBER:pid}\] \[%{DATA:action}\] IN=%{DATA:input_interface} OUT=%{DATA:output_interface} MAC=%{DATA:mac_address} SRC=%{IP:source_ip} DST=%{IP:destination_ip} LEN=%{NUMBER:length} TOS=%{DATA:tos} PREC=%{DATA:prec} TTL=%{NUMBER:ttl} ID=%{NUMBER:id} PROTO=%{DATA:protocol} SPT=%{NUMBER:source_port} DPT=%{NUMBER:destination_port} LEN=%{NUMBER:packet_length}
```

# for docker logs in syslog

must be refined...
%{DATA:service} %{DATA:container}\[%{NUMBER:pid}\]: %{NUMBER:instance}:%{WORD:status} %{DATA:timestamp} \* %{DATA:message}

