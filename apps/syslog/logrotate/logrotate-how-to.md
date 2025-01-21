edit
```
/etc/logrotate.d/app
```

add the parameters logrotate should honor

```ini
/var/log/app/* {
  monthly
  missingok
  rotate 10
  compress
  create
}
```