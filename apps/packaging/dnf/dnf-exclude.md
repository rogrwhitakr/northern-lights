# exclusion while installing / upgrading / ...

## exclude packages

- accepts wildcards

```sh
dnf update --exclude=zabbix*
```

## exclude repositories

- use only the official zabbix repo 
- do not use the outdated stuff that is bundled with the version of fedora for some reason

```sh
dnf update --exclude=zabbix*
```